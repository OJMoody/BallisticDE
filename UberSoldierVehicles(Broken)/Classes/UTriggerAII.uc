class UTriggerAII extends DKVehicles;

simulated function PostBeginPlay()
{
          Spawn(class'Emitter_World_AII',self,,Location); 
}

simulated function Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{
}
