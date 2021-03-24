class FMPWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=9000.000000,Max=9000.000000)
			WaterTraceRange=7200.0
			DecayRange=(Min=0.0,Max=0.0)
			RangeAtten=0.700000
			Damage=20
			HeadMult=3.5
			LimbMult=0.5
			DamageType=Class'BWBP_SKCExp_Pro.DT_MP40Chest'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_MP40Head'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_MP40Chest'
			PenetrationEnergy=16.000000
			PenetrateForce=150
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			HookStopFactor=0.2
			HookPullForce=-10
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
			FlashScaleFactor=0.900000
			FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MP40.MP40-Fire',Volume=1.000000)
			Recoil=128.000000
			Chaos=-1.0
			Inaccuracy=(X=28,Y=28)
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.122500
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.200000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.600000
		MaxRecoil=2048.000000
		DeclineTime=0.5
		DeclineDelay=0.100000
		ViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=1024)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.3
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		MagAmmo=28
		SightOffset=(X=5.000000,Y=-7.670000,Z=18.900000)
		SightPivot=(YAW=10)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}