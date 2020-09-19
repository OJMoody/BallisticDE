//=============================================================================
// Game_BWSlothConficltCTFMaps.
//=============================================================================
class Game_BWSlothConficltCTFMaps extends Game_BWslothConflict;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	FixFlags();

	if (level.NetMode == NM_Client)
		Destroy();
}

simulated function FixFlags()
{
	local CTFFlag F;
	local xCTFBase B;

	ForEach AllActors(Class'CTFFlag', F)
	{
		f.HomeBase.bActive = false;
		F.Destroy();
	}

	if (level.NetMode != NM_DedicatedServer)
		ForEach AllActors(Class'xCTFBase', B)
			B.bHidden=true;
}

defaultproperties
{
     MapPrefix="CTF"
     GameName="BW-Sloth Conflict (CTF Maps)"
     Description="Sloth version of Ballistic Conflict, but played on CTF maps."
     DecoTextName="BallisticGrobtators.Game_BWSlothConficltCTFMaps"
     Acronym="BWSCCM"
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
