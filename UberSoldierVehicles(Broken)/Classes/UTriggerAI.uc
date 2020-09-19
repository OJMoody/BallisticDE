class UTriggerAI extends DKVehicles;

simulated function PostBeginPlay()
{
          Spawn(class'Emitter_World_AI',self,,Location); 
}

simulated function Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{
}
