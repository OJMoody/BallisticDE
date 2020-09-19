//-----------------------------------------------------------
// DIRTY DEEDS SOON,
// JUST YOU WAIT ]:>
//-----------------------------------------------------------
class CFBallisticPlayer extends BallisticPlayer;

var CFLocalClientServiceActor lsa;

var Material BulletTimeOverlay;
var Sound HeartBeat;
var float lastPlayedHeartBeat; // we need this ugly shit since the ambient sounds are for the ass
var bool bHeartBeat;// another of this shitfuck vars we need to work around the crappy ambience

var bool bulletTimeInitiated;

replication
{
	reliable if(Role == ROLE_Authority)
		PlayBulletTimeSound, lsa, bulletTimeInitiated, EnableHeartBeatSound;
}

function RenderOverlays(Canvas C)
{
	Super.RenderOverlays(C);

	// we draw the bullet time shader
	if(lsa != none && lsa.bulletTime)
	{
 		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		C.DrawTile(BulletTimeOverlay, C.SizeX, C.SizeY, 0, 0, 1024, 1024);
	}
}

simulated function PlayBulletTimeSound(bool btStart)
{
	if(btStart)
	{
		ClientPlaySound(Sound'CFMutatorSnd.BulletTime.bt_start', false, 2.0, SLOT_None);
	}
	else
	{
		DisableHeartBeatSound();
		ClientPlaySound(Sound'CFMutatorSnd.BulletTime.bt_end', true, 2.0, SLOT_Misc);
	}
}

simulated function EnableHeartBeatSound()
{
	bHeartBeat = true;
	lastPlayedHeartBeat = -1;
}

simulated function DisableHeartBeatSound()
{
	bHeartBeat = false;
	lastPlayedHeartBeat = -2;
}

event PlayerTick( float DeltaTime )
{
	Super.PlayerTick(DeltaTime);

	if(bHeartBeat && bulletTimeInitiated)
	{
		if((Level.TimeSeconds - lastPlayedHeartBeat) >= 0.55 || lastPlayedHeartBeat == -1)
		{
			ClientPlaySound(HeartBeat, true, 2.0, SLOT_Misc);
			//PlayOwnedSound(HeartBeat,SLOT_Misc,2.0,false);
			lastPlayedHeartBeat = Level.TimeSeconds;
		}
	}
}

function ClientGameEnded()
{
	Super.ClientGameEnded();

 	// open the statistics page
 	Mutate("CFScoreboardMenu");
}

defaultproperties
{
     BulletTimeOverlay=FinalBlend'CFMutatorTex.BulletTime.BulletTimeFinal'
     HeartBeat=Sound'CFMutatorSnd.BulletTime.bt_heartclean'
     lastPlayedHeartBeat=-2.000000
     PawnClass=Class'cfmutator.CFBallisticPawn'
}
