class SPASShotgunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=5500.000000,Max=7000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.150000
		//TraceCount=1
		//TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		//ImpactManager=Class'BallisticProV55.IM_BigBullet'
		Damage=100.0
		HeadMult=1.35
		LimbMult=0.3
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.Fire_SPAS',Volume=1.500000)
		Recoil=728.000000
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.500000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=1500.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		HeadMult=1.35
		LimbMult=0.3
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.Fire_SPAS_Cock',Volume=1.200000)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.850000
		BurstFireRateFactor=1.00
		//FireAnim="FireCock"
		FireEndAnim=
		//AimedFireAnim="SightFireCock"	
	FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=3196.000000
		DeclineTime=1.400000
		ViewBindFactor=0.900000
		ADSViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=768)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		MagAmmo=5
		ReloadAnimRate=1.0
		CockAnimRate=1.0
		SightOffset=(X=-4.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Bricks
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_JCF_Tex.SPASCamos.SPASShort_Main_S2',Index=1)
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		MagAmmo=5
		ReloadAnimRate=1.0
		CockAnimRate=1.0
		SightOffset=(X=-4.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-AU
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_JCF_Tex.SPASCamos.SPASShort_Main_S3',Index=1)
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		MagAmmo=5
		ReloadAnimRate=1.2
		CockAnimRate=1.2
		SightOffset=(X=-4.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Blue
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_JCF_Tex.SPASCamos.SPASShort_Main_S4',Index=1)
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		MagAmmo=5
		ReloadAnimRate=1.0
		CockAnimRate=1.0
		SightOffset=(X=-4.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Hazard
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_JCF_Tex.SPASCamos.SPASShort_Main_S5',Index=1)
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		MagAmmo=5
		ReloadAnimRate=1.0
		CockAnimRate=1.0
		SightOffset=(X=-4.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Bricks'
	Layouts(2)=WeaponParams'ClassicParams-AU'
	Layouts(3)=WeaponParams'ClassicParams-Blue'
	Layouts(4)=WeaponParams'ClassicParams-Hazard'
}