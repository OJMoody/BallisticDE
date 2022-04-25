class ThorWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		Damage=10
		HeadMult=1f
		LimbMult=1f
		DamageType=Class'BallisticProV55.DT_HVCLightning'
		DamageTypeHead=Class'BallisticProV55.DT_HVCLightning'
		DamageTypeArm=Class'BallisticProV55.DT_HVCLightning'
		Chaos=0.000000
		BotRefireRate=0.99
		WarnTargetPct=0.3
		FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.070000	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=200
		HeadMult=1f
		LimbMult=1f
		DamageType=Class'BallisticProV55.DT_HVCRedLightning'
		DamageTypeHead=Class'BallisticProV55.DT_HVCRedLightning'
		DamageTypeArm=Class'BallisticProV55.DT_HVCRedLightning'
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		Recoil=96.000000
		BotRefireRate=0.4
		WarnTargetPct=0.8
		FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-SecFire',Volume=0.900000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.700000
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.200000
		YRandFactor=0.200000
		DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-500,Yaw=-1024)
		AimAdjustTime=0.400000
		AimSpread=(Min=2,Max=2)
		ChaosSpeedThreshold=600.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        SightPivot=(Pitch=1024)
		SightOffset=(X=-12.000000,Z=26.000000)
		InventorySize=35
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}