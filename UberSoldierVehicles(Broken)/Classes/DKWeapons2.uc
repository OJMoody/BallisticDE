//-------------------------------------//
//  Have no experience in C++ =D       //
//  Weapons For Ballistic Weapon 2.5   //
//  UberSoldier 2014-2019 RUSSIAN      //
//-------------------------------------//

class DKWeapons2 extends ONSTankSecondaryTurretPawn;

var class<Projectile> TeamProjectileClasses[2];

simulated function byte BestMode()
{
	local bot B;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return 0;

	if ( (Vehicle(B.Enemy) != None)
	     && (B.Enemy.bCanFly || B.Enemy.IsA('ONSWheeledCraft')) )
		return 1;
	else
		return 0;
}

defaultproperties
{
     bHasAltFire=True
     FPCamPos=(X=-50.000000,Z=50.000000)
     TPCamDistance=150.000000
     TPCamWorldOffset=(Z=100.000000)
     VehiclePositionString="MG"
     VehicleNameString="MG"
     bAlwaysRelevant=True
}
