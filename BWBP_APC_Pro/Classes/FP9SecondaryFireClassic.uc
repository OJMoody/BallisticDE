class FP9SecondaryFireClassic extends BallisticFire;

simulated event ModeDoFire()
{
	if (AllowFire())
		FP9ExplosiveClassic(Weapon).Detonate();

    NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     EffectString="Detonate"
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_FP9Ammo'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
