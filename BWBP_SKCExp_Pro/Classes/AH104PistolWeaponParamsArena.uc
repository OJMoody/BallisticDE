class AH104PistolWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{
   //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
			DecayRange=(Min=1536,Max=2560)
			PenetrationEnergy=12 
			Damage=85.000000
			HeadMult=1.5f
			LimbMult=0.8f
			RangeAtten=0.500000
			DamageType=Class'BWBP_SKCExp_Pro.DT_AH104Pistol'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_AH104PistolHead'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_AH104Pistol'
			PenetrateForce=200
			bPenetrate=True
			MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
			FlashScaleFactor=0.900000
			FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.AH104.AH104-Super',Volume=7.100000)
			Recoil=1024.000000
			Chaos=0.2
			Inaccuracy=(X=16,Y=16)
			WarnTargetPct=0.400000
			BotRefireRate=0.7
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			AimedFireAnim="SightFire"
			FireEndAnim=
			FireInterval=0.39
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
			FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.AH104.AH104-FlameLoopStart',Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.01
			Chaos=0.05
			Damage=12.000000
			HeadMult=1.0f
			LimbMult=1.0f
			DamageType=Class'BWBP_SKCExp_Pro.DT_AH104Pistol'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_AH104PistolHead'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_AH104Pistol'
			Inaccuracy=(X=0,Y=0)
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.050000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
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

	Begin Object Class=AimParams Name=ArenaAimParams
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
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=12
		PlayerSpeedFactor=0.9
		SightMoveSpeedFactor=0.900000
		MagAmmo=9
		SightOffset=(X=-15.000000,Y=-0.400000,Z=11.500000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'