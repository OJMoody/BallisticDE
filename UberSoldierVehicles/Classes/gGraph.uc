// ============================================================================
//  gGraph.uc :: Dummy graph class
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGraph extends KVehicle
    cacheexempt;


simulated event Tick( float DeltaSeconds )
{
    //Disable('Tick');
}

simulated event PreBeginPlay()
{
}

simulated event PostBeginPlay()
{
    Log( "Initialized", name );
}

simulated event Destroyed()
{
    Log( "Destroyed", name );
}

simulated event PostNetBeginPlay()
{
}

event FellOutOfWorld( eKillZType KillType )
{
}


// ============================================================================

defaultproperties
{
     bLOSHearing=False
     DrawType=DT_None
     bAcceptsProjectors=False
     bUpdateSimulatedPosition=False
     bGameRelevant=True
     bTravel=False
     bCanBeDamaged=False
     bShouldBaseAtStartup=False
     bAlwaysTick=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bCollideActors=False
     bBlockActors=False
     bProjTarget=False
     bBlockZeroExtentTraces=False
     bBlockNonZeroExtentTraces=False
     bBlockKarma=False
     Begin Object Class=KarmaParamsCollision Name=KGraphParams
     End Object
     KParams=KarmaParamsCollision'GDebug.gGraph.KGraphParams'

     bNotOnDedServer=True
}
