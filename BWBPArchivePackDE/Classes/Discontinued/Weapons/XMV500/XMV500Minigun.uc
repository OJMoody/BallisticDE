//=============================================================================
// XMV500Minigun.
//
// Almighty beast of a weapon, this spews out bullets at the unholy rate of
// sixty rounds per second. It comes with a variable fire rate, 20, 40 or 60
// rps and semi-auto fire.
//
// The minigun was really challenging because we had to develop some advanced
// new systems to allow for the demanded features. These included support for
// high fire rates(likely higher than PC's FPS) and a new turret system.
//
// The RoF is done by firing as fast as possible normally and firing multiple
// bullets at once when there aren't enough frames. To fire multiple shots in
// one frame an interpolater is added to figure out where the bullets mil most
// likely be aimed, based on current view rotation speed as well as all the
// aiming system vars... Hell of a thing, but... it works...
//
// For turrets, a versatile, general purpose turret system was developed and
// will be used for more than just this weapon in the future.
//
// One of the most difficult weapons of v2.0, this is at least a devastating
// piece of hardware being able to hoze down an area with bullets and leave no
// room for enemies to dodge. The deployed mode eliminates the restrictive
// recoil, but the user must be stationary.
//
// Kab
//=============================================================================
class XMV500Minigun extends BallisticWeapon;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticRecolors4.utx


var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;
var() Sound DeploySound;
var() Sound UndeploySound;

var   bool			bLaserOn;

var   LaserActor	Laser;
var float		lastModeChangeTime;
var() Sound			LaserOnSound;
var() Sound			ModeCycleSound;
var() Sound			LaserOffSound;

var   Emitter		LaserDot;

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;

	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		AimSpread *= 0.5;
		ChaosAimSpread *= 0.5;
		RecoilMax *= 0.5;
	}
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'BallisticDE.LaserActor');
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
		XMV500MinigunAttachment(ThirdPersonActor).bLaserOn = bLaserOn;

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
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	if (ThirdPersonActor!=None)
		XMV500MinigunAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;
	else
		AimAdjustTime = default.AimAdjustTime;
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
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

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
		LaserDot = Spawn(class'BallisticDE.M806LaserDot',,,Loc);
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
	Loc = GetBoneCoords('ejector').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') /*&& Level.TimeSeconds - FireMode[0].NextFireTime > 0.2*/)
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
		AimDir = GetBoneRotation('ejector');
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

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (Instigator!=None && Instigator.IsLocallyControlled())
		Shader'BallisticRecolors4.XMV500.XMV500_Barrels_SD'.FallbackMaterial = Texture'BallisticRecolors4.XMV500.XMV500_Barrels';
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local string s;

	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,128);
	s = "XMV500Minigun: TraceCount: "$XMV500MinigunPrimaryFire(FireMode[0]).TraceCount$ ", FireRate: "$1.0/FireMode[0].FireRate$"TurnVelocity: "$XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch$", "$XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw;
	Canvas.DrawText(s);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated event PostBeginPlay()
{
	super.PostbeginPlay();
	XMV500MinigunPrimaryFire(FireMode[0]).Minigun = self;
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('Barrels', BT);

	if (CurrentWeaponMode == 0)
		DesiredSpeed = 0.2;
	else if (CurrentWeaponMode == 1)
		DesiredSpeed = 0.2;
	else if (CurrentWeaponMode == 2)
		DesiredSpeed = 0.4;
	else// (CurrentWeaponMode == 3)
		DesiredSpeed = 0.7;

	super.WeaponTick(DT);

}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			XMV500MinigunAttachment(ThirdPersonActor).bLaserOn = false;
		AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (FireMode[0].IsFiring())
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.2*DT, 0.65*DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.075*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		AmbientSound = BarrelSpinSound;
		SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		XMV500MinigunAttachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode > 0 && FireCount >= 1)
		return false;
	return super.CheckWeaponMode(Mode);
}

simulated function ServerSwitchWeaponMode (byte NewMode)
{
      PlaySound(ModeCycleSound,,4.7,,32);

	NewMode = CurrentWeaponMode + 1;
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
		CurrentWeaponMode = NewMode;
}


simulated function string GetHUDAmmoText(int Mode)
{
	return string(Ammo[Mode].AmmoAmount);
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
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
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy != None) )
		return 0;

	if (Instigator.bIsCrouched && B.Squad.IsDefending(B) && fRand() > 0.6)
		return 1;

	return 0;
}
function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Dist > 1000)
		Result -= (Dist-1000) / 3000;
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.2;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.4;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -1.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -1.4;	}
// End AI Stuff =====

