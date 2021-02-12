//=============================================================================
// FP9Trigger.
//
// Trigger spawn with FP9Bomb to send Use events
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP9TriggerClassic extends Triggers;

var float TriggerStartTime;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	TriggerStartTime = Level.TimeSeconds + 1;
}

function UsedBy( Pawn user )
{
	if (Owner != None && FP9BombClassic(Owner) != None && TriggerStartTime < Level.TimeSeconds)
		FP9BombClassic(Owner).TryUse(User);
}

defaultproperties
{
     bOnlyAffectPawns=True
     bHardAttach=True
     CollisionRadius=50.000000
     CollisionHeight=80.000000
}
