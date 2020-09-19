class Deco_AbramsFlapA extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.Abrams_Flap1'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=2
         StartLocationOffset=(X=80.000000)
         StartLocationRange=(Y=(Min=-50.000000,Max=50.000000))
         SpinsPerSecondRange=(X=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         StartSizeRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         InitialParticlesPerSecond=10000.000000
         LifetimeRange=(Min=60.000000,Max=60.000000)
         StartVelocityRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=800.000000,Max=1200.000000))
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.Deco_AbramsFlapA.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
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
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         Opacity=0.500000
         FadeOutStartTime=0.240000
         FadeInEndTime=0.120000
         MaxParticles=1770
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=50.000000,Max=50.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.Deco_AbramsFlapA.SpriteEmitter3'

}
