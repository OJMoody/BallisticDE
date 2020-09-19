//=============================================================================
// CFClientServiceActor.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFLocalClientServiceActor extends Actor;

// we define several single PRI vars, because arrays are replicated entirely if one value is changed which might be laggy or buggy
var byte knifeKillsPeak;
var PlayerReplicationInfo knifeCurrent;
var PlayerReplicationInfo knifeFormer;

var byte suicidesPeak;
var PlayerReplicationInfo suicideCurrent;

var byte mgKillsPeak;
var PlayerReplicationInfo mgCurrent;
var PlayerReplicationInfo mgFormer;

var byte grenadeKillsPeak;
var PlayerReplicationInfo grenadeCurrent;
var PlayerReplicationInfo grenadeFormer;

var byte bluntKillsPeak;
var PlayerReplicationInfo bluntCurrent;
var PlayerReplicationInfo bluntFormer;

var byte spawnKillsPeak;
var PlayerReplicationInfo spawnCurrent;
var PlayerReplicationInfo spawnFormer;

var byte headshotsPeak;
var PlayerReplicationInfo hsCurrent;
var PlayerReplicationInfo hsFormer;

var byte pyroPeak;
var PlayerReplicationInfo pyroCurrent;
var PlayerReplicationInfo pyroFormer;

var byte revolverPeak;
var PlayerReplicationInfo revCurrent;
var PlayerReplicationInfo revFormer;

var byte SniperPeak;
var PlayerReplicationInfo sniperCurrent;
var PlayerReplicationInfo sniperFormer;

var byte GasPeak;
var PlayerReplicationInfo gasCurrent;
var PlayerReplicationInfo gasFormer;

var bool bulletTime;
var bool tbBlletTime;
var float normalSpeed;

replication
{
	reliable if(Role==ROLE_Authority)
		revCurrent, knifeCurrent, suicideCurrent, mgCurrent, grenadeCurrent, bluntCurrent, spawnCurrent, hsCurrent, pyroCurrent, sniperCurrent, gasCurrent,
		knifeKillsPeak, suicidesPeak, mgKillsPeak, grenadeKillsPeak, bluntKillsPeak, spawnKillsPeak, headshotsPeak, pyroPeak, bulletTime, revolverPeak, SniperPeak, GasPeak;
}

function stopBulletTime(float originalSpeed)
{
	normalSpeed = originalSpeed;
	tbBlletTime = true;
	SetTimer(0.25, true);
}

function Timer()
{
	if(tbBlletTime)
	{
		tbBlletTime = false;
  		bulletTime = false;
  		Level.Game.SetGameSpeed(normalSpeed);
	}

	SetTimer(0, false);
}

defaultproperties
{
     bHidden=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
}
