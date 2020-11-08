class RGPWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=1.500000
		YRandFactor=0.700000
		DeclineDelay=0.2500000
		DeclineTime=1.00000
		MaxRecoil=512
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.200000
		FallingChaos=0.200000
		SprintChaos=0.200000
		AimAdjustTime=0.900000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=380.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=12
		SightMoveSpeedFactor=0.85
		SightingTime=0.4		
		DisplaceDurationMult=1
		MagAmmo=4
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}