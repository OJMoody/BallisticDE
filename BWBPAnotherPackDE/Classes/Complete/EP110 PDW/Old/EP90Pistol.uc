//=============================================================================
// AH104Pistol.
//
// A powerful sidearm designed for long range combat. The .600 bulelts are very
// powerful. Secondary is a laser attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class EP90Pistol extends BallisticWeapon;

var   bool			bLaserOn;

var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			ModeCycleSound;
var() Sound			LaserOffSound;
var() Sound			ExhaustSound;

var   Emitter		LaserDot;



replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	ServerSwitchlaser(true);
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'BallisticDE.LaserActor_G5Painter');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if ( ThirdPersonActor != None )
		EP90Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}


simulated function SetBurstModeProps()
{
	if (CurrentWeaponMode == 1)
	{
		BFireMode[0].FireRate = 0.09;
		BFireMode[0].RecoilPerShot = 128;
		BFireMode[0].FireChaos = 0.25;
		BFireMode[0].FlashScaleFactor = 0.85;
     		RecoilDeclineDelay=default.RecoilDeclineDelay;
			BallisticProInstantFire(FireMode[0]).Damage = 60;
			BallisticProInstantFire(FireMode[0]).DamageHead = 90;
			BallisticProInstantFire(FireMode[0]).DamageLimb = 50;
	}
	else if (CurrentWeaponMode == 2)
	{
		BallisticProInstantFire(FireMode[0]).FireRate = 0.25;
		BallisticProInstantFire(FireMode[0]).RecoilPerShot = 256;
		BallisticProInstantFire(FireMode[0]).FireChaos = 0.35;
		BFireMode[0].FlashScaleFactor = 0.55;
     		RecoilDeclineDelay=0.200000;
			BallisticProInstantFire(FireMode[0]).Damage = 40;
			BallisticProInstantFire(FireMode[0]).DamageHead = 60;
			BallisticProInstantFire(FireMode[0]).DamageLimb = 35;
	}
	else
	{
		BFireMode[0].FireRate = BFireMode[0].default.FireRate;
		BFireMode[0].RecoilPerShot = BFireMode[0].default.RecoilPerShot;
		BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
		BFireMode[0].FlashScaleFactor = BFireMode[0].default.FlashScaleFactor;
     		RecoilDeclineDelay=default.RecoilDeclineDelay;
		BallisticProInstantFire(FireMode[0]).Damage = BallisticInstantFire(FireMode[0]).default.damage;
		BallisticProInstantFire(FireMode[0]).DamageHead = BallisticInstantFire(FireMode[0]).default.damagehead;
		BallisticProInstantFire(FireMode[0]).DamageLimb = BallisticInstantFire(FireMode[0]).default.damagelimb;
	}
}


simulated function TickFireCounter (float DT)
{
    if (CurrentWeaponMode == 1)
    {
        if (!IsFiring() && FireCount > 0 && FireMode[0].NextFireTime - level.TimeSeconds < -1.5)
           	FireCount = 0;
    }
    else
        super.TickFireCounter(DT);
}

simulated function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	else if (FireMode[0].NextFireTime - level.TimeSeconds < -0.1)
{
		super.ServerSwitchWeaponMode (NewMode);
		SetBurstModeProps();
}
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}
function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = bLaserOn;
	if (ThirdPersonActor!=None)
		EP90Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}



simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,3.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,3.7,,32);
	}
	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();
	bUseNetAim = bLaserOn;
}


//Draw special weapon info on the hud
/*simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	if (bLaserOn)	{
		CrosshairCfg.Color1.A /= 2;
		CrosshairCfg.Color2.A /= 2;
	}
	Super.NewDrawWeaponInfo (C, YPos);

	if (bLaserOn)	{
		CrosshairCfg.Color1.A = default.CrosshairCfg.Color1.A ;
		CrosshairCfg.Color2.A = default.CrosshairCfg.Color2.A ;
	}
}*/

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'BallisticDE.G5LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			EP90Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'Fire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = bScopeView || bLaserOn;
	if (bScopeView)
	{
		ViewRecoilFactor = 0.3;
		ChaosDeclineTime *= 1.5;
	}
}

