class SX45WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - STANDARD
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
			MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
			FireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.SX45.SX45-Fire',Volume=1.600000)
			Recoil=640.000000
			Chaos=0.050000
			Inaccuracy=(X=11,Y=11)
			BotRefireRate=0.300000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.300000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
	//=================================================================
	// FIRE PARAMS WEAPON MODE 1 - CRYOGENIC
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicCryoPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=45
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKCExp_Pro.DTSX45Pistol'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTSX45PistolHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTSX45Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKCExp_Pro.SX45FlashEmitter'
		FlashScaleFactor=0.06
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-FrostFire',Volume=1.200000)
		Recoil=512.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicCryoPrimaryFireParams
		FireInterval=0.150000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ClassicCryoPrimaryEffectParams'
	End Object
	
	//=================================================================
	// FIRE PARAMS WEAPON MODE 2 - RADIATION
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicRadPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=54
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKCExp_Pro.DTSX45Pistol'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTSX45PistolHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTSX45Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKCExp_Pro.SX45FlashEmitter'
		FlashScaleFactor=0.9
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-RadFire',Volume=1.200000)
		Recoil=128.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicRadPrimaryFireParams
		FireInterval=0.340000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ClassicRadPrimaryEffectParams'
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
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=2048)
		AimAdjustTime=0.550000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.200000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		MagAmmo=15
		SightOffset=(y=-3.140000,Z=14.300000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicCryoPrimaryFireParams'
		FireParams(2)=FireParams'ClassicRadPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}