//=============================================================================
// BW-Sloth - Realistic movement mut.
//=============================================================================
class MutBWSloth extends Mutator config(BWBPArchivePackPro);

var   globalconfig bool		bForceMyBWPawn;
var config float StrafeScale;
var config float BackScale;
var config float GroundSpeedScale;
var config float AirSpeedScale;
var config float AccelRateScale;
var config float BotGroundSpeedScale;
var config float BotAirSpeedScale;
var config float BotAccelRateScale;
var localized string StrafeText;
var localized string BackText;
var localized string GroundSpeedScaleText;
var localized string AirSpeedScaleText;
var localized string AccelRateScaleText;
var localized string BotGroundSpeedScaleText;
var localized string BotAirSpeedScaleText;
var localized string BotAccelRateScaleText;
var localized string StrafeDesc;
var localized string BackDesc;
var localized string GroundSpeedScaleDesc;
var localized string AirSpeedScaleDesc;
var localized string AccelRateScaleDesc;
var localized string BotGroundSpeedScaleDesc;
var localized string BotAirSpeedScaleDesc;
var localized string BotAccelRateScaleDesc;


function PostBeginPlay()
{
	Level.Game.DefaultPlayerClassName = "BWBPArchivePackDE.MyBWPawn";
}


function PlayerChangedClass(Controller C)
{
	super.PlayerChangedClass (C);
	if (Bot(C) != None && (C.PawnClass	== None || C.PawnClass == class'BallisticPawn' || bForceMyBWPawn) )
		Bot(C).PawnClass = class'BWBPArchivePackDE.MyBWPawn';
}

function ModifyPlayer(Pawn Other)
{
	MyBWPawn(Other).StrafeScale = StrafeScale;
	MyBWPawn(Other).BackScale = BackScale;
	MyBWPawn(Other).GroundSpeed = GroundSpeedScale;
	MyBWPawn(Other).AirSpeed = AirSpeedScale;
	MyBWPawn(Other).AccelRate = AccelRateScale;
	BallisticPawn(Other).GroundSpeed = BotGroundSpeedScale;
	BallisticPawn(Other).AirSpeed = BotAirSpeedScale;
	BallisticPawn(Other).AccelRate = BotAccelRateScale;

	Super.ModifyPlayer(Other);
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.RulesGroup, "StrafeScale", default.StrafeText, 0, 1, "Text", "8;0.50:1.00",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "BackScale", default.BackText, 0, 2,  "Text", "8;0.50:1.00",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "GroundSpeedScale", default.GroundSpeedScaleText, 0, 3,  "Text", "8;180.000000:350.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "AirSpeedScale", default.AirSpeedScaleText, 0, 4,  "Text", "8;180.000000:350.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "AccelRateScale", default.AccelRateScaleText, 0, 5,  "Text", "8;128.000000:1024.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "BotGroundSpeedScale", default.BotGroundSpeedScaleText, 0, 6,  "Text", "8;180.000000:350.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "BotAirSpeedScale", default.BotAirSpeedScaleText, 0, 7,  "Text", "8;180.000000:350.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "BotAccelRateScale", default.BotAccelRateScaleText, 0, 8,  "Text", "8;128.000000:1024.000000",,,True);
}

static event string GetDisplayText( string PropName )
{
	switch (PropName)
	{
    	case "StrafeText":       return default.StrafeText;
    	case "BackText":           return default.BackText;
    	case "GroundSpeedScale":           return default.GroundSpeedScaleText;
      case "AirSpeedScale":           return default.AirSpeedScaleText;
    	case "AccelRateScale":           return default.AccelRateScaleText;
    	case "BotGroundSpeedScale":           return default.BotGroundSpeedScaleText;
      case "BotAirSpeedScale":           return default.BotAirSpeedScaleText;
    	case "BotAccelRateScale":           return default.BotAccelRateScaleText;
	}
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
    	case "StrafeScale":       return default.StrafeDesc;
    	case "BackScale":           return default.BackDesc;
    	case "GroundSpeedScale":           return default.GroundSpeedScaleDesc;
    	case "AirSpeedScale":           return default.AirSpeedScaleDesc;
    	case "AccelRateScale":           return default.AccelRateScaleDesc;
    	case "BotGroundSpeedScale":           return default.BotGroundSpeedScaleDesc;
    	case "BotAirSpeedScale":           return default.BotAirSpeedScaleDesc;
    	case "BotAccelRateScale":           return default.BotAccelRateScaleDesc;
	}

	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     bForceMyBWPawn=True
     StrafeScale=0.700000
     BackScale=0.600000
     GroundSpeedScale=270.000000
     AirSpeedScale=270.000000
     AccelRateScale=256.000000
     BotGroundSpeedScale=270.000000
     BotAirSpeedScale=270.000000
     BotAccelRateScale=256.000000
     StrafeText="StrafeScale"
     BackText="BackwardsScale"
     GroundSpeedScaleText="RunSpeed"
     AirSpeedScaleText="AirSpeed"
     AccelRateScaleText="Acceleration"
     BotGroundSpeedScaleText="Alt-RunSpeed"
     BotAirSpeedScaleText="Alt-AirSpeed"
     BotAccelRateScaleText="Alt-Acceleration"
     StrafeDesc="Strafe speed penalty, choose value between 0.50 and 1.00, 0.60 is default."
     BackDesc="Backwards speed penalty, choose value between 0.50 and 1.00, 0.50 is default."
     GroundSpeedScaleDesc="Running Speed, choose value between 180 and 350, 270 is default."
     AirSpeedScaleDesc="Air Speed, choose value between 180 and 350, 270 is default, best kept same as Runspeed."
     AccelRateScaleDesc="Acceleration rate, choose value between 128 and 1024, 256 is default."
     BotGroundSpeedScaleDesc="Bot support, set identical to RunSpeed."
     BotAirSpeedScaleDesc="Bot support, set identical to Airspeed."
     BotAccelRateScaleDesc="Bot support, set identical to Acceleration values."
     bAddToServerPackages=True
     GroupName="SlothMuts"
     FriendlyName="BallisticPro: Sloth"
     Description="Slower and more realistic movement, and momentum."
     bAlwaysRelevant=True
}
