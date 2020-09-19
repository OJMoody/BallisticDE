//=============================================================================
// A42SkrithPistol.
//
// Alien energy sidearm with recharging ammo, a rapid fire projectile fire for
// primary and a charged up beam for secondary. Primary heals vehicles and
// power nodes,
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A85SkrithShotgun extends BallisticWeapon;

var float NextAmmoTickTime;
var Actor GlowFX;

var byte OldWeaponMode;

/*
simulated function PostNetBeginPlay()
{
	bNoReloading=false;
    Super.PostNetBeginPlay();
}

simulated function PostNetBeginPlay()
{
    Super(Weapon).PostNetBeginPlay();


	ChaosAimSpread *= BCRepClass.default.AccuracyScale;

	if (level.NetMode == NM_Client)
		ServerSetViewAimScale(ViewAimScale*255, ViewRecoilScale*255, bUseScopeViewAim);
}
*/

simulated function bool CanAlternate(int Mode)
{
	return false;

}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

}
simulated function bool MayNeedReload(byte Mode, float Load)
{
	return false;
}

function ServerStartReload (optional byte i);

simulated function string GetHUDAmmoText(int Mode)
{
	return "";
}

simulated function float AmmoStatus(optional int Mode)
{
    return float(MagAmmo) / float(default.MagAmmo);
}

simulated event Timer()
{

	super.Timer();
}

simulated event Destroyed()
{

	super.Destroyed();
}

simulated event Tick (float DT)
{
	super.Tick(DT);

	if (NextAmmoTickTime < level.TimeSeconds)
	{
		if (MagAmmo < Default.MagAmmo)
			MagAmmo+=5;
		NextAmmoTickTime = level.TimeSeconds + 1.0;
	}
}

simulated function TickFireCounter (float DT)
{
	if (CurrentWeaponMode == 1)
	{
		if (!IsFiring() && FireCount > 0 && FireMode[0].NextFireTime - level.TimeSeconds < -0.5)
			FireCount = 0;
	}
	else
		super.TickFireCounter(DT);
}

simulated event WeaponTick(float DT)
{
	local float f;
	super.WeaponTick(DT);

	if (CurrentWeaponMode != OldWeaponMode)
	{
		if (CurrentWeaponMode == 1)
			FireMode[0].FireRate = 0.08;
		else
			FireMode[0].FireRate = FireMode[0].default.FireRate;
		OldWeaponMode = CurrentWeaponMode;
	}


	if (FireMode[1].IsFiring())
	{
		f = 56 + 32 * (FMin(FireMode[1].HoldTime, 2) / 2);
		SoundPitch = f;
	}
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return Rand(2);

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (AmmoAmount(0) < 40)
		return 0;

	if (B.Squad!=None)
	{
		if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
			|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	    	 && (B.Enemy == None || !B.EnemyVisible()) )
			return 0;
		if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
			return 0;

		V = B.Squad.GetLinkVehicle(B);
		if ( V == None )
			V = Vehicle(B.MoveTarget);
		if ( V == B.Target )
			return 0;
		if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
			return 0;
	}

	if (FRand() < Dist/1500)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;
	local DestroyableObjective O;
	local Vehicle V;



	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	V = B.Squad.GetLinkVehicle(B);
	if ( (V != None)
		&& (VSize(Instigator.Location - V.Location) < 1.5 * FireMode[0].MaxRange())
		&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
		return 1.1;

	if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * FireMode[0].MaxRange()
	     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
		return 1.1;

	O = DestroyableObjective(B.Squad.SquadObjective);
	if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	     && VSize(Instigator.Location - O.Location) < 1.1 * FireMode[0].MaxRange() && B.LineOfSightTo(O) )
		return 1.1;

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();

	if (Dist > 1500)
		Result -= (Dist-1500) / 1500;
	else if (Dist < 500)
		Result -= 0.1;
	else if (Dist > 1000 && AmmoAmount(0) < 50)
		return Result -= 0.1;;

	return Result;
}

function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if (!bLeaderFiring)
		return false;
	if ( (Vehicle(LeaderPawn) != None) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < FireMode[0].MaxRange() )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}
	return false;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.4;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====

simulated function float ChargeBar()
{
	return FMin(FireMode[1].HoldTime, 1);
}

defaultproperties
{
     PlayerSpeedFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWSkrithRecolors1Tex.Main.BigIcon_SkrithShotgun'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Shotgun=True
     bWT_RapidProj=True
     bWT_Energy=True
     SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.A42.A42-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A42.A42-Putaway')
     MagAmmo=180
     bNonCocking=True
     SightPivot=(Pitch=512,Roll=0)
     SightOffset=(X=0.000000,Y=0.3500000,Z=14.000000)
     SightDisplayFOV=40.000000
     GunLength=40.000000
     JumpOffSet=(Pitch=500)
     JumpChaos=0.050000
     AimSpread=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000))
     ViewAimFactor=0.050000
     ViewRecoilFactor=0.100000
     ChaosDeclineTime=1.000000
     ChaosSpeedThreshold=1300.000000
     ChaosAimSpread=(X=(Min=-2048.000000,Max=2048.000000))
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=-0.500000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilMax=512.000000
     RecoilDeclineTime=1.000000
     RecoilDeclineDelay=0.100000
     FireModeClass(0)=Class'BWBPArchivePackDE.A85PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.A85SecondaryFire'
     BringUpTime=0.300000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     bShowChargingBar=True
     Description="A85 Skrith Compact Shotgun||Manufacturer: Unknown Skrith Engineers|Primary: Single Energy Fire|Secondary: Triple Energy Fire||The A85 is a new addition to the Skriths' ever-expanding array of deadly weapons. Its primary fire is on par with that of the A42, and its secondary fires 3 energy-based projectiles in a spread. It lacks the sheer killing power that makes the A500 'Reptile' so feared, but its light weight and low recoil allow for two to be held at once. That, along with its rechargeable battery and relative accuracy make it a decent alternative."
     Priority=7
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     GroupOffset=6
     PickupClass=Class'BWBPArchivePackDE.A85Pickup'
     PlayerViewOffset=(X=6.000000,Y=8.000000,Z=-10.000000)
     BobDamping=1.600000
     AttachmentClass=Class'BWBPArchivePackDE.A85Attachment'
     IconMaterial=Texture'BWSkrithRecolors1Tex.Main.SmallIcon_SkrithShotgun'
     IconCoords=(X2=127,Y2=31)
     ItemName="A85 Skrith Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWSkrithRecolors1Anim.SkrithShotgun'
     DrawScale=0.450000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticWeapons2.A73.A73AmmoSkin'
     Skins(2)=Shader'BWSkrithRecolors1Tex.Main.SkrithShotgunSkinA_Shader'
     Skins(3)=Texture'BWSkrithRecolors1Tex.Main.SkrithShotgunSkinB'
     Skins(4)=Shader'BWSkrithRecolors1Tex.Main.SkrithShotgunSkinC_Shader'
     SoundPitch=56
     SoundRadius=32.000000
}