// Targeted hurt radius moved here to avoid crashing

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, optional Pawn ExcludedPawn )
{
    local actor Victims;
    local float damageScale, dist;
    local vector dir;

    if( bHurtEntry ) //not handled well...
        return;

    bHurtEntry = true;

    foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
    {
        // don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
        if( (Victims != self) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') && (ExcludedPawn == None || Victims != ExcludedPawn))
        {
            dir = Victims.Location - HitLocation;
            dist = FMax(1,VSize(dir));
            dir = dir/dist;
            damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
            class'BallisticDamageType'.static.GenericHurt
            (
                Victims,
                damageScale * DamageAmount,
                Instigator,
                Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
                (damageScale * Momentum * dir),
                DamageType
            );
        }
    }
    bHurtEntry = false;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     LaserOnSound=Sound'PackageSounds4.AH104.AH104-SightOn'
     ExhaustSound=Sound'PackageSounds4.EP90.EP90-Exhaust'
     ModeCycleSound=Sound'PackageSounds4.AH104.AH104-ModeCycle'
     LaserOffSound=Sound'PackageSounds4.AH104.AH104-SightOff'
     PlayerSpeedFactor=1.100000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticRecolors5.AH104.BigIcon_AH104'
     SightFXClass=Class'BallisticDE.AM67SightLEDs'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="120.0;15.0;0.8;70.0;0.75;0.5;0.0")
     BringUpSound=(Sound=Sound'PackageSounds4.EP90.EP90-Draw')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=9
     CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipIn')
     ReloadAnimRate=1.500000
     CockAnimRate=1.500000
     ClipInFrame=0.650000
     bCockOnEmpty=False
     bNeedCock=False
     WeaponModes(0)=(ModeName="Charged Pulse")
     WeaponModes(1)=(ModeName="Triple Pulse",Value=3.000000)
     WeaponModes(2)=(ModeName="Single Pulse",ModeID="WM_SemiAuto",Value=1.000000)
     CurrentWeaponMode=0
     SightPivot=(Pitch=1024,Roll=-1024)
     SightOffset=(X=-15.000000,Y=-0.700000,Z=12.300000)
     SightDisplayFOV=40.000000
     GunLength=4.000000
     JumpOffSet=(Pitch=1000,Yaw=-500)
     JumpChaos=0.300000
     AimAdjustTime=0.600000
     ViewAimFactor=0.300000
     ViewRecoilFactor=0.100000
     ChaosDeclineTime=0.450000
     //ChaosTurnThreshold=200000.000000
     ChaosSpeedThreshold=1250.000000
     AimSpread=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-20.000000,Max=30.000000))
     ChaosAimSpread=(X=(Min=-512.000000,Max=512.000000),Y=(Min=-512.000000,Max=512.000000))
     RecoilYawFactor=0.000000
     RecoilPitchFactor=1.000000
     RecoilXFactor=0.100000
     RecoilYFactor=0.100000
     RecoilMax=2000.000000
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.500000
     FireModeClass(0)=Class'BWBPArchivePackDE.EP90PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.EP90SecondaryFire'
     PutDownTime=0.600000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     Description="AH-104 'Pounder' Assault Pistol||Manufacturer: Enravion Combat Solutions|Primary: HEAT Rounds|Secondary: Laser Sight||'The Desert Eagle of the future.' Those were the words of Enravion as they publically released this modified version of the AM67. Nicknamed the 'Pounder' for its potent .600 explosive armor piercing rounds; the AH104 comes equipped with a laser targeting system in place of the usual flash bulb. Its immense stopping power and anti-armor capability make this weapon a favorite of military leaders and personnel across the worlds. The AH104 is known to be absurdly heavy due to its large rounds and cannot be dual wielded."
     Priority=162
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=6
     PickupClass=Class'BWBPArchivePackDE.EP90Pickup'
     PlayerViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
     BobDamping=1.200000
     AttachmentClass=Class'BWBPArchivePackDE.EP90Attachment'
     IconMaterial=Texture'BallisticRecolors5.AH104.SmallIcon_AH104'
     IconCoords=(X2=127,Y2=31)
     ItemName="[Beta] EP90 Fusion Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.AM67Pistol'
     DrawScale=0.200000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors5.AH104.AH999-Main'
}
