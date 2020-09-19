class A700RocketGuided extends Pawn;

#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolors2Static.usx
#exec OBJ LOAD FILE=..\Sounds\BallisticSounds3.uax

var float Damage, DamageRadius, MomentumTransfer;
var class<DamageType> MyDamageType;
var Pawn OldPawn;
var	A700RocketTrail SmokeTrail;
var float YawAccel, PitchAccel;
var() Shader			ScopeViewShad;		// Shader displayed in Scope View. Fills the screen

// banking related
var Shader InnerScopeShader, OuterScopeShader, OuterEdgeShader;
var FinalBlend AltitudeFinalBlend;
var float YawToBankingRatio, BankingResetRate, BankingToScopeRotationRatio;
var int Banking, BankingVelocity, MaxBanking, BankingDamping;

var float VelocityToAltitudePanRate, MaxAltitudePanRate;

// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view

var bool	bStaticScreen;
var bool	bFireForce;

var TeamInfo MyTeam;

// targetting

var   Pawn			Target;
var   float			TargetTime;
var() float			LockOnTime;
var	  bool			bLockedOn, bLockedOld;
var() BUtil.FullSound	LockOnSound;
var() BUtil.FullSound	LockOffSound;


var() Material	ScopeViewOverlayTex;


replication
{
    reliable if (Role == ROLE_Authority && bNetOwner)
        bStaticScreen;

    reliable if ( Role < ROLE_Authority )
		ServerBlowUp;

	reliable if(Role==ROLE_Authority)
		Target, bLockedOn;
}

function PlayerChangedTeam()
{
	Died( None, class'DamageType', Location );
	OldPawn.Died(None, class'DamageType', OldPawn.Location);
}

function TeamInfo GetTeam()
{
	if ( PlayerReplicationInfo != None )
		return PlayerReplicationInfo.Team;
	return MyTeam;
}

simulated function Destroyed()
{
	RelinquishController();
	if ( SmokeTrail != None )
		SmokeTrail.Destroy();
	Super.Destroyed();
}

simulated function bool IsPlayerPawn()
{
	return false;
}

event bool EncroachingOn( actor Other )
{
	if ( Other.bWorldGeometry )
		return true;

	return false;
}

event EncroachedBy( actor Other )
{
	BlowUp(Location);
}

function RelinquishController()
{
	log("At start of RelinquishController");
	if ( Controller == None )
		return;
	Controller.Pawn = None;
	if ( !Controller.IsInState('GameEnded') )
	{
		if ( (OldPawn != None) && (OldPawn.Health > 0) )
			Controller.Possess(OldPawn);
		else
		{
			if ( OldPawn != None )
				Controller.Pawn = OldPawn;
			else
				Controller.Pawn = self;
			Controller.PawnDied(Controller.Pawn);
		}
	}
	RemoteRole = Default.RemoteRole;
	Instigator = OldPawn;
	Controller = None;
	log("At end of RelinquishController");
}

simulated function PostBeginPlay()
{
	local vector Dir;

	Dir = Vector(Rotation);
    Velocity = AirSpeed * Dir;
    Acceleration = Velocity;
	log("RocketGuided: In PostBeginPlay");
	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'A700RocketTrail',self,,Location - 18 * Dir);//-40 * dir
		SmokeTrail.SetBase(self);
	}
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	log("RocketGuided: In postnetbeginplay");
	log("RocketGuided: Controller is: "$Controller);
	if ( PlayerController(Controller) != None )
	{
		log("RocketGuided: Should be playing that firing sound");
		Controller.SetRotation(Rotation);
		PlayerController(Controller).SetViewTarget(self);
		Controller.GotoState(LandMovementState);
		PlayOwnedSound(Sound'BallisticSounds3.G5.G5-Fire1',SLOT_Interact,1.0);
	}
}

simulated function StartRocket()
{
	if (Role == ROLE_Authority)
		PlayOwnedSound(Sound'BallisticSounds3.G5.G5-Fire1',SLOT_Interact,1.0);
	
}

simulated function FaceRotation( rotator NewRotation, float DeltaTime )
{
}

function UpdateRocketAcceleration(float DeltaTime, float YawChange, float PitchChange)
{
    local vector X,Y,Z;
	local float PitchThreshold;
	local int Pitch;
    local rotator TempRotation;
    local TexRotator ScopeTexRotator;
    local VariableTexPanner AltitudeTexPanner;

	YawAccel = (1-2*DeltaTime)*YawAccel + DeltaTime*YawChange;
	PitchAccel = (1-2*DeltaTime)*PitchAccel + DeltaTime*PitchChange;
	SetRotation(rotator(Velocity));

	GetAxes(Rotation,X,Y,Z);
	PitchThreshold = 3000;
	Pitch = Rotation.Pitch & 65535;
	if ( (Pitch > 16384 - PitchThreshold) && (Pitch < 49152 + PitchThreshold) )
	{
		if ( Pitch > 49152 - PitchThreshold )
			PitchAccel = Max(PitchAccel,0);
		else if ( Pitch < 16384 + PitchThreshold )
			PitchAccel = Min(PitchAccel,0);
	}
	Acceleration = Velocity + 5*(YawAccel*Y + PitchAccel*Z);
	if ( Acceleration == vect(0,0,0) )
		Acceleration = Velocity;

	Acceleration = Normal(Acceleration) * AccelRate;

    BankingVelocity += DeltaTime * (YawToBankingRatio * YawChange - BankingResetRate * Banking - BankingDamping * BankingVelocity);
    Banking += DeltaTime * (BankingVelocity);
    Banking = Clamp(Banking, -MaxBanking, MaxBanking);
	TempRotation = Rotation;
	TempRotation.Roll = Banking;
	SetRotation(TempRotation);
    ScopeTexRotator = TexRotator(OuterScopeShader.Diffuse);
    if (ScopeTexRotator != None)
        ScopeTexRotator.Rotation.Yaw = Rotation.Roll;
    AltitudeTexPanner = VariableTexPanner(Shader(AltitudeFinalBlend.Material).Diffuse);
    if (AltitudeTexPanner != None)
        AltitudeTexPanner.PanRate = FClamp(Velocity.Z * VelocityToAltitudePanRate, -MaxAltitudePanRate, MaxAltitudePanRate);
}

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
}

simulated function Landed( vector HitNormal )
{
	BlowUp(Location);
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	BlowUp(Location);
}

function UnPossessed()
{
	BlowUp(Location);
}

simulated singular function Touch(Actor Other)
{
	if ( Other.bBlockActors )
		BlowUp(Location);
}

