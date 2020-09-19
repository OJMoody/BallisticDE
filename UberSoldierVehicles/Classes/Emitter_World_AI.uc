class Emitter_World_AI extends Emitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'DKVehiclesMesh.A10.A10'
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=10000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=25.000000,Max=25.000000)
         StartVelocityRange=(X=(Min=-10000.000000,Max=-10000.000000))
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.Emitter_World_AI.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000)
         MaxParticles=1500
         StartLocationRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=130.000000,Max=130.000000),Z=(Min=80.000000,Max=80.000000))
         AddLocationFromOtherEmitter=0
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'1945.Effects.4361e4f6'
         StartVelocityRange=(X=(Min=-20.000000,Max=-20.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.Emitter_World_AI.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000)
         MaxParticles=1500
         StartLocationRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=-130.000000,Max=-130.000000),Z=(Min=80.000000,Max=80.000000))
         AddLocationFromOtherEmitter=0
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'1945.Effects.4361e4f6'
         StartVelocityRange=(X=(Min=-20.000000,Max=-20.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.Emitter_World_AI.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.180000
         FadeInEndTime=0.080000
         MaxParticles=100
         StartLocationRange=(Y=(Min=680.000000,Max=680.000000))
         AddLocationFromOtherEmitter=0
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'1945.Effects.impflash2'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.Emitter_World_AI.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.180000
         FadeInEndTime=0.080000
         MaxParticles=100
         StartLocationRange=(Y=(Min=-650.000000,Max=-650.000000))
         AddLocationFromOtherEmitter=0
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'1945.Effects.impflash2'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.Emitter_World_AI.SpriteEmitter4'

     AutoDestroy=True
     bNoDelete=False
     bHardAttach=True
}
