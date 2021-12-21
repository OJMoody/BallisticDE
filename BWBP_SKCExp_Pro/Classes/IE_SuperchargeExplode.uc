//=============================================================================
// IE_SuperDischarge.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_SuperchargeExplode extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.539286,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.092000
         FadeInEndTime=0.032000
         MaxParticles=1
         DetailMode=DM_High
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=1200.000000,Max=1200.000000),Y=(Min=1200.000000,Max=1200.000000),Z=(Min=1200.000000,Max=1200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.ElectroShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.170000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=300.000000,Max=500.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=8
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=64,A=255))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=255,G=224,R=192,A=255))
         ColorScale(3)=(RelativeTime=0.360714,Color=(B=128,A=255))
         ColorScale(4)=(RelativeTime=0.457143,Color=(B=255,G=192,R=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.112000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=30.000000,Max=50.000000),Y=(Min=30.000000,Max=50.000000),Z=(Min=30.000000,Max=50.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-0.500000,Max=0.700000))
     End Object
     Emitters(2)=BeamEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.BeamEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter84
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
        Opacity=0.540000
        FadeOutStartTime=0.189000
        FadeInEndTime=0.038500
        MaxParticles=12
      
        StartLocationRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000))
        SpinsPerSecondRange=(X=(Max=0.250000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.250000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=150.000000,Max=200.000000),Z=(Min=150.000000,Max=200.000000))
        InitialParticlesPerSecond=40.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'BWBP_SKC_Tex.LS14.EMPProj'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.650000,Max=0.650000)
    End Object
     Emitters(3)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter84'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter85
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        Opacity=0.410000
        FadeOutStartTime=1.230000
        FadeInEndTime=0.540000
        MaxParticles=15
      
        StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=35.000000,Max=50.000000))
        SpinsPerSecondRange=(X=(Max=0.075000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=75.000000),Y=(Min=75.000000),Z=(Min=75.000000))
        InitialParticlesPerSecond=40.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=75.000000,Max=100.000000))
        VelocityLossRange=(Z=(Max=0.500000))
    End Object
     Emitters(4)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter85'

    Begin Object Class=SparkEmitter Name=SparkEmitter83
        LineSegmentsRange=(Min=0.100000,Max=0.200000)
        TimeBetweenSegmentsRange=(Min=0.050000,Max=0.150000)
        FadeOut=True
        RespawnDeadParticles=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-500.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.400000))
        FadeOutStartTime=0.440000
        MaxParticles=100
      
        StartLocationRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000))
        StartSizeRange=(X=(Min=350.000000,Max=350.000000),Y=(Min=350.000000,Max=350.000000),Z=(Min=350.000000,Max=350.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BWBP_SKC_Tex.BFG.BFGProj2'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Max=1000.000000))
    End Object
     Emitters(5)=SparkEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SparkEmitter83'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter86
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.110000
        FadeOutStartTime=0.276000
        MaxParticles=5
      
        StartLocationOffset=(Z=25.000000)
        StartLocationRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000))
        SpinsPerSecondRange=(X=(Max=0.200000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.250000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        InitialParticlesPerSecond=100.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
        LifetimeRange=(Min=0.400000,Max=0.400000)
    End Object
     Emitters(6)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter86'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter87
        UseDirectionAs=PTDU_Up
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-600.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.457143,Color=(B=255,G=128,R=128,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.400000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.400000))
        FadeOutStartTime=0.028000
        MaxParticles=20
      
        StartSpinRange=(X=(Min=0.250000,Max=0.250000))
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=30.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
        TextureUSubdivisions=3
        TextureVSubdivisions=3
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=50.000000,Max=500.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=350.000000))
    End Object
     Emitters(7)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter87'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter89
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
        ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        Opacity=0.400000
        FadeOutStartTime=1.065000
        FadeInEndTime=0.150000
        MaxParticles=45
      
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.300000)
        SizeScale(1)=(RelativeTime=0.550000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000))
        InitialParticlesPerSecond=20.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=30.000000))
        VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
    End Object
     Emitters(8)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter89'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter91
        UseDirectionAs=PTDU_Forward
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.171429,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.024000
        FadeInEndTime=0.024000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        DetailMode=DM_High
        StartLocationOffset=(X=10.000000)
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=0.610000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=600.000000,Max=600.000000),Y=(Min=600.000000,Max=600.000000),Z=(Min=600.000000,Max=600.000000))
        InitialParticlesPerSecond=8.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.ElectroShock'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
    End Object
     Emitters(9)=SpriteEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.SpriteEmitter91'

    Begin Object Class=BeamEmitter Name=BeamEmitter7
        BeamDistanceRange=(Min=250.000000,Max=250.000000)
        DetermineEndPointBy=PTEP_Distance
        LowFrequencyNoiseRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
        HighFrequencyNoiseRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.300000,Color=(B=64,G=64,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000))
        FadeOutStartTime=0.216000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
      
        DetailMode=DM_High
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=35.000000),Y=(Min=20.000000,Max=35.000000),Z=(Min=20.000000,Max=35.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'EpicParticles.Beams.HotBolt04aw'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
    End Object
     Emitters(10)=BeamEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.BeamEmitter7'

    Begin Object Class=BeamEmitter Name=BeamEmitter8
        BeamDistanceRange=(Min=250.000000,Max=250.000000)
        DetermineEndPointBy=PTEP_Distance
        LowFrequencyNoiseRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
        HighFrequencyNoiseRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.300000,Color=(B=64,G=64,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
        FadeOutStartTime=0.216000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
      
        DetailMode=DM_High
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=35.000000),Y=(Min=20.000000,Max=35.000000),Z=(Min=20.000000,Max=35.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'EpicParticles.Beams.HotBolt04aw'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=3.800000,Max=3.800000)
        StartVelocityRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
    End Object
     Emitters(11)=BeamEmitter'BWBP_SKCExp_Pro.IE_SuperchargeExplode.BeamEmitter8'

     AutoDestroy=True
     bNoDelete=False
}