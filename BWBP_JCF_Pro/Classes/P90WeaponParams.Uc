class P90WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.06000
		YRandFactor=0.06000
		DeclineDelay=0.1000000
		MaxRecoil=8000
		DeclineTime=0.65
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.05
		ADSMultiplier=1
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.550000
		AimSpread=(Min=32,Max=768)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=850.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        SightingTime=0.25
        MagAmmo=50
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}