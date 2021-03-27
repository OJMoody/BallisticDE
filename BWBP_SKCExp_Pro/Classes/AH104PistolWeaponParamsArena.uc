class AH104PistolWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{
   //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=6000.000000,Max=6500.000000)
			WaterTraceRange=3250.0
			RangeAtten=0.350000
			Damage=100
			HeadMult=1.5f
			LimbMult=0.7f
			DamageType=Class'BWBP_SKCExp_Pro.DT_AH104Pistol'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_AH104PistolHead'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_AH104Pistol'
			PenetrationEnergy=32.000000
			PenetrateForce=250
			bPenetrate=True
			PDamageFactor=0.800000
			WallPDamageFactor=0.800000
			MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
			FlashScaleFactor=1.100000
			FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.AH104.AH104-Super',Volume=7.100000)
			Recoil=1024.000000
			Chaos=0.200000
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			BurstFireRateFactor=1.00
			FireEndAnim=	
			AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.AH104.AH104-FlameLoopStart',Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.1
			Chaos=0.05
			Inaccuracy=(X=0,Y=0)
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.050000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=8192.000000
		DeclineTime=1.000000
		DeclineDelay=0.400000
		ViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=40,Max=1024)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.7000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=1250.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=12
		PlayerSpeedFactor=0.9
		SightMoveSpeedFactor=0.900000
		MagAmmo=7
		SightOffset=(X=-15.000000,Y=-0.400000,Z=11.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'