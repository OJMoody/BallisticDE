class HKMK23SilencerSwitch extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	if (AllowFire())
		HKMK23Pistol(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_45ACP'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
