//=============================================================================
// PUGCloud.
//
// A cloud of gas from the PUG grenade. The controller wil damage the actors this is touching
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class PUGCloud extends BallisticEmitter
	placeable;

var   AvoidMarker		Fear;			// Da phear spauwt...
var   PUGCloudControl	MyControl;		// The cloud controlling actor
var   float				Density;		// How thick is this cloud. Adds up when grenade sits in once place for awhile

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	MyControl = PUGCloudControl(Owner);
	if (level.NetMode != NM_Client)
	{
		Fear = Spawn(class'AvoidMarker');
		Fear.SetCollisionSize(200, 200);
	    Fear.StartleBots();
		if (level.netMode == NM_DedicatedServer)
		{
			Emitters[0].Disabled = true;
			Emitters[1].Disabled = true;
		}
	}
}

function Reset()
{
	Destroy();
}

simulated function Terminate(float Delay)
{
	SetTimer(Delay, false);
}

simulated function Timer()
{
	if (level.netMode == NM_DedicatedServer)
		GotoState('DSDying');
	else
		Kill();
}

state DSDying
{
Begin:
	Sleep(3.0);
	Destroy();
}

simulated function Destroyed()
{
	if (MyControl != None)
		MyControl.CloudDie(self);
	if (Fear!=None)
		Fear.Destroy();
	super.Destroyed();
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
		Kill();
}

defaultproperties
{
     Density=1.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.490000
         FadeOutStartTime=1.050000
         FadeInEndTime=1.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=200
         StartLocationRange=(X=(Min=-96.000000,Max=96.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=0.010000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=150.000000,Max=200.000000),Z=(Min=150.000000,Max=200.000000))
         InitialParticlesPerSecond=0.700000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticDE.T10Cloud.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.580000
         FadeOutStartTime=1.450000
         FadeInEndTime=0.675000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationRange=(X=(Min=-64.000000,Max=64.000000))
         SpinsPerSecondRange=(X=(Max=0.030000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=0.750000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticDE.T10Cloud.SpriteEmitter0'

     AutoDestroy=True
     CollisionRadius=192.000000
     CollisionHeight=192.000000
     bCollideActors=True
     bUseCylinderCollision=True
     bNotOnDedServer=False
}
