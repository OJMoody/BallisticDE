//=============================================================================
// AK47BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BarrierRifle extends BallisticWeapon;

var float NextAmmoTickTime;
var Actor GlowFX;

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (GlowFX != None)
		GlowFX.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	GlowFX = None;
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'BarrierSightFX', DrawScale, self, 'tip');
		if (GlowFX != None)
		{
		GlowFX.SetRelativeRotation(rot(0,0,32768));
		}
	}
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

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

simulated event Tick (float DT)
{
	super.Tick(DT);

	if (NextAmmoTickTime < level.TimeSeconds)
	{
		if (MagAmmo < 25)
			MagAmmo=Min(25, MagAmmo+1);
		NextAmmoTickTime = level.TimeSeconds + 0.1;
	}
}

simulated event WeaponTick(float DT)
{
	local float f;
	super.WeaponTick(DT);

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

simulated function MomentumAmmo(pawn Victim, float AppliedDmg)
{
	local float AmmoAdded;
	if (Victim != None && Victim != Instigator)
	{	
		AmmoAdded = AppliedDmg;
		MagAmmo=Min(default.MagAmmo, MagAmmo+AmmoAdded);
	}
}

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A42'
     BigIconCoords=(X1=80,Y1=24,X2=410,Y2=230)
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_RapidProj=True
     bWT_Energy=True
     SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.A42.A42-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A42.A42-Putaway')
     MagAmmo=100
     bNonCocking=True
     bNoCrosshairInScope=True
     SightOffset=(X=-5.000000,Y=-0.300000,Z=11.550000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     SightAimFactor=0.000000
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=768
     RecoilXCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=-0.500000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilDeclineTime=1.000000
     RecoilDeclineDelay=0.200000
     FireModeClass(0)=Class'BWBPAnotherPackDE.BarrierPrimaryFire'
     FireModeClass(1)=Class'BWBPAnotherPackDE.BarrierSecondaryFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
	 Bobdamping=2.2
     Description="Kinetic Manipulator||Manufacturer: Unknown Skrith Engineers|Primary: Slower moving, Energy Fire|Secondary: Instant Beam||It has a fast fire rate, rechargeable batteries, a good accuracy, low damage, and every Skrith has one. The infamous A42 'Whip', as it was named by the UTC Marines, has been the standard issue Skrith sidearm in both wars. Though it may be accurate, have a fast rate of fire and an unlimited, rechargeable cell, the A42 does very little damage, and has less accuracy than others when running, making it an all-round ineffective weapon. The secondary attack is a recent feature, giving the weapon the ability to charge up a variable shot. This does make the weapon more powerful, yet it is still not as effective as other sidearms. The rechargable cell however, means that it is always there when you need the extra bit of range over the melee weapons."
     Priority=16
     HudColor=(B=255,G=175,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPAnotherPackDE.BarrierPickup'
     PlayerViewOffset=(X=6.000000,Y=4.000000,Z=-9.000000)
     AttachmentClass=Class'BWBPAnotherPackDE.BarrierAttachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A42'
     IconCoords=(X2=127,Y2=31)
     ItemName="SAC Kinetic Manipulator"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBPAnotherPackAnims.FPm_SAC'
     DrawScale=1.000000
     SoundPitch=56
     SoundRadius=32.000000
}
