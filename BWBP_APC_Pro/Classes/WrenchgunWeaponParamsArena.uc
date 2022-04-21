class WrenchgunWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
			ProjectileClass=Class'BWBP_APC_Pro.WrenchgunWrenchShot'
			SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
			Damage=12
			MomentumTransfer=17000.000000
			MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
			Recoil=1100.000000
			Inaccuracy=(X=440,Y=220)
			Chaos=1
			BotRefireRate=0.300000
			WarnTargetPct=0.300000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			FireInterval=0.350000
			FireAnim="FireCombined"
			AimedFireAnim="SightFireCombined"
			FireAnimRate=0.800000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
			ProjectileClass=Class'BWBP_APC_Pro.WrenchgunWrench'
			SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
			Speed=8500.000000
			MaxSpeed=8500.000000
			Damage=44
			MomentumTransfer=75000.000000
			MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
			Recoil=1100.000000
			Chaos=1
			Inaccuracy=(X=50,Y=25)
			BotRefireRate=0.300000
			WarnTargetPct=0.300000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=1.200000)
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.350000
			FireAnim="FireCombined"
			AimedFireAnim="SightFireCombined"
			FireAnimRate=0.800000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.300000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=0.900000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=None
		AimSpread=(Min=0,Max=128)
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightOffset=(X=-40.000000,Y=12.000000,Z=43.000000)
		SightPivot=(Pitch=256)
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=2
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}