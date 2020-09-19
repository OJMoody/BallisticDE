class FX_FireEffect_AmazonTraceBG extends DKEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnedVelocityScaleRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-20.000000,Y=25.000000)
         StartSizeRange=(X=(Min=12.000000,Max=12.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.spark_stretched_a_tiled'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=35000.000000,Max=35000.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_AmazonTraceBG.SpriteEmitter2'

}
