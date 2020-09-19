//=============================================================================
// Mut_BWVehicles
//
//Small mutator, to swap stock vehicles, with slightly improved BW vehicles
//=============================================================================
class Mut_UIPVehicles extends Mutator config(BallisticVehiclesProV55);

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
     Swaps(0)=(NewVehicles=(Class'DKoppIIVehicles.AH64',Class'DKoppIIVehicles.Defender'),OldVehicle=Class'Onslaught.ONSPRV')
     Swaps(1)=(NewVehicles=(Class'DKoppIIVehicles.Abrams',Class'DKoppIIVehicles.AbramsMK2',Class'DKoppIIVehicles.Hammer'),OldVehicle=Class'Onslaught.ONSRV')
     Swaps(2)=(NewVehicles=(Class'DKoppIIVehicles.IFB',Class'DKoppIIVehicles.IFV'),OldVehicle=Class'Onslaught.ONSHoverBike')
	 Swaps(3)=(NewVehicles=(Class'DKoppIIVehicles.Alligator',Class'DKoppIIVehicles.Infiltrator'),OldVehicle=Class'Onslaught.ONSHoverTank')
	 Swaps(4)=(NewVehicles=(Class'DKoppIIVehicles.Amazon',Class'DKoppIIVehicles.Ispolin'),OldVehicle=Class'Onslaught.ONSAttackCraft')
     Swaps(5)=(NewVehicles=(Class'DKoppIIVehicles.Anakonda',Class'DKoppIIVehicles.Leopard'),OldVehicle=Class'OnslaughtBP.ONSDualAttackCraft')
     Swaps(6)=(NewVehicles=(Class'DKoppIIVehicles.BattleMaster',Class'DKoppIIVehicles.Libra'),OldVehicle=Class'OnslaughtBP.ONSArtillery')
	 Swaps(7)=(NewVehicles=(Class'DKoppIIVehicles.Bredley',Class'DKoppIIVehicles.Merkava',Class'DKoppIIVehicles.T90MK2'),OldVehicle=Class'OnslaughtBP.ONSShockTank')
     GroupName="VehicleArena"
     FriendlyName="UberSoldier Import: Vehicles"
     Description="Replaces vehicles with the UberSoldier Import Vehicle Collection for Ballistic Weapons."
}
