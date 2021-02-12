class HKMK23WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.63
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.50000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.4
		ADSMultiplier=2
		AimAdjustTime=0.350000
		ChaosDeclineTime=0.4500000
		ChaosSpeedThreshold=1400.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.1
		SightingTime=0.200000
		MagAmmo=8
        InventorySize=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}