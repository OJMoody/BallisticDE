//=============================================================================
// Mut_BWVehicles
//
//Small mutator, to swap stock vehicles, with slightly improved BW vehicles
//=============================================================================
class Mut_BWVehicles extends Mutator config(BallisticVehiclesProV55);

struct VSwap
{
	var() config array<class<Vehicle> >	NewVehicles;
	var() config class<Vehicle> 		OldVehicle;
};
var() config array<VSwap>	Swaps;

function PostBeginPlay()
{
	SetTimer(60, true);
	Timer();
	Super.PostBeginPlay();
}

event Timer()
{
	local int i, j;
	local ONSVehicleFactory FactoryONS;
	local ASVehicleFactory FactoryAS;

	foreach AllActors( class 'ONSVehicleFactory', FactoryONS )
	{
		for (i=0;i<Swaps.length;i++)
			if (Swaps[i].OldVehicle == FactoryONS.VehicleClass)
			{
				FactoryONS.VehicleClass = Swaps[i].NewVehicles[Rand(Swaps[i].NewVehicles.length)];
				break;
			}
	}
	
	foreach AllActors( class 'ASVehicleFactory', FactoryAS )
	{
		for (j=0;j<Swaps.length;j++)
			if (Swaps[j].OldVehicle == FactoryAS.VehicleClass)
			{
				FactoryAS.VehicleClass = Swaps[j].NewVehicles[Rand(Swaps[j].NewVehicles.length)];
				break;
			}
	}	
}


defaultproperties
{
     Swaps(0)=(NewVehicles=(Class'BallisticVehiclesDE.DCTVThorTank'),OldVehicle=Class'Onslaught.ONSHoverTank')
     GroupName="VehicleArena"
     FriendlyName="Ballistic Weapons: Vehicles"
     Description="Replaces vehicles with ones modified to fit in better with Ballistic Weapons."
}
