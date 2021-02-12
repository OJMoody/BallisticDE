class M7A3WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15000
		YRandFactor=0.15000
		DeclineTime=0.65
		DeclineDelay=0.12
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.350000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
		MagAmmo=35
		SightingTime=0.250000
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}