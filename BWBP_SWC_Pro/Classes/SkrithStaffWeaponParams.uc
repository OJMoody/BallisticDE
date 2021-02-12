class SkrithStaffWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.350000
		YRandFactor=0.500000
		DeclineTime=1.500000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=256,Max=768)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.50000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
	    SightingTime=0.550000	 
        MagAmmo=60       
        InventorySize=12
        SightMoveSpeedFactor=0.8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}