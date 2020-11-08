class GASCWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.400000,OutVal=0.420000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15000
		YRandFactor=0.3000
		MaxRecoil=4096
		DeclineTime=0.5
		DeclineDelay=0.35000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=512)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=7500.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.150000
		DisplaceDurationMult=1
		MagAmmo=16
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}