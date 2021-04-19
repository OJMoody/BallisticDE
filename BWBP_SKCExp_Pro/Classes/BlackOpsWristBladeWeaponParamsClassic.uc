class BlackOpsWristBladeWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=100.000000,Max=100.000000)
		Damage=60
		DamageType=Class'BWBP_SKCExp_Pro.DTBOBTorso'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTBOBHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTBOBLimb'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.100000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Slash1"
		FireAnimRate=0.900000
	FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		Damage=75
		DamageType=Class'BWBP_SKCExp_Pro.DTBOBTorsoLunge'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTBOBHeadLunge'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTBOBTorsoLunge'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.500000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		PreFireAnim="PrepHack"
		FireAnim="Hack"
	FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
        ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.150000
		MagAmmo=1
		InventorySize=3
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}