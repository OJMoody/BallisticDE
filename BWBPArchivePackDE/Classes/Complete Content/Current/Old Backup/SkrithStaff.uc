//=============================================================================
// Elite Skrith Rifle
//
// Handed to the best of the best.
// 
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SkrithStaff extends BallisticWeapon;

var Actor GlowFX;
var float		lastModeChangeTime;
var   bool			bLaserOn;
var   LaserActor	Laser;
var   Emitter		LaserDot;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientSwitchCannonMode, ClientSwitchLaser;
}

simulated event RenderOverlays (Canvas C)
{
	local Vector X, Y, Z;
    if (!bScopeView)
    {
        WeaponRenderOverlays(C);
        if (SightFX != None)
            RenderSightFX(C);
        DrawLaserSight(C);
        return;
    }
    if (!bNoMeshInScope)
    {
        WeaponRenderOverlays(C);
        if (SightFX != None)
            RenderSightFX(C);
        DrawLaserSight(C);
    }
    else
    {
        GetViewAxes(X, Y, Z);
        if (BFireMode[0].MuzzleFlash != None)
        {
            BFireMode[0].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
            BFireMode[0].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
            C.DrawActor(BFireMode[0].MuzzleFlash, false, false, DisplayFOV);
        }
        if (BFireMode[1].MuzzleFlash != None)
        {
            BFireMode[1].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
            BFireMode[1].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
            C.DrawActor(BFireMode[1].MuzzleFlash, false, false, DisplayFOV);
        }
        SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
        SetRotation(Instigator.GetViewRotation());
    }
    DrawLaserSight(C);
    
    C.ColorModulate.W = 1;
    if (ScopeViewTex != None)
    {
        C.SetPos(C.OrgX, C.OrgY);
        C.SetDrawColor(255,255,255,255);
        C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY * 1.33)/2, C.SizeY, 0, 0, 1, 1024);

        C.SetPos((C.SizeX - C.SizeY*1.33)/2, C.OrgY);
        C.DrawTile(ScopeViewTex, C.SizeY * 1.33, C.SizeY, 0, 0, 1024, 1024);

        C.SetPos(C.SizeX - (C.SizeX - C.SizeY*1.33)/2, C.OrgY);
        C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY * 1.33)/2, C.SizeY, 0, 0, 1, 1024);
    }
}

/*simulated event RenderOverlays (Canvas C)
{
	DrawLaserSight(C);
	super.RenderOverlays(C);
}*/

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	//E23PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	if (Laser == None)
		Laser = spawn(class'LaserActor_VPR');
}

simulated function ClientSwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn || Role == ROLE_Authority)
		return;

	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;

	if (!bLaserOn)
		KillLaserDot();
}

simulated function SwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn)
		return;

	bLaserOn = bNewLaserOn;
	bUseNetAim = bLaserOn || default.bUseNetAim;
	ClientSwitchLaser(bLaserOn);

	if (Role == ROLE_Authority && ThirdPersonActor != None)
		SkrithStaffAttachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (!bLaserOn)
		KillLaserDot();
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;
    local bool bAimAligned;

	if (ClientState == WS_Hidden || !bLaserOn)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	//if (bScopeView)
		//Loc = Instigator.Location + vect(0,0,1)*(Instigator.EyeHeight-8);
	//else
		Loc = GetBoneCoords('Muzzle').Origin;

	End = Start + Normal(Vector(AimDir))*3000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		LaserDot.Emitters[5].AutomaticInitialSpawning = Other.bWorldGeometry;
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('Muzzle');
		Laser.SetRotation(AimDir);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 4;
	Scale3D.Z = 4;

	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
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

simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'IE_VPRLaserHit',,,Loc);
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

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SkrithStaffClip';
}

exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	SoundPitch = 45;

	GunLength = default.GunLength;

    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'SkrithStaffGlowFX', DrawScale, self, 'Muzzle');
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect (GlowFX);
	super.Timer();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			SkrithStaffAttachment(ThirdPersonActor).bLaserOn = false;
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
	if (GlowFX != None)
		GlowFX.Destroy();
	Super.Destroyed();
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (Level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo+(-0 + Rand(0)) - MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo += AmmoNeeded;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
}


simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	if (MagAmmo < 1)
		return 1;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return Rand(2);

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
		|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	     && (B.Enemy == None || !B.EnemyVisible()) )
		return 0;
	if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
		return 0;

	if (Dist > 300)
		return 0;

	V = B.Squad.GetLinkVehicle(B);
	if ( V == None )
		V = Vehicle(B.MoveTarget);
	if ( V == B.Target )
		return 0;
	if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
		return 0;

	if (Dist < FireMode[1].MaxRange())
		return 1;
