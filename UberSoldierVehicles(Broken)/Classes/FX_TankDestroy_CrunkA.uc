class FX_TankDestroy_CrunkA extends DKEmitter;

defaultproperties
{
     SpawnSound=SoundGroup'DKoppIISound.Crash.CrashA'
     SpawnSoundVolume=2.000000
     SpawnSoundRadius=1000.000000
     Begin Object Class=MeshEmitter Name=MeshEmitter5
         StaticMesh=StaticMesh'XEffects.GibBotHand'
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
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.250000,Max=0.500000),Y=(Min=0.250000,Max=0.500000),Z=(Min=0.250000,Max=0.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter5'

     Begin Object Class=MeshEmitter Name=MeshEmitter6
         StaticMesh=StaticMesh'XEffects.GibBotCalf'
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
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.250000,Max=0.500000),Y=(Min=0.250000,Max=0.500000),Z=(Min=0.250000,Max=0.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(1)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter6'

     Begin Object Class=MeshEmitter Name=MeshEmitter7
         StaticMesh=StaticMesh'XEffects.GibBotForearm'
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
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.250000,Max=0.500000),Y=(Min=0.250000,Max=0.500000),Z=(Min=0.250000,Max=0.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(2)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter7'

     Begin Object Class=MeshEmitter Name=MeshEmitter8
         StaticMesh=StaticMesh'XEffects.GibBotUpperArm'
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
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.250000,Max=0.500000),Y=(Min=0.250000,Max=0.500000),Z=(Min=0.250000,Max=0.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(3)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter8'

     Begin Object Class=MeshEmitter Name=MeshEmitter9
         StaticMesh=StaticMesh'ONSBP_DestroyedVehicles.Cicada.Cicada_FanBlade'
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
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.250000,Max=0.800000),Y=(Min=0.250000,Max=0.800000),Z=(Min=0.250000,Max=0.800000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(4)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter9'

     Begin Object Class=MeshEmitter Name=MeshEmitter10
         StaticMesh=StaticMesh'ONSBP_DestroyedVehicles.Cicada.Cicada_FanHousing'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnedVelocityScaleRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.850000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         MaxParticles=3
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.250000,Max=0.600000),Y=(Min=0.250000,Max=0.600000),Z=(Min=0.250000,Max=0.600000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(5)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter10'

     Begin Object Class=MeshEmitter Name=MeshEmitter11
         StaticMesh=StaticMesh'ONSBP_DestroyedVehicles.SPMA.SPMA_GunStrutpiece'
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
         MaxParticles=4
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.550000,Max=0.800000),Y=(Min=0.550000,Max=0.800000),Z=(Min=0.550000,Max=0.800000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(6)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter11'

     Begin Object Class=MeshEmitter Name=MeshEmitter12
         StaticMesh=StaticMesh'ONSBP_DestroyedVehicles.Paladin.Paladin_MainGun'
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
         MaxParticles=8
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.550000,Max=0.800000),Y=(Min=0.550000,Max=0.800000),Z=(Min=0.550000,Max=0.800000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=500.000000,Max=6500.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(7)=MeshEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.MeshEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter37
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
         FadeOutStartTime=0.170000
         FadeInEndTime=0.170000
         MaxParticles=200
         AddLocationFromOtherEmitter=5
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_CrunkA.SpriteEmitter37'

     bSuperHighDetail=True
     Skins(0)=Texture'1945Steni.vendortrunk01'
     AmbientGlow=32
     bUnlit=False
}
