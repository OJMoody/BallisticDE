class RS04WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=5500.000000)
		WaterTraceRange=3300.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=32
		HeadMult=2.65
		LimbMult=0.375
		DamageType=Class'BWBP_SKCExp_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTM1911Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=640.000000
		Chaos=0.050000
		Inaccuracy=(X=11,Y=11)
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryBurstEffectParams
		TraceRange=(Max=5500.000000)
		WaterTraceRange=3300.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=32
		HeadMult=2.65
		LimbMult=0.375
		DamageType=Class'BWBP_SKCExp_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTM1911Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=640.000000
		Chaos=0.050000
		Inaccuracy=(X=11,Y=11)
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryBurstFireParams
		FireInterval=0.030000
		FireAnim="FireDual"
		AimedFireAnim="Fire"
		BurstFireRateFactor=0.02
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryBurstEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.100000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Light Pistol
		AimSpread=(Min=36,Max=2048)
		AimAdjustTime=0.550000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.050000
		JumpChaos=0.050000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.050000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=5
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=-20.000000,Y=-1.9500000,Z=17.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryBurstFireParams'
	End Object

	Layouts(0)=WeaponParams'ClassicParams'


}