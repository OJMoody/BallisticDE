class MG36SecondaryFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
	{
		FireAnim='Undeploy';
		MG36Rifle_TW(Weapon).Notify_Undeploy();
	}
	else
		MG36Rifle(Weapon).Notify_Deploy();
}

defaultproperties
{
     FireRate=1.000000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_50BMG'
}