defaultproperties
{
     BarrelSpinSound=Sound'PackageSounds4.550.Mini-Rotor'
     BarrelStopSound=Sound'PackageSounds4.550.Mini-Down'
     BarrelStartSound=Sound'PackageSounds4.550.Mini-Up'
     DeploySound=Sound'BallisticSounds2.XMV-850.XMV-Deploy'
     UndeploySound=Sound'BallisticSounds2.XMV-850.XMV-UnDeploy'
     LaserOnSound=Sound'PackageSounds4.AH104.AH104-SightOn'
     ModeCycleSound=Sound'PackageSounds4.AH104.AH104-ModeCycle'
     LaserOffSound=Sound'PackageSounds4.AH104.AH104-SightOff'
     PlayerSpeedFactor=0.750000
     PlayerJumpFactor=0.750000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=1)
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BallisticRecolors4.XMV500.BigIcon_XMV500'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     InventorySize=55
     bWT_Bullet=True
     bWT_Machinegun=True
     bWT_Super=True
     SpecialInfo(0)=(Info="480.0;55.0;2.0;100.0;0.5;0.5;0.7")
     BringUpSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-Putaway')
     MagAmmo=80
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.XMV-850.XMV-ClipIn')
     ClipInFrame=0.650000
     bNonCocking=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="600 RPM",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="1200 RPM",bUnavailable=True)
     WeaponModes(3)=(ModeName="2400 RPM",bUnavailable=True,ModeID="WM_FullAuto")
     CurrentWeaponMode=1
     SightPivot=(Pitch=512,Roll=2048)
     SightOffset=(X=-48.000000,Z=20.000000)
     SightDisplayFOV=50.000000
     CrouchAimFactor=0.000000
     SprintOffSet=(Pitch=-2500,Yaw=-7000)
     JumpOffSet=(Pitch=-1250,Yaw=-7000)
	 AimAdjustTime=0.550000
     ViewRecoilFactor=0.750000
	 ChaosAimSpread=3072
     AimSpread=256
	 ChaosDeclineTime=2.5
	 RecoilDeclineDelay=2.5
	 RecoilDeclineTime=2.500000
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.250000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=-0.300000),(InVal=0.500000,OutVal=0.400000),(InVal=0.700000,OutVal=-0.300000),(InVal=1.000000,OutVal=0.400000)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=-0.100000),(InVal=0.450000,OutVal=-0.250000),(InVal=0.650000,OutVal=0.500000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=0.300000)))
     RecoilYawFactor=0.500000
     RecoilXFactor=0.024000
     RecoilYFactor=0.024000
     RecoilMax=3000.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.XMV500MinigunPrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.XMV500SecondaryFire'
     SelectAnimRate=0.750000
     PutDownTime=0.800000
     BringUpTime=2.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="XMB-500 Personal Minigun|Manuacturer: Enravion Combat Solutions|Primary: Auto fire||The XMV-500 Personal Suppression System is a prototype weapon being developed by Enravion as a low-recoil, precision minigun. The XMB-500 has been designed for ease of use with infantry and boasts firerates of 600 to 2400 RPM; combined with the potent incendiary rounds, the accurate XMB-500 is perfect for cutting down large amounts of enemy troops. This weapon has excellent accuracy when stationary but unfortunately cannot be fired safely at the higher speeds while moving. To prevent damage to the user and the weapon, the XMB-500 will automatically lock when mobile at cyclic speeds over 600 RPM. It should be noted that the speed sensor will malfunction if submerged in liquid or not properly cared for."
     DisplayFOV=52.000000
     Priority=48
     CustomCrossHairColor=(A=219)
     CustomCrossHairScale=1.008803
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=3
     PickupClass=Class'BWBPArchivePackDE.XMV500Pickup'
     PlayerViewOffset=(X=32.000000,Y=14.000000,Z=-15.000000)
     BobDamping=1.400000
     AttachmentClass=Class'BWBPArchivePackDE.XMV500MinigunAttachment'
     IconMaterial=Texture'BallisticRecolors4.XMV500.SmallIcon_XMV500'
     IconCoords=(X2=127,Y2=25)
     ItemName="VL500 Vulcan Minigun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticAnims2.XMV-850Minigun'
     DrawScale=0.400000
     Skins(0)=Texture'BallisticRecolors4.XMV500.XMV500_Main'
     Skins(1)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(2)=Shader'BallisticRecolors4.XMV500.XMV500_Barrels_SD'
     SoundRadius=128.000000
	 }
