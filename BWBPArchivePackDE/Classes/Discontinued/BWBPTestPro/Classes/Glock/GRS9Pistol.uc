//=============================================================================
// GRS9Pistol.
//
// Glock style low power, high capacity, low recoil, high accuracy light pistol
// with low power burning laser attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9Pistol extends BallisticHandgun;

var   bool			bLaserOn;
var   LaserActor	Laser;
var   Emitter		LaserBlast;
var   Emitter		LaserDot;
var	  byte			CurrentWeaponMode2;
var	  Actor			GlowFX;// SightFX;
var() float			LaserAmmo;
var   bool			bBigLaser;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn, LaserAmmo;
}

//simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}
simulated function bool SlaveCanUseMode(int Mode)
{
	return Mode == 0 || GRS9Pistol(OtherGun) != None;
}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0 && OtherGun != None && GRS9Pistol(Othergun) != None)
		return false;
	return super.CanAlternate(Mode);
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);
	if (GlowFX != None)
	{
		GRS9AmbientFX(GlowFX).SetReadyIndicator (FireMode[1]!=None && !FireMode[1].IsFiring() && level.TimeSeconds - GRS9SecondaryFire(FireMode[1]).StopFireTime >= 0.8 && LaserAmmo > 0);
		if (FireMode[1]!=None && FireMode[1].IsFiring())
		{
			GRS9AmbientFX(GlowFX).SetRedIndicator (2);
			GRS9AmbientFX(GlowFX).SetFireGlow(true);
		}
		else if (FireMode[1]!=None && LaserAmmo < default.LaserAmmo)
		{
			GRS9AmbientFX(GlowFX).SetRedIndicator (1);
			GRS9AmbientFX(GlowFX).SetFireGlow(false);
		}
		else
		{
			GRS9AmbientFX(GlowFX).SetRedIndicator (0);
			GRS9AmbientFX(GlowFX).SetFireGlow(false);
		}
	}

}
simulated event Tick (float DT)
{
	super.Tick(DT);
	if (LaserAmmo < default.LaserAmmo && ( FireMode[1]==None || !FireMode[1].IsFiring() ))
		LaserAmmo = FMin(default.LaserAmmo, LaserAmmo + (DT / 6) * (1 + LaserAmmo/default.LaserAmmo) );
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
	if (CurrentWeaponMode != CurrentWeaponMode2)
		CurrentWeaponMode2 = CurrentWeaponMode;
	if (bLaserOn != default.bLaserOn)
	{
		if (bLaserOn)
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn)
		return;
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor != None)
		GRS9Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;
	else
		AimAdjustTime = default.AimAdjustTime;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (!bLaserOn)
		KillLaserDot();
	PlayIdle();
	bUseNetAim = default.bUseNetAim || bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'IE_GRS9LaserHit',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			GRS9Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;

	if (GlowFX != None)
		GlowFX.Destroy();
	if (SightFX != None)
		SightFX.Destroy();
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
    local bool bAimAligned;

	if ((ClientState == WS_Hidden) || (!bLaserOn))
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('Laser').Origin;

	End = Start + Normal(Vector(AimDir))*3000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('Laser');
		Laser.SetRotation(AimDir);
	}

	if (LaserBlast != None)
	{
		LaserBlast.SetLocation(Laser.Location);
		LaserBlast.SetRotation(Laser.Rotation);
		Canvas.DrawActor(LaserBlast, false, false, DisplayFOV);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	if (bBigLaser)
	{
		Scale3D.Y = 4;
		Scale3D.Z = 4;
	}
	else
	{
		Scale3D.Y = 1.5;
		Scale3D.Z = 1.5;
	}
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	local Vector V;
	local Rotator R;
	local Coords C;

	super.RenderOverlays(Canvas);
	if (IsInState('Lowered'))
		return;
	DrawLaserSight(Canvas);

///	if (IsInState('Lowered'))
//		return;
	if (GlowFX != None)
	{
		C = GetBoneCoords('Laser');
		V = C.Origin;
		if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
			R = OrthoRotation(C.XAxis, -C.YAxis, C.ZAxis);
		else
			R = OrthoRotation(C.XAxis, C.YAxis, C.ZAxis);
		GlowFX.SetLocation(V);
		GlowFX.SetRotation(R);
		Canvas.DrawActor(GlowFX, false, false, DisplayFOV);
	}
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	
	if (Hand < 0)
		SightOffset.Y = default.SightOffset.Y * -1;
}


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_GRSNine');
	if (Instigator != None && LaserBlast == None && PlayerController(Instigator.Controller) != None)
	{
		LaserBlast = Spawn(class'GRS9LaserOnFX');
		class'DGVEmitter'.static.ScaleEmitter(LaserBlast, DrawScale);
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if (GlowFX != None)
		GlowFX.Destroy();
	if (SightFX != None)
		SightFX.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	GlowFX = None;
    	SightFX = None;

		GlowFX = Spawn(class'GRS9AmbientFX');
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(GlowFX), DrawScale);

		SightFX = Spawn(class'GRS9SightLEDs');
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(SightFX), DrawScale);

