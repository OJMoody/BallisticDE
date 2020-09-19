//=============================================================================
// Game_BWslothConflict.
//=============================================================================
class Game_BWslothConflict extends Game_BWConflict config(BallisticGrobtators) DependsOn(Mut_Loadout);

function Bot SpawnBot(optional string botName)
{
	local Bot B;

	B = Super.SpawnBot(botName);
	if (B != None && B.PawnClass == class'xPawn')
		B.PawnClass = class'MyBWPawn';
	if (B != None && B.PawnClass == class'BallisticPawn')
		B.PawnClass = class'MyBWPawn';

	return B;
}

event PlayerController Login( string Portal, string Options, out string Error )
{
	local PlayerController pc;

	pc = Super.Login(Portal, Options, Error);
	if (pc != None && pc.PawnClass == class'xPawn')
	if (pc != None && pc.PawnClass == class'BallisticPawn')
		pc.PawnClass = class'MyBWPawn';
	return pc;
}

defaultproperties
{
     DefaultPlayerClassName="BallisticGrobtators.MyBWPawn"
     PlayerControllerClassName="BallisticGrobtators.BWSlothPlayer"
     GameName="BW-Sloth Conflict"
     Description="Sloth version of Ballistic Conflict"
     DecoTextName="BallisticGrobtators.Game_BWslothConflict"
     Acronym="BWSC"
}
