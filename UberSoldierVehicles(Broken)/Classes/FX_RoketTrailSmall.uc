class FX_RoketTrailSmall extends DKEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=192,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255))
         FadeOutStartTime=0.011000
         FadeInEndTime=0.005000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=-15.000000)
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'1945.Effects.seramegabotglow'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_RoketTrailSmall.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=192,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.360000
         FadeInEndTime=0.180000
         MaxParticles=500
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.750000)
         StartSizeRange=(X=(Min=45.000000,Max=50.000000),Y=(Min=45.000000,Max=50.000000),Z=(Min=45.000000,Max=50.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.smk_bumpy_uva'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_RoketTrailSmall.SpriteEmitter9'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=30.000000
         PointLifeTime=1.500000
         AutomaticInitialSpawning=False
         MaxParticles=1
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'1945.Effects.LensFlare05'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(4)=TrailEmitter'UberSoldierVehicles.FX_RoketTrailSmall.TrailEmitter0'

     Physics=PHYS_Trailer
     bHardAttach=True
}