//		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'GRS9AmbientFX', DrawScale, self, 'Laser');
//		class'BUtil'.static.InitMuzzleFlash (SightFX, class'GRS9SightLEDs', DrawScale, self, 'SightBone');
		if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
		{
			GRS9AmbientFX(GlowFX).InvertY();
			GRS9SightLEDs(SightFX).InvertY();
//			GRS9AmbientFX(GlowFX).InvertZ();
//			GRS9SightLEDs(SightFX).InvertZ();
		}
	}
}

simulated event Timer()
{
	if (bBigLaser)
	{
		FireMode[1].StopFiring();
		bBigLaser=false;
		if (ThirdPersonActor != None)
			GRS9Attachment(ThirdPersonActor).bBigLaser=false;
	}
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (GlowFX);
		class'BUtil'.static.KillEmitterEffect (SightFX);
	}
	super.Timer();
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');
}

function ServerWeaponSpecial(optional byte i)
{
	if (!FireMode[1].IsFiring() && level.TimeSeconds - GRS9SecondaryFire(FireMode[1]).StopFireTime >= 0.8 && LaserAmmo == default.LaserAmmo && !IsInState('DualAction') && !IsInState('PendingDualAction'))
	{
		ClientWeaponSpecial(i);
		CommonWeaponSpecial(i);
	}
	else if (IsMaster() && GRS9Pistol(OtherGun)!=None)
	 	OtherGun.ServerWeaponSpecial(i);
}
simulated function ClientWeaponSpecial(optional byte i)
{
	if (level.NetMode == NM_Client)
		CommonWeaponSpecial(i);
}

simulated function CommonWeaponSpecial(optional byte i)
{
	bBigLaser=true;
	if (ThirdPersonActor != None)
		GRS9Attachment(ThirdPersonActor).bBigLaser=true;
	BallisticInstantFire(FireMode[1]).Damage = 90;
	BallisticInstantFire(FireMode[1]).DamageHead = 120;
	BallisticInstantFire(FireMode[1]).DamageLimb = 90;
	BallisticInstantFire(FireMode[1]).XInaccuracy = 192;
	BallisticInstantFire(FireMode[1]).YInaccuracy = 192;
	FireMode[1].ModeDoFire();
	LaserAmmo = FMax(0, LaserAmmo - default.LaserAmmo);
	BallisticInstantFire(FireMode[1]).Damage = BallisticInstantFire(FireMode[1]).default.Damage;
	BallisticInstantFire(FireMode[1]).DamageHead = BallisticInstantFire(FireMode[1]).default.DamageHead;
	BallisticInstantFire(FireMode[1]).DamageLimb = BallisticInstantFire(FireMode[1]).default.DamageLimb;
	BallisticInstantFire(FireMode[1]).XInaccuracy = 2;
	BallisticInstantFire(FireMode[1]).YInaccuracy = 2;

	
	if (ClientState != WS_PutDown && ClientState != WS_BringUp)
		Settimer(0.15, false);
}


