class RoboT9CNWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Max=5000.000000)
			WaterTraceRange=3000.0
			DecayRange=(Min=0.0,Max=0.0)
			RangeAtten=0.700000
			Damage=22
			HeadMult=2.3
			LimbMult=0.5
			DamageType=Class'BWBP_SKCExp_Pro.DTRoboT9CN'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DTRoboT9CNHead'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DTRoboT9CN'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
			FlashScaleFactor=1.000000
			FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-FireOld',Volume=1.200000)
			Recoil=768.000000
			Chaos=-1.0
			Inaccuracy=(X=48,Y=48)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.080000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.200000
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.300000
		DeclineTime=0.400000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=8192)
		AimAdjustTime=0.350000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.050000
		AimDamageThreshold=480.000000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=11200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		MagAmmo=18
		SightOffset=(X=-5.000000,Y=-2.850000,Z=12.700000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}