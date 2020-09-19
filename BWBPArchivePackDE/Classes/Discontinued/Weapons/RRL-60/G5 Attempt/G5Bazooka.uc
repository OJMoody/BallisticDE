//=============================================================================
// G5Bazooka.
//
// Big rocket launcher. Fires a dangerous, not too slow moving rocket, with
// high damage and a fair radius. Low clip capacity, long reloading times and
// hazardous close combat temper the beast though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G5Bazooka extends BallisticWeapon;

#EXEC OBJ LOAD FILE=BallisticUI2.utx

var() BUtil.FullSound	HatchSound;
var   bool				bCamView;
var   Pawn			Target;
var   float			TargetTime;
var() float			LockOnTime;
var	  bool			bLockedOn, bLockedOld;
var() BUtil.FullSound	LockOnSound;
var() BUtil.FullSound	LockOffSound;
var() int		LaserChaosAimSpread, LaserAimSpread;

var   Actor			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser

var   float			LastSendTargetTime;
var   vector		TargetLocation;
var   bool			bLaserOn, bLaserOld;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

replication
{
	reliable if(Role==ROLE_Authority)
		CurrentRocket, Target, bLockedOn, bLaserOn;

	reliable if(Role<ROLE_Authority)
		ServerSetRocketTarget;

	reliable if(Role==ROLE_Authority)
		ClientSetCurrentRocket, ClientRocketDie;
}

simulated function TickLongGun (float DT)
{
	local Actor		T;
	local Vector	HitLoc, HitNorm, Start;
	local float		Dist;

	LongGunFactor += FClamp(NewLongGunFactor - LongGunFactor, -DT/AimAdjustTime, DT/AimAdjustTime);

	Start = Instigator.Location + Instigator.EyePosition();
	T = Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * (GunLength+Instigator.CollisionRadius), Start, true);
	if (T == None || T.Base == Instigator || (G5MortarDamageHull(T)!=None && T.Owner == Instigator))
	{
		if (bPendingSightUp && SightingState < SS_Raising && NewLongGunFactor > 0)
			ScopeBackUp(0.5);
		NewLongGunFactor = 0;
	}
	else
	{
		Dist = VSize(HitLoc - Start)-Instigator.CollisionRadius;
		if (Dist < GunLength)
		{
			if (bScopeView)
				TemporaryScopeDown(0.5);
			NewLongGunFactor = Acos(Dist / GunLength)/1.570796;
		}
	}
}

simulated function OutOfAmmo()
{
    if ( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo()  || ( CurrentRocket != None && (bLaserOn || bCamView) ))
        return;

    DoAutoSwitch();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;

	G5Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;
	else
		AimAdjustTime = default.AimAdjustTime;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
	SwitchLaserProps(bNewLaserOn);
}

simulated function ClientSwitchLaser()
{
	TickLaser (0.05);
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}
	PlayIdle();
	bUseNetAim = default.bUseNetAim || bLaserOn;
	SwitchLaserProps(bLaserOn);
}

simulated function SwitchLaserProps(bool bLaserOn)
{
	if (bLaserOn)
	{
		AimSpread = LaserAimSpread;
		ChaosAimSpread = LaserChaosAimSpread;
	}
	
	else
	{
		AimSpread = default.AimSpread;
		ChaosAimSpread = default.ChaosAimSpread;
	}
}
	

/*simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();

	if ( ThirdPersonActor != None )
		G5Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (class'BallisticReplicationInfo'.default.bNoReloading && AmmoAmount(0) > 1)
		SetBoneScale (0, 1.0, 'Rocket');
}*/

function ServerSetRocketTarget(vector Loc)
{
	TargetLocation = Loc;
	if (CurrentRocket != None && G5SeekerRocket(CurrentRocket) != None)
		G5SeekerRocket(CurrentRocket).SetTargetLocation(Loc);
	if (ThirdPersonActor != None)
		G5Attachment(ThirdPersonActor).LaserEndLoc = Loc;
}

simulated function TickLaser ( float DT )
{
	local vector Start, End, HitLocation, HitNormal, AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || Instigator == None || !bLaserOn || bScopeView ||
		(bCamView && bScopeHeld) || (bCamView && Currentrocket != None && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).ViewTarget == CurrentRocket))
		return;

	if ( Instigator.IsFirstPerson() && (ReloadState != RS_None || ClientState != WS_ReadyToFire || Level.TimeSeconds - FireMode[0].NextFireTime <= 0.2) )
	{
		AimDir = Vector(GetBoneRotation('tip2'));
		Start = Instigator.Location + Instigator.EyePosition();
	}
	else
		AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);

	End = Start + Normal(AimDir)*10000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (G5MortarDamageHull(Other) != None && Other.Owner == Instigator)
		Other = FireMode[0].Trace (HitLocation, HitNormal, End, HitLocation + Normal(AimDir)*Other.CollisionRadius * 3, true);
	if (Other == None)
		HitLocation = End;

	if (Role == ROLE_Authority)
		ServerSetRocketTarget(HitLocation);
	else
	{
		if ( ThirdPersonActor != None )
			G5Attachment(ThirdPersonActor).LaserEndLoc = HitLocation;
		TargetLocation = HitLocation;
		if (level.TimeSeconds - LastSendTargetTime > 0.04)
		{
			LastSendTargetTime = level.TimeSeconds;
			ServerSetRocketTarget(HitLocation);
		}
	}
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Scale3D, Loc;

	if ((ClientState == WS_Hidden) || !bLaserOn || bScopeView || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	Loc = GetBoneCoords('tip2').Origin;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(TargetLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(TargetLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(TargetLocation, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
		Laser.SetRotation(GetBoneRotation('tip2'));

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

// Azarael - improved ironsights
simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
		
	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 2;
		AimSpread *= SightAimFactor;
		ChaosAimSpread *= SightAimFactor;
		ChaosDeclineTime *= 2.0;
		ChaosSpeedThreshold *= 0.7;
	}
	else
	{
		//PositionSights will handle this for clients
		if(Level.NetMode == NM_DedicatedServer)
		{
			ViewAimFactor = default.ViewAimFactor;
			ViewRecoilFactor = default.ViewRecoilFactor;
		}
		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		ChaosAimSpread = default.ChaosAimSpread;
		ChaosAimSpread *= BCRepClass.default.AccuracyScale;
		ChaosDeclineTime = default.ChaosDeclineTime;
		ChaosSpeedThreshold = default.ChaosSpeedThreshold;
		SwitchLaserProps(bLaserOn);
	}
}

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function SetScopeView(bool bNewValue)
{
	bScopeView = bNewValue;
	if (!bScopeView)
	{
		Target = None;
		TargetTime=0;
	}
	SetScopeBehavior();
	if (Level.NetMode == NM_Client)
	{
		ServerSetScopeView(bNewValue);

		if (!bNewValue && Target != None && TargetTime >= LockOnTime)
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
}

simulated function StartScopeView()
{
	if (!bCamView && Instigator.Controller.IsA( 'PlayerController' ))
	{
		switch(ZoomType)
		{
			case ZT_Smooth: 
				PlayerController(Instigator.Controller).StartZoomWithMax((90-FullZoomFOV)/88);
				break;
			case ZT_Minimum:
				PlayerController(Instigator.Controller).bZooming=True;
				PlayerController(Instigator.Controller).SetFOV(FClamp(90.0 - (MinFixedZoomLevel * 88.0), 1, 170));
				PlayerController(Instigator.Controller).ZoomLevel = MinFixedZoomLevel;
				PlayerController(Instigator.Controller).DesiredZoomLevel = MinFixedZoomLevel;
				break;
			case ZT_Fixed:
				PlayerController(Instigator.Controller).bZooming=True;
				PlayerController(Instigator.Controller).SetFOV(FullZoomFOV);
				PlayerController(Instigator.Controller).ZoomLevel = (90 - FullZoomFOV) / 88;
				PlayerController(Instigator.Controller).DesiredZoomLevel = (90 - FullZoomFOV) / 88;
				break;
			case ZT_Logarithmic:
				break;
		}
	}
	SetScopeView(true);
	if (ZoomInSound.Sound != None)	class'BUtil'.static.PlayFullSound(self, ZoomInSound);
	if (bPendingSightUp)
		bPendingSightUp=false;
}

// Scope up anim just ended. Either go into scope view or move the scope back down again
simulated function ScopeUpAnimEnd()
{
 	if (bCamView)
 		CameraView();
 	else
 		super.ScopeUpAnimEnd();
}
// Scope down anim has just ended. Play idle anims like normal
simulated function ScopeDownAnimEnd()
{
	if (MagAmmo == 1 && bNeedCock && (!bLaserOn || CurrentRocket==None || G5SeekerRocket(CurrentRocket) == None) )
		CommonCockGun();
	else
		super.ScopeDownAnimEnd();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();

		if (ThirdPersonActor != None)
			G5Attachment(ThirdPersonActor).bLaserOn = false;

		if (MagAmmo < 2)
			SetBoneScale (0, 0.0, 'Rocket');
		if (bCamView)
			PlayerView();
		return true;
	}
	return false;
}

simulated event OldRenderOverlays (Canvas C)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bScopeView)
	    DrawTargeting(C);
	Super.RenderOverlays(C);
	DrawLaserSight(C);
}

simulated function WeaponTick(float DT)
{
	local float BestAim, BestDist;
	local Vector Start;
	local Pawn Targ;
	local bool bWasLockedOn;

	Super.WeaponTick(DT);

	if (Instigator != None && Instigator.IsLocallyControlled())
		TickLaser(DT);

	if (!bScopeView || CurrentWeaponMode != 1 || Role < Role_Authority)
		return;

	bWasLockedOn = TargetTime >= LockOnTime;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);
	if (Targ != None)
	{
		if (Targ != Target)
		{
			Target = Targ;
			TargetTime = 0;
		}
		else if (Vehicle(Targ) != None)
			TargetTime += 1.2 * DT * (BestAim-0.95) * 20;
		else
			TargetTime += DT * (BestAim-0.95) * 20;
	}
	else
	{
		TargetTime = FMax(0, TargetTime - DT * 0.5);
	}
	if (Instigator.IsLocallyControlled())
	{
		if (!bWasLockedOn && TargetTime >= LockOnTime)
		    class'BUtil'.static.PlayFullSound(self, LockOnSound);
		else if (TargetTime < LockOnTime && bWasLockedOn)
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
	bLockedOn = TargetTime >= LockOnTime;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != bLaserOld)
	{
		bLaserOld = bLaserOn;
		ClientSwitchLaser();
	}
	if (bLockedOn != bLockedOld)
	{
		bLockedOld = bLockedOn;
		if (bLockedOn)
		    class'BUtil'.static.PlayFullSound(self, LockOnSound);
		else
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
	Super.PostNetReceive();
}

simulated event DrawTargeting (Canvas C)
{
	local Vector V, V2, X, Y, Z;
	local float ScaleFactor;

	if (Target == None || !bLockedOn)
		return;

	ScaleFactor = C.ClipX / 1600;
	GetViewAxes(X, Y, Z);
	V  = C.WorldToScreen(Target.Location - Y*Target.CollisionRadius + Z*Target.CollisionHeight);
	V.X -= 32*ScaleFactor;
	V.Y -= 32*ScaleFactor;
	C.SetPos(V.X, V.Y);
	V2 = C.WorldToScreen(Target.Location + Y*Target.CollisionRadius - Z*Target.CollisionHeight);
	C.SetDrawColor(255,255,255,255);
//	C.DrawTile(Texture'BallisticUI2.G5.G5Targetbox', V2.X - V.X, V2.Y - V.Y, 0, 0, 1, 1);
	C.DrawTileStretched(Texture'BallisticUI2.G5.G5Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);
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
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
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

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Dist, Rating;

	B = Bot(Instigator.Controller);
	
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();
		
	// anti-vehicle specialist
	if (Vehicle(B.Enemy) != None)
		return 1.2;
		
	Rating = Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist < 1024) // danger close
		return 0.4;
	
	// projectile
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 3072, 4096); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

exec simulated function WeaponSpecial(optional byte i)
{
	bScopeHeld=true;
	bPendingSightUp=false;

	if (bCamView && (CurrentRocket == None || PlayerController(Instigator.Controller).ViewTarget == CurrentRocket))
	{
		PlayerView();
		bScopeHeld=false;
		if (bScopeView)
			StopScopeView();
		return;
	}
	if (bScopeView)
	{
		if (bCamView)
		{
			bScopeHeld=false;
			StopScopeView();
		}
		else CameraView();
		return;
	}


	if (Instigator.Physics == PHYS_Falling || (SprintControl != None && SprintControl.bSprinting))
		return;

	if (NewLongGunFactor == 0 && CurrentRocket != None)
	{
		PlayScopeUp();

		ReloadState = RS_None;
		ServerWeaponSpecial(i);
		bCamView=true;
		if (G5Rocket(CurrentRocket)!=None)
			G5Rocket(CurrentRocket).OnDie = RocketDie;
	}
}
exec simulated function WeaponSpecialRelease(optional byte i)
{
	super.ScopeViewRelease();
}

function ServerWeaponSpecial(optional byte i)
{
	bServerReloading=false;
	ReloadState = RS_None;
}

simulated function ClientSetCurrentRocket(Actor Proj)
{
	if (level.NetMode == NM_Client && !bCamView)
	{
		if (G5Rocket(Proj) != None)
			G5Rocket(Proj).OnDie = RocketDie;
		CurrentRocket = Proj;
	}
}
simulated function SetCurrentRocket(Actor Proj)
{
	if (!bCamView)
	{
		if (G5Rocket(Proj) != None)
			G5Rocket(Proj).OnDie = RocketDie;
		CurrentRocket = Proj;
		ClientSetCurrentRocket(Proj);
	}
}

// Back to player
simulated function PlayerView()
{
	PlayerController(Instigator.Controller).SetViewTarget( Instigator );
    PlayerController(Instigator.Controller).DesiredFOV = PlayerController(Instigator.Controller).DefaultFOV;
	if (CurrentRocket != None)
		CurrentRocket.bOwnerNoSee=false;
	if (bScopeView)
		StopScopeView();
	else
		PlayScopeDown();
	bCamView=false;
}
// View from CurrentRocket
simulated function CameraView()
{
	if (bScopeView && Instigator.Controller.IsA( 'PlayerController' ))
		PlayerController(Instigator.Controller).EndZoom();
	PlayerController(Instigator.Controller).SetViewTarget(CurrentRocket);
	CurrentRocket.bOwnerNoSee=true;
}
// Draw cam view stuff if in cam view...
simulated event RenderOverlays( Canvas Canvas )
{
	// Do stuff for camera view
	if ( CurrentRocket != None && PlayerController(Instigator.Controller).ViewTarget == CurrentRocket )
    {
		Instigator.SetViewRotation(CurrentRocket.Rotation);
		// Noise
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(0,0);
		Canvas.DrawColor.A = 48;
		Canvas.DrawTile( Material'BallisticUI2.M50.Noise1', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 256, 256 ); // !! hardcoded size
		// Tunnel vision
		Canvas.DrawColor.A = 255;
		Canvas.SetPos(0,0);
		Canvas.DrawTile( Material'BallisticUI2.M50.M50CamView', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 1024, 1024 ); // !! hardcoded size
	}
    else
        OldRenderOverlays(Canvas);
}

exec simulated function CockGun(optional byte Type)	{ if (bNeedCock)	super.CockGun(Type);	}

/*simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn && anim == 'ReloadLoop')
	{
		PlayShovelEnd();
		ReloadState = RS_EndShovel;
		return;
	}

	if (Anim == ZoomInAnim && bCamView)
		CameraView();
	else
		Super.AnimEnd(Channel);
}*/

simulated function ClientRocketDie(Actor Rocket)
{
	if (level.netMode == NM_Client)
		RocketDie(Rocket);
}
simulated function RocketDie(Actor Rocket)
{
	if (Role == ROLE_Authority && Instigator!= None && !Instigator.IsLocallyControlled())
		ClientRocketDie(Rocket);
	if (bCamView && Rocket == CurrentRocket)
		PlayerView();

	if (class'BallisticReplicationInfo'.default.bNoReloading)
	{
		if (AmmoAmount(0) > 0 && bNeedCock && (Rocket == CurrentRocket || CurrentRocket==None || !bLaserOn))
			CommonCockGun(1);
	}
	else if (MagAmmo == 1 && bNeedCock && (Rocket == CurrentRocket || CurrentRocket==None || !bLaserOn))
		CommonCockGun(1);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo > 1)
	{
		SetBoneScale (0, 1.0, 'RocketBone');
		ThirdPersonActor.SetBoneScale (0, 1.0, 'RocketBone');
	}
	else if (MagAmmo == 0)
	{
		SetBoneScale (0, 0.0, 'RocketBone');
		ThirdPersonActor.SetBoneScale (0, 0.0, 'RocketBone');
	}
}

simulated function Notify_ClipIn()
{
	Super.Notify_ClipIn();
	ThirdPersonActor.SetBoneScale (0, 1.0, 'RocketBone');
}

defaultproperties
{
     HatchSound=(Sound=Sound'BallisticSounds2.G5.G5-Lever',Volume=0.700000,Pitch=1.000000)
     LockOnTime=1.500000
     LockOnSound=(Sound=Sound'BallisticSounds2.G5.G5-TargetOn',Volume=0.500000,Pitch=1.000000)
     LockOffSound=(Sound=Sound'BallisticSounds2.G5.G5-TargetOff',Volume=0.500000,Pitch=1.000000)
     LaserChaosAimSpread=256
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_G5'
     BigIconCoords=(Y1=36,Y2=230)
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
	 InventorySize=24
     ManualLines(0)="Fires a rocket. These rockets have an arming delay and will ricochet off surfaces when unarmed.|In Rocket mode, the rocket flies directly to the point of aim.|In Mortar mode, the rocket will fly upwards and then strike downwards upon the point of aim.|When scoped and in Mortar mode, targets focused directly upon by the weapon's scope may be highlighted in red; when this happens, the next Mortar shot will track the target until line of sight is broken. The target is notified of the lockon when the rocket is fired."
     ManualLines(1)="Toggles the guidance laser. With the guidance laser active, rockets will fly towards the point indicated by the laser at any given time."
     ManualLines(2)="When firing a mortar rocket. the Weapon Function key will cause the player to view through the rocket's nose camera.|As a bazooka, the G5 has no recoil. With the laser in use, its hipfire is stable, however it will always be lowered when the player jumps. The weapon is effective at medium to long range and with height advantage."
     SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.G5.G5-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.G5.G5-Putaway')
     MagAmmo=1
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.G5.G5-Lever')
     ReloadAnim="Reload"
     ReloadAnimRate=1.250000
     ClipOutSound=(Sound=Sound'BallisticSounds2.G5.G5-Load')
     ClipInSound=(Sound=Sound'BallisticSounds2.G5.G5-LoadHatch')
     bCanSkipReload=True
     bShovelLoad=True
     EndShovelAnimRate=1.250000
     WeaponModes(0)=(ModeName="Rocket")
     WeaponModes(1)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Smooth
     ScopeXScale=1.333000
     ZoomInAnim="ZoomIn"
     ZoomOutAnim="ZoomOut"
     ScopeViewTex=Texture'BallisticUI2.G5.G5ScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=10.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(Y=0.940000,Z=9.500000)
     SightingTime=0.500000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     JumpOffSet=(Pitch=-6000,Yaw=-1500)
     AimAdjustTime=1.000000
     AimSpread=512
     ChaosSpeedThreshold=1000.000000
     ChaosAimSpread=2560
     RecoilYawFactor=0.000000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.G5PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.G5SecondaryFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     Description="Based on the original design by the legendary maniac Pirate, Var Dehidra, the G5 has undergone many alterations to become what it is today. The original bandit version was constructed by Var Dehidra to blast open armored cash transportation vehicles. Its name is derived from one of Dehidra's favourite targets, the G5 CTV 4x. It is now a very deadly weapon, used to destroy everything from tanks and structures to Skrith hordes and aircraft. The bombardement attack is a recent addition, replacing the original, primitive heat seeking function that caused it to target CTVs or backfire on the pirates' own craft, provided mainly for use in outdoor environments to destroy all manner of moving targets. The latest model also features a laser-painter device, allowing the user to guide the rocket wherever they wish."
     Priority=44
     HudColor=(B=25,G=150,R=50)
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPArchivePackDE.G5Pickup'
     PlayerViewOffset=(X=4.000000,Y=4.000000,Z=-5.000000)
     AttachmentClass=Class'BWBPArchivePackDE.G5Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_G5'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] RRL-60 Reptile Toxic Bazooka"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWSkrithRecolors2Anim.SkrithRocketLauncher'
     DrawScale=0.300000
}