simulated function float ChargeBar()
{
	return FClamp(LaserAmmo/default.LaserAmmo, 0, 1);
}

// Rechargable laser unit means it always has ammo!
simulated function bool HasAmmo()
{
	return true;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (LaserAmmo < 0.3 || level.TimeSeconds - GRS9SecondaryFire(FireMode[1]).StopFireTime < 0.8)
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	if (Dist > 3000)
		return 0;
	Result = FRand()*0.2 + FMin(1.0, LaserAmmo / (default.LaserAmmo/2));
	if (Dist < 500)
		Result += 0.5;
	else if (Dist > 1500)
		Result -= 0.3;
	if (Result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
	AIRating=0.6
	CurrentRating=0.6
	LaserAmmo=3.500000
	bShouldDualInLoadout=False
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP4-Tex.Glock.BigIcon_Glock'
	BigIconCoords=(Y1=30,Y2=230)
	SightFXBone="SightBone"
	BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
	ManualLines(0)="Automatic fire. Short ranged, but has higher DPS than most pistols. Recoil is moderate."
	ManualLines(1)="Projects a laser beam. Has extremely low DPS, but consistent damage over range and recharges over time."
	ManualLines(2)="The Weapon Function key causes a hitscan single-shot beam to be projected from the unit, dealing good damage. The GRS-9 is effective at close range."
	SpecialInfo(0)=(Info="120.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
	MagAmmo=15
	InventorySize=6
	CockAnimRate=1.200000
	CockSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-Cock',Volume=0.600000)
	ReloadAnimRate=1.350000
	ClipHitSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipHit',Volume=0.700000)
	ClipOutSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipOut')
	ClipInSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	bNoCrosshairInScope=True
	SightOffset=(Y=-3.900000,Z=16.750000)
	SightDisplayFOV=60.000000
	SightingTime=0.200000
	SightAimFactor=0.050000
	SprintChaos=0.050000
	AimAdjustTime=0.350000
	AimSpread=16
	AimDamageThreshold=480.000000
	ChaosDeclineTime=0.450000
	ChaosSpeedThreshold=7500.000000
	ChaosAimSpread=1024
	RecoilYawFactor=0.000000
	RecoilXFactor=0.20000
	RecoilYFactor=0.20000
	RecoilDeclineTime=1.500000
	RecoilDeclineDelay=0.270000
	FireModeClass(0)=Class'BWBPTestPro.GRS9PrimaryFire'
	FireModeClass(1)=Class'BWBPTestPro.GRS9SecondaryFire'
	SelectAnimRate=1.500000
	PutDownAnimRate=1.500000
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="The GRS9 from Drake & Co. is used primarily by inner core planets for law enforcement purposes. The additional laser unit adds an alternative attack to the GRS9. The laser unit can be held down, for up to 3.5 seconds, releasing a searing beam upon enemies. This drains the rechargeable battery however, which must be left to replenish when empty."
	Priority=9
	HudColor=(B=25,G=25,R=200)
	InventoryGroup=2
	GroupOffset=3
	PickupClass=Class'BWBPTestPro.GRS9Pickup'
	PlayerViewOffset=(X=10.000000,Y=12.000000,Z=-15.000000)
	AttachmentClass=Class'BWBPTestPro.GRS9Attachment'
	IconMaterial=Texture'BWBP4-Tex.Glock.SmallIcon_Glock'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] Glock 19"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBPAnotherPackAnims.Glock_FPm'
	DrawScale=0.150000
	bFullVolume=True
	SoundRadius=128.000000
}