simulated singular function Bump(Actor Other)
{
	if (Other.bBlockActors)
		BlowUp(Location);
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType)
{
	/*if ( (Damage > 0) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
	{
		if ( (InstigatedBy == None) || DamageType.Default.bVehicleHit || (DamageType == class'Crushed') )
			BlowUp(Location);
		else
		{
			if ( PlayerController(Controller) != None )
				PlayerController(Controller).PlayRewardAnnouncement('Denied',1, true);
			if ( PlayerController(InstigatedBy.Controller) != None )
				PlayerController(InstigatedBy.Controller).PlayRewardAnnouncement('Denied',1, true);
	 		Spawn(class'IE_A700RocketExplodeB');
		    log("In TakeDamage - before RelinquishController");
		    RelinquishController();
		    log("In TakeDamage - after RelinquishController");
		    SetCollision(false,false,false);
		    HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
		    RelinquishController();//extra
		    log("In TakeDamage - before Destroy");
		    Destroy();
		}
	}*/
	GotoState('Dying');
}
////////////////////////////////////////////////OLD////////////////////////////////////////////////////////////
function TakeDamageOld( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType)
{
	if ( (Damage > 0) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
	{
		if ( (InstigatedBy == None) || DamageType.Default.bVehicleHit || (DamageType == class'Crushed') )
			BlowUp(Location);
		else
		{
			if ( PlayerController(Controller) != None )
				PlayerController(Controller).PlayRewardAnnouncement('Denied',1, true);
			if ( PlayerController(InstigatedBy.Controller) != None )
				PlayerController(InstigatedBy.Controller).PlayRewardAnnouncement('Denied',1, true);
	 		Spawn(class'IE_A700RocketExplodeB');
		    log("In TakeDamage - before RelinquishController");
		    RelinquishController();
		    log("In TakeDamage - after RelinquishController");
		    SetCollision(false,false,false);
		    HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
		    RelinquishController();//extra
		    log("In TakeDamage - before Destroy");
		    Destroy();
		}
	}
}
////////////////////////////////////////////////OLD////////////////////////////////////////////////////////////

function Fire( optional float F )
{
	ServerBlowUp();
	if ( F == 1 )
	{
		OldPawn.Health = -1;
		OldPawn.KilledBy(OldPawn);
	}
}

function ServerBlowUp()
{
	BlowUp(Location);
}

function BlowUp(vector HitLocation)
{
	local Emitter E;

	if ( Role == ROLE_Authority )
	{
		bHidden = true;
        	E = Spawn(class'IE_A700RocketExplodeB',,, HitLocation - 100 * Normal(Velocity), Rot(0,16384,0));//IE_A700RocketExplodeR
		if ( Level.NetMode == NM_DedicatedServer )
		{
			E.LifeSpan = 10.0;//0.7//5.0
		}
		GotoState('Dying');
	}
}

function bool DoJump( bool bUpdating )
{
	return false;
}

singular event BaseChange()
{
}

simulated function DrawHUD(Canvas C)
{
    local float ImageScaleRatio;

    DrawTargeting(C);

    if (ScopeViewShad != None)
    {
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		// This is the ratio the images in the package were saved at, we took a 1280x1024 image and scaled it down to a 1024x1024 image.
		// Thus if we draw them as a perfect square, they will be squashed looking.
		ImageScaleRatio = 1.3333333;
		C.DrawTile(ScopeViewShad, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1);

		C.SetPos((C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewShad, (C.SizeY*ImageScaleRatio), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewShad, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1);
   }
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
	C.SetDrawColor(255,0,0,255);
//	C.DrawTile(Texture'BallisticUI2.G5.G5Targetbox', V2.X - V.X, V2.Y - V.Y, 0, 0, 1, 1);
	C.DrawTileStretched(Texture'BallisticUI2.CrossHairs.A73OutA', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);//32*scalefactor
}

simulated function GetViewAxes( out vector xaxis, out vector yaxis, out vector zaxis )
{
    if ( Instigator.Controller == None )
        GetAxes( Instigator.Rotation, xaxis, yaxis, zaxis );
    else
        GetAxes( Instigator.Controller.Rotation, xaxis, yaxis, zaxis );
}


simulated event PlayDying(class<DamageType> DamageType, vector HitLoc);

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	BlowUp(Location);
}

function bool CheatWalk()
{
	return false;
}

function bool CheatGhost()
{
	return false;
}

function bool CheatFly()
{
	return false;
}

function ShouldCrouch(bool Crouch) {}

event SetWalking(bool bNewIsWalking) {}

function Suicide()
{
	Blowup(Location);
	if ( (OldPawn != None) && (OldPawn.Health > 0) )
		OldPawn.KilledBy(OldPawn);
}

auto state Flying
{
	function Tick(float DeltaTime)
	{

		local float BestAim, BestDist;
		local Vector Start;
		local Pawn Targ;
		local bool bWasLockedOn;

		//start targetting
		bWasLockedOn = TargetTime >= LockOnTime;
		BestDist = 1;
		Start = /*Instigator.*/Location + /*Instigator.*/EyePosition();
		//BestAim = 0.995;
		Targ = /*Instigator.*/Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 200000);//20000
		if (Targ != None)
		{
			if (Targ != Target)
			{
				Target = Targ;
				TargetTime = 0;
			}
			else if (Vehicle(Targ) != None)
				TargetTime += 1.2 * DeltaTime * (BestAim-0.95) * 20;
			else
				TargetTime += DeltaTime * (BestAim-0.95) * 20;
		}
		else
		{
			TargetTime = FMax(0, TargetTime - DeltaTime * 0.5);
		}
		if (Instigator.IsLocallyControlled())
		{
			if (!bWasLockedOn && TargetTime >= LockOnTime)
			    class'BUtil'.static.PlayFullSound(self, LockOnSound);
			else if (TargetTime < LockOnTime && bWasLockedOn)
			    class'BUtil'.static.PlayFullSound(self, LockOffSound);
		}
		bLockedOn = TargetTime >= LockOnTime;
		//end targetting

		if ( !bFireForce && (PlayerController(Controller) != None) )
		{
			bFireForce = true;
			PlayerController(Controller).ClientPlayForceFeedback("FlakCannonAltFire");  // jdf
		}
		if ( (OldPawn == None) || (OldPawn.Health <= 0) )
			BlowUp(Location);
		else if ( Controller == None )
		{
			if ( OldPawn.Controller == None )
				OldPawn.KilledBy(OldPawn);
			BlowUp(Location);
		}
	}
}

