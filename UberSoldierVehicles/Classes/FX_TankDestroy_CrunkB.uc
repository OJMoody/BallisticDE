class FX_TankDestroy_CrunkB extends DKEmitter;

defaultproperties
{
     SpawnSound=SoundGroup'DKoppIISound.Crash.CrashA'
     SpawnSoundVolume=2.000000
     SpawnSoundRadius=1000.000000
     Begin Object Class=MeshEmitter Name=MeshEmitter13
         StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2_FlapL4'
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1500.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnedVelocityScaleRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.850000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Max=1.200000),Y=(Max=1.200000),Z=(Max=1.200000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=40.000000,Max=40.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=3500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkB.MeshEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter51
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(X=-20.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=100,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.500000
         FadeOutStartTime=0.550000
         FadeInEndTime=0.200000
         MaxParticles=600
         StartLocationOffset=(Z=20.000000)
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=5.000000,Max=5.000000)
         InitialDelayRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=30.000000,Max=50.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkB.SpriteEmitter51'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter57
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-10.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=100,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.550000
         FadeInEndTime=0.200000
         MaxParticles=1200
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'1945.Effects.1545666438afg'
         TextureUSubdivisions=6
         TextureVSubdivisions=6
         LifetimeRange=(Min=2.500000,Max=2.500000)
         InitialDelayRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=30.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkB.SpriteEmitter57'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter58
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-20.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=100,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.180000
         FadeInEndTime=0.180000
         MaxParticles=300
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=300.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=30.000000,Max=50.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkB.SpriteEmitter58'

     Begin Object Class=MeshEmitter Name=MeshEmitter14
         StaticMesh=StaticMesh'XGame_rc.WildcardChargerMesh'
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnedVelocityScaleRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.850000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         MaxParticles=5
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.300000,Max=0.800000),Y=(Min=0.300000,Max=0.800000),Z=(Min=0.300000,Max=0.800000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-2000.000000,Max=2000.000000),Y=(Min=-2000.000000,Max=2000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(4)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkB.MeshEmitter14'

     bSuperHighDetail=True
     Skins(0)=Texture'DKVehiclesTex.AbramsMK2.AbramsMK2_X_Def'
     AmbientGlow=32
     bUnlit=False
}