//	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
//		return 1;
//	if (FRand() > Dist/500)
//		return 1;
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

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( (V != None)
			&& (VSize(Instigator.Location - V.Location) < 1.5 * FireMode[0].MaxRange())
			&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
			return 1.2;

		if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * FireMode[0].MaxRange()
		     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
			return 1.2;

		O = DestroyableObjective(B.Squad.SquadObjective);
		if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	    	 && VSize(Instigator.Location - O.Location) < 1.1 * FireMode[0].MaxRange() && B.LineOfSightTo(O) )
			return 1.2;
	}

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (!HasMagAmmo(0) && Ammo[0].AmmoAmount < 1)
	{
		if (Dist > 400)
			return 0;
		return Result / (1+(Dist/400));
	}
	// Enemy too far away
	if (Dist > 1300)
		Result -= (Dist-1000) / 3000;
	if (Dist < 500)
		Result += 0.5;

	if (Result < 0.14)
	{
		if (CurrentWeaponMode != 0)
		{
			lastModeChangeTime = level.TimeSeconds;
			CurrentWeaponMode = 0;
			SkrithStaffPrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
		}
	}
	else if (Result < 0.34 && MagAmmo > 10)
	{
		if (CurrentWeaponMode != 1)
		{
			lastModeChangeTime = level.TimeSeconds;
			CurrentWeaponMode = 1;
			SkrithStaffPrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
		}
	}


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
function float SuggestAttackStyle()	{	 if (!HasNonMagAmmo(0) && !HasMagAmmo(0)) return 1.2; return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====

function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		SkrithStaffPrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
	ClientSwitchCannonMode (CurrentWeaponMode);
}
simulated function ClientSwitchCannonMode (byte newMode)
{
	SkrithStaffPrimaryFire(FireMode[0]).SwitchCannonMode(newMode);
}

/*simulated function FirePressed(float F)
{
	if (bNeedReload && MagAmmo > 8)
		bNeedReload = false;
	super.FirePressed(F);
}*/

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     UsedAmbientSound=Sound'BallisticSounds2.A73.A73Hum1'
     BigIconMaterial=Texture'BWSkrithRecolors2Tex.SkrithStaff.BigIcon_SkrithStaff'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_RapidProj=True
     bWT_Energy=True
     SpecialInfo(0)=(Info="300.0;25.0;0.5;85.0;0.2;0.2;0.2")
     BringUpSound=(Sound=Sound'BallisticSounds2.A73.A73Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A73.A73Putaway')
     ClipHitSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipIn')
     ClipInFrame=0.700000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Plasma Charge",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Plasma Bomb",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="ALaser",bUnavailable=True)
     WeaponModes(3)=(ModeName="BLaser",bUnavailable=True)
     WeaponModes(4)=(ModeName="CLaser",bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=450)
     SightOffset=(X=2.000000,Y=2.000000,Z=14.000000)
     SightDisplayFOV=40.000000
	 PlayerViewOffset=(X=0.000000,Y=8.000000,Z=-10.000000)
     CrouchAimFactor=0.600000
     SprintOffSet=(Pitch=-500,Yaw=-1024)
     JumpChaos=0.500000
     ViewAimFactor=0.350000
     ViewRecoilFactor=0.450000
     AimDamageThreshold=75.000000
     ChaosSpeedThreshold=600.000000
	 AimSpread=16
	 ChaosAimSpread=2048
	 ChaosDeclineTime=2.5
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
     RecoilPitchFactor=0.800000
     RecoilYawFactor=0.800000
     RecoilXFactor=0.300000
     RecoilYFactor=0.300000
     RecoilMax=1024.000000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPArchivePackDE.SkrithStaffPrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.SkrithStaffSecondaryFire'
	 MagAmmo=60
	 MeleeFireClass=Class'BWBPArchivePackDE.SkrithStaffMeleeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bMeleeWeapon=True
     Description="A73 Elite Skrith Rifle||Manufacturer: Unknown Skrith Engineers|Primary: Energy Bolt|Secondary: Blade Stab||The A73-E is a specialized version of the Skrith standard rifle and is rarely seen on the battlefield. Aside from the red tint, the Elite model is very similar in appearance to the standard. Scans show, however, that this special version fires projectiles at roughly 3 times the standard heat level and has an odd permanent electrical charge coursing through the blades. If encountered in the field, it is advised to report the occurrence to HQ immediately for testing."
     Priority=92
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     PickupClass=Class'BWBPArchivePackDE.SkrithStaffPickup'
     BobDamping=1.600000
     AttachmentClass=Class'BWBPArchivePackDE.SkrithStaffAttachment'
     IconMaterial=Texture'BWSkrithRecolors2Tex.SkrithStaff.SmallIcon_SkrithStaff'
     IconCoords=(X2=127,Y2=31)
     ItemName="Skrith Shillelagh"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
	 Mesh=SkeletalMesh'BWSkrithRecolors2Anim.SkrithStaff'
     DrawScale=0.187500
     SoundPitch=32
     SoundRadius=32.000000
}