state Dying
{
ignores Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

	function Fire( optional float F ) {}
	function BlowUp(vector HitLocation) {}
	function ServerBlowUp() {}
	function Timer() {}
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType) {}

    function BeginState()
    {
		bHidden = true;
		bStaticScreen = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		Spawn(class'IE_A700RocketExplodeR',,, Location, Rotation);
		if ( SmokeTrail != None )
			SmokeTrail.Destroy();
		ShakeView();
    }

    function ShakeView()
    {
        local Controller C;
        local PlayerController PC;
        local float Dist, Scale;

        for ( C=Level.ControllerList; C!=None; C=C.NextController )
        {
            PC = PlayerController(C);
            if ( PC != None && PC.ViewTarget != None )
            {
                Dist = VSize(Location - PC.ViewTarget.Location);
                if ( Dist < DamageRadius * 2.0)
                {
                    if (Dist < DamageRadius)
                        Scale = 1.0;
                    else
                        Scale = (DamageRadius*2.0 - Dist) / (DamageRadius);
                    C.ShakeView(ShakeRotMag*Scale, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*Scale, ShakeOffsetRate, ShakeOffsetTime);
                }
            }
        }
    }

Begin:
	Instigator = self;
    PlaySound(SoundGroup'BallisticSounds2.Explosions.Explode');
    HurtRadius(Damage, DamageRadius*1.000, MyDamageType, MomentumTransfer, Location);
    Sleep(0.2);
    RelinquishController();
    Sleep(0.4);
    Destroy();
}

defaultproperties
{
     Damage=100.000000
     DamageRadius=100.000000
     MomentumTransfer=90000.000000
     MyDamageType=Class'BWBPArchivePackDE.DTA700Rocket'
     ScopeViewShad=Shader'BWSkrithRecolors2Tex.SkrithRL.SkrithRLScopeShader'
     InnerScopeShader=Shader'2K4Hud.ZoomFX.RDM_InnerScopeShader'
     OuterScopeShader=Shader'2K4Hud.ZoomFX.RDM_OuterScopeShader'
     OuterEdgeShader=Shader'2K4Hud.ZoomFX.RDM_OuterEdgeShader'
     AltitudeFinalBlend=FinalBlend'2K4Hud.ZoomFX.RDM_AltitudeFinal'
     YawToBankingRatio=60.000000
     BankingResetRate=15.000000
     BankingToScopeRotationRatio=8.000000
     MaxBanking=99999
     BankingDamping=1
     VelocityToAltitudePanRate=0.001750
     MaxAltitudePanRate=10.000000
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     LockOnTime=0.200000
     LockOnSound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-LaserOn',Volume=1.250000,Pitch=1.500000)
     LockOffSound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-LaserOff',Volume=1.250000,Pitch=1.500000)
     bSimulateGravity=False
     bDirectHitWall=True
     bHideRegularHUD=True
     bSpecialHUD=True
     bNoTeamBeacon=True
     bCanUse=False
     AirSpeed=1000.000000
     AccelRate=2000.000000
     BaseEyeHeight=0.000000
     EyeHeight=0.000000
     LandMovementState="PlayerRocketing"
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=145
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRocket'
     bDynamicLight=True
     bStasis=False
     bReplicateInstigator=True
     bNetInitialRotation=True
     Physics=PHYS_Flying
     NetPriority=3.000000
     AmbientSound=Sound'BWSkrithRecolors2Sounds.SkrithRL.rocket_fly2'
     DrawScale=0.500000
     AmbientGlow=96
     bGameRelevant=True
     bCanTeleport=False
     SoundRadius=100.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=5000.000000
     CollisionRadius=10.000000
     CollisionHeight=6.000000
     bBlockActors=False
     ForceType=FT_DragAlong
     ForceRadius=100.000000
     ForceScale=5.000000
}
