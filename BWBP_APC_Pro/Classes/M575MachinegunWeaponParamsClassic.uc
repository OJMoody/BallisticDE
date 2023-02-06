class M575MachinegunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.35
		Damage=30.000000
		HeadMult=2.0
		LimbMult=1.0
		DamageType=Class'BWBP_APC_Pro.DTM575MG'
		DamageTypeHead=Class'BWBP_APC_Pro.DTM575MGHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTM575MG'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.M575.M575-Fire',Volume=1.400000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=80.000000
		Chaos=-1.0
		Inaccuracy=(X=16,Y=16)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.102000
		BurstFireRateFactor=1.00
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.200000
		Damage=14.000000
		HeadMult=2.0
		LimbMult=1.0
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		Recoil=70.000000
		Chaos=0.050000
		Inaccuracy=(X=16,Y=16)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.090000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.35000
		YRandFactor=0.35000
		MaxRecoil=5000.000000
		DeclineTime=1.0
		DeclineDelay=0.15000
		ViewBindFactor=0.45
		ADSViewBindFactor=1.00
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=768,Max=2560)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=1.60000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.900000
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=50
		SightOffset=(X=-2.000000,Y=-0.375000,Z=13.220000)
		SightPivot=(Pitch=128)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Jungle
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.M575Camos.M575_body_SH2',Index=3)
		WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.900000
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=50
		SightOffset=(X=-2.000000,Y=-0.375000,Z=13.220000)
		SightPivot=(Pitch=128)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Oil
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.M575Camos.M575_body_SH3',Index=3)
		WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.900000
		SightMoveSpeedFactor=0.500000
		MagAmmo=50
		SightOffset=(X=-2.000000,Y=-0.375000,Z=13.220000)
		SightPivot=(Pitch=128)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Jungle'
	Layouts(2)=WeaponParams'ClassicParams-Oil'
}