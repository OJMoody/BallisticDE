//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class ComboBulletTime extends Combo;

var float normalSpeed;
var bool btEnded;
var Pawn Pa;
var CFBallisticPawn PInitiator;
var bool btStopped;

function StartEffect(xPawn P)
{
	 broadcastBulletTimeSound(true);

	 normalSpeed = Level.Game.GameSpeed;
	 Level.Game.bAllowMPGameSpeed = true;
	 Level.Game.SetGameSpeed(0.05);
	 Level.GRI.WeaponBerserk = 10;

	 SetTimer(0.25, true);

	 if(CFBallisticPawn(P) != none)
	 {
	 	PInitiator = CFBallisticPawn(P);
	 	CFBallisticPawn(P).initiateBulletTime(true);
	 	CFBallisticPawn(P).serverInitiateBulletTime(true, normalSpeed);

	 	if(P.Controller != none && CFBallisticPlayer(P.Controller) != none)
			CFBallisticPlayer(CFBallisticPawn(P).Controller).bulletTimeInitiated = true;
	 }
}

function StopEffect(xPawn P)
{
	if(!btEnded)
	{
		btEnded = true;
		broadcastBulletTimeSound(false);
		Pa = P;
	}
	stopBulletTime();
}

simulated function Tick(float DeltaTime)
{
	local Pawn P;

	P = Pawn(Owner);

	if(btEnded)
		return;

	if ( (P == None) || (P.Controller == None) )
	{
		Destroy();
		return;
	}
	if ( (P.Controller.PlayerReplicationInfo != None) && (P.Controller.PlayerReplicationInfo.HasFlag != None) )
		DeltaTime *= 2;
	P.Controller.Adrenaline -= AdrenalineCost*DeltaTime/Duration;
	if (P.Controller.Adrenaline <= 0.0)
	{
		P.Controller.Adrenaline = 0.0;
		btEnded = true;
		broadcastBulletTimeSound(false);
		Pa = P;
		stopBulletTime();
	}
}

function broadcastBulletTimeSound(bool btStart)
{
	local Controller C;

	for (C=Level.ControllerList;C!=None;C=C.NextController)
	{
		if(CFBallisticPlayer(C) != none)
			CFBallisticPlayer(C).PlayBulletTimeSound(btStart);
	}
}

function stopBulletTime()
{
	if(!btStopped)
	{
		btStopped = true;

		if(Pa != none && CFBallisticPawn(Pa) != none)
		{
			CFBallisticPawn(Pa).initiateBulletTime(false);
			CFBallisticPawn(Pa).serverInitiateBulletTime(false, normalSpeed);

			if(Pa.Controller != none && CFBallisticPlayer(Pa.Controller) != none)
				CFBallisticPlayer(Pa.Controller).bulletTimeInitiated = false;
		}

		Destroy();
	 }
}

function Timer()
{
	// we start the hartbeat sound delayed
	if(PInitiator != none && PInitiator.Controller != none && CFBallisticPlayer(PInitiator.Controller) != none)
	{
		CFBallisticPlayer(PInitiator.Controller).EnableHeartBeatSound();
	}

	// to ensure the timer exit the loop. k4 timers are funky sometimes ...
	SetTimer(0, false);
}

defaultproperties
{
     ExecMessage="Bullet Time!"
     Duration=1.000000
}
