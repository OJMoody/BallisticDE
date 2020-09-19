//=============================================================================
// CFScoreboardMenu.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFScoreboardMenu extends CFClientMenu;

var Automated GUIImage MyBack, picBlood2, picBulletHole, picAExplosive, picARevolver, picAMG, picASniper, picAGas, picASpawn, picAHeadshot, picAKnife, picABlunt, picAPyro;
var Automated GUILabel lAdministratorInfoDesc, lAdministratorInfo, lMessageOfTheDay;
var Automated GUIButton btnOK, btnDisconnect;
var automated GUIScrollTextBox lbSettings;
var Automated CFSTY2VertDownButton scrollDownBtnStyle;
var Automated CFSTY2VertUpButton scrollUpBtnStyle;
var Automated CFSTY2ScrollZone scrollZoneStyle;
var Automated CFSTY2RoundButton scrollButtonStyle;

var sound originalMouseOverSound;
var sound originalClickSound;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<Texture> bloodStances2;

	Super.InitComponent(MyController, MyOwner);

	originalMouseOverSound = Controller.MouseOverSound;
	originalClickSound = Controller.ClickSound;

	Controller.MouseOverSound=Sound'BWBP4-Sounds.Art-StandClose-1';
//	Controller.ClickSound=Sound'BallisticSounds3.R78.R78-Fire';
//	Controller.PlayInterfaceSound(CS_Click);
	Controller.ClickSound=Sound'BallisticSounds3.USSR.USSR-Fire';

	bloodStances2.Insert(0,4);
	bloodStances2[0] = Texture'BallisticBlood25.Decals.Slash1';
	bloodStances2[1] = Texture'BallisticBlood25.Decals.Slash2';
	bloodStances2[2] = Texture'BallisticBlood25.Decals.Slash3';
	bloodStances2[3] = Texture'BallisticBlood25.Decals.Slash4';

	picBlood2.Image = bloodStances2[Rand(bloodStances2.length)];

	lbSettings.MyScrollBar.MyIncreaseButton.Style = scrollDownBtnStyle;
	lbSettings.MyScrollBar.MyIncreaseButton.StyleName = "CFScrollDown";

	lbSettings.MyScrollBar.MyDecreaseButton.Style = scrollUpBtnStyle;
	lbSettings.MyScrollBar.MyDecreaseButton.StyleName = "CFScrollUp";

	lbSettings.MyScrollBar.MyScrollZone.Style = scrollZoneStyle;
	lbSettings.MyScrollBar.MyScrollZone.StyleName = "CFScrollZone";

	lbSettings.MyScrollBar.MyGripButton.Style = scrollButtonStyle;
	lbSettings.MyScrollBar.MyGripButton.StyleName = "CFRoundButton";

	lMessageOfTheDay.Caption = "Loading";
	lAdministratorInfo.Caption = "Loading";
	Controller.FocusedControl = lbSettings;
}

function GRIAccessible()
{
	fillSettingsList();
}

function fillSettingsList()
{
	local string content;
	local string clrCodeBlack;
	local Color clrBlack;
	local string clrCodeGrey;
	local Color clrGrey;

	local Color clrOrange;
	local string clrCodeOrange;

	local string kdRatio;
	local CFClientServiceActor sa;
	local CFLocalClientServiceActor lsa, lsat;

	local string clrCodeRed;
	local Color clrRed;
	local string clrCodeGreen;
	local Color clrGreen;

	local string clrCodeBlue;
	local Color clrBlue;

	local string strTemp;
	local bool boolTemp;
	local byte countTemp;
	local int i;

	clrOrange = Class'Canvas'.static.MakeColor(255,153,0,255);
	clrCodeOrange = MakeColorCode(clrOrange);

	clrBlue = Class'Canvas'.static.MakeColor(0,74,127,255);
	clrCodeBlue = MakeColorCode(clrBlue);

	clrRed = Class'Canvas'.static.MakeColor(127,0,0,255);
	clrCodeRed = MakeColorCode(clrRed);

	clrGreen = Class'Canvas'.static.MakeColor(0,127,14,255);
	clrCodeGreen = MakeColorCode(clrGreen);

	clrBlack = Class'Canvas'.static.MakeColor(0,0,0,255);
	clrCodeBlack = MakeColorCode(clrBlack);

	clrGrey = Class'Canvas'.static.MakeColor(79,79,79,255);
	clrCodeGrey = MakeColorCode(clrGrey);

	content = clrCodeBlack$"|- ACHIEVEMENTS -|";

	picBulletHole.Image = PC.PlayerReplicationInfo.GetPortrait();

	foreach PC.Level.DynamicActors(class'CFLocalClientServiceActor', lsa)
	{
		lsat = lsa;

		content $= "|";
		if(lsa.revolverPeak >= 5 && lsa.revCurrent != none)
 			content $= IntToColorBlue(lsa.revolverPeak)$clrCodeGrey$" revolver kills  -  "$clrCodeBlack$lsa.revCurrent.PlayerName$"|";

 		if(lsa.mgKillsPeak >= 5 && lsa.mgCurrent != none)
			content $= IntToColorBlue(lsa.mgKillsPeak)$clrCodeGrey$" MG bullet hails  -  "$clrCodeBlack$lsa.mgCurrent.PlayerName$"|";

 		if(lsa.SniperPeak >= 5 && lsa.sniperCurrent != none)
			content $= IntToColorBlue(lsa.SniperPeak)$clrCodeGrey$" marksman kills  -  "$clrCodeBlack$lsa.sniperCurrent.PlayerName$"|";

		if(lsa.grenadeKillsPeak >= 1 && lsa.grenadeCurrent != none)
			content $= IntToColorBlue(lsa.grenadeKillsPeak)$clrCodeGrey$" explosve kills  -  "$clrCodeBlack$lsa.grenadeCurrent.PlayerName$"|";

		if(lsa.spawnKillsPeak >= 1 && lsa.spawnCurrent != none)
			content $= IntToColorBlue(lsa.spawnKillsPeak)$clrCodeGrey$" spawn raids  -  "$clrCodeBlack$lsa.spawnCurrent.PlayerName$"|";

		if(lsa.headshotsPeak >= 3 && lsa.hsCurrent != none)
 			content $= IntToColorBlue(lsa.headshotsPeak)$clrCodeGrey$" brain surgeries  -  "$clrCodeBlack$lsa.hsCurrent.PlayerName$"|";

		if(lsa.knifeKillsPeak >= 1 && lsa.knifeCurrent != none)
 			content $= IntToColorBlue(lsa.knifeKillsPeak)$clrCodeGrey$" melee murders  -  "$clrCodeBlack$lsa.knifeCurrent.PlayerName$"|";

		if(lsa.bluntKillsPeak >= 1 && lsa.bluntCurrent != none)
			content $= IntToColorBlue(lsa.bluntKillsPeak)$clrCodeGrey$" bludgeonings  -  "$clrCodeBlack$lsa.bluntCurrent.PlayerName$"|";

		if(lsa.pyroPeak >= 5 && lsa.pyroCurrent != none)
 			content $= IntToColorBlue(lsa.pyroPeak)$clrCodeGrey$" fireworks  -  "$clrCodeBlack$lsa.pyroCurrent.PlayerName$"|";

		if(lsa.GasPeak >= 1 && lsa.gasCurrent != none)
			content $= IntToColorBlue(lsa.GasPeak)$clrCodeGrey$" delousings  -  "$clrCodeBlack$lsa.gasCurrent.PlayerName$"|";
	}

	foreach PC.Level.DynamicActors(class'CFClientServiceActor', sa)
	{
		if(sa.pri != none)
		{
			if(sa.pri == PC.PlayerReplicationInfo)
			{
				if(sa.iKills <= 0 && PC.PlayerReplicationInfo.Deaths <= 0)
					kdRatio = "0";
				else if(sa.iKills <= 0)
					kdRatio = "Bottomfeeder";
				else if(PC.PlayerReplicationInfo.Deaths <= 0)
					kdRatio = "Invincible";
				else
					kdRatio = ""$float(sa.iKills) / PC.PlayerReplicationInfo.Deaths;

				lAdministratorInfoDesc.Caption = clrCodeBlue$"Total score: "$IntToColorBlue(Max(0,PC.PlayerReplicationInfo.Score));
				lAdministratorInfo.Caption = clrCodeGreen$"Kills: "$IntToColorGreen(sa.iKills)$clrCodeBlack$"     "$clrCodeRed$"Deaths: "$IntToColorRed(Max(0,PC.PlayerReplicationInfo.Deaths))$"|"$clrCodeGrey$"KD: "$kdRatio;
				lMessageOfTheDay.Caption = PC.PlayerReplicationInfo.PlayerName$"|"$clrCodeGrey$PC.GameReplicationInfo.GameName$" - "$PC.GameReplicationInfo.Level.Title;

				// badges
				if(lsat.revCurrent == none || lsat.revolverPeak < 5 || lsat.revCurrent != sa.pri)
					picARevolver.Image=Texture'CFMutatorTex.Badges.RevolverG';

		 		if(lsat.mgCurrent == none || lsat.mgKillsPeak < 5 || lsat.mgCurrent != sa.pri)
					picAMG.Image=Texture'CFMutatorTex.Badges.MGG';

		 		if(lsat.sniperCurrent == none || lsat.sniperPeak < 5 || lsat.sniperCurrent != sa.pri)
					picASniper.Image=Texture'CFMutatorTex.Badges.SniperG';

				if(lsat.grenadeCurrent == none || lsat.grenadeCurrent != sa.pri)
					picAExplosive.Image=Texture'CFMutatorTex.Badges.ExplosivesG';

				if(lsat.spawnCurrent == none || lsat.spawnCurrent != sa.pri)
					picASpawn.Image=Texture'CFMutatorTex.Badges.SpawnRaidG';

				if(lsat.hsCurrent == none || lsat.headshotsPeak < 3 || lsat.hsCurrent != sa.pri)
					picAHeadshot.Image=Texture'CFMutatorTex.Badges.HeadshotG';

				if(lsat.knifeCurrent == none || lsat.knifeCurrent != sa.pri)
					picAKnife.Image=Texture'CFMutatorTex.Badges.MeleeG';

				if(lsat.bluntCurrent == none || lsat.bluntCurrent != sa.pri)
					picABlunt.Image=Texture'CFMutatorTex.Badges.BluntG';

				if(lsat.pyroCurrent == none || lsat.pyroPeak < 5 || lsat.pyroCurrent != sa.pri)
					picAPyro.Image=Texture'CFMutatorTex.Badges.PyroG';

				if(lsat.gasCurrent == none || lsat.gasCurrent != sa.pri)
					picAGas.Image=Texture'CFMutatorTex.Badges.GasG';
			}

				if(sa.iKills <= 0 && sa.pri.Deaths <= 0)
					kdRatio = "0";
				else if(sa.iKills <= 0)
					kdRatio = "Bottomfeeder";
				else if(sa.pri.Deaths <= 0)
					kdRatio = "Invincible";
				else
					kdRatio = ""$float(sa.iKills) / sa.pri.Deaths;

			content $= clrCodeBlack$"||*** *** ***   "$sa.pri.PlayerName$"   *** *** ***||"$clrCodeGrey;

			content $= "Total Score: "$IntToColorBlue(Max(0,sa.pri.Score))$"|"$clrCodeGrey;
			content $= "Kills: "$IntToColorGreen(sa.iKills)$"|"$clrCodeGrey;
			content $= "Deaths: "$IntToColorRed(Max(0,sa.pri.Deaths))$"|"$clrCodeGrey;

			// Suicides
			countTemp = 1;
			boolTemp = false;
			while(!boolTemp)
			{
				if(sa.iSuicides - countTemp < 0)
				{
					strTemp = "|";
					boolTemp = true;
					break;
				}

				if(class'CFMasochistMessage'.default.KillString[Min(sa.iSuicides-countTemp,19)] == "")
				{
					countTemp += 1;
				}
				else
				{
					if(countTemp >= 1)
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFMasochistMessage'.Static.GetString(sa.iSuicides - countTemp + 1, none, none, none)$clrCodeGrey$"]|";
					else
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFMasochistMessage'.Static.GetString(sa.iSuicides, none, none, none)$clrCodeGrey$"]|";
					boolTemp = true;
				}
			}

			content $="Suicides: "$IntToColorBlue(sa.iSuicides)$strTemp;
			content $= "KD: "$clrCodeGrey$kdRatio$clrCodeGrey$"||";

			// REVOLVER
			content $=clrCodeGrey$"Revolver level = "$IntToColorBlue(sa.iRevolver)$"|";

			// MG
			countTemp = 1;
			boolTemp = false;
			while(!boolTemp)
			{
				if(sa.iMGKills - countTemp < 0)
				{
					strTemp = "|";
					boolTemp = true;
					break;
				}

				if(class'CFMGMessage'.default.KillString[Min(sa.iMGKills-countTemp,19)] == "")
				{
					countTemp += 1;
				}
				else
				{
					if(countTemp >= 1)
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFMGMessage'.Static.GetString(sa.iMGKills - countTemp + 1, none, none, none)$clrCodeGrey$"]|";
					else
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFMGMessage'.Static.GetString(sa.iMGKills, none, none, none)$clrCodeGrey$"]|";
					boolTemp = true;
				}
			}
			content $=clrCodeGrey$"MG level = "$IntToColorBlue(sa.iMGKills)$strTemp;

			// Marksman
			content $=clrCodeGrey$"Marksman level = "$IntToColorBlue(sa.iSniperKills)$"|";

			// Grenade
			countTemp = 1;
			boolTemp = false;
			while(!boolTemp)
			{
				if(sa.iGrenadeKills - countTemp < 0)
				{
					strTemp = "|";
					boolTemp = true;
					break;
				}

				if(class'CFExplosiveMessage'.default.KillString[Min(sa.iGrenadeKills-countTemp,14)] == "")
				{
					countTemp += 1;
				}
				else
				{
					if(countTemp >= 1)
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFExplosiveMessage'.Static.GetString(sa.iGrenadeKills - countTemp + 1, none, none, none)$clrCodeGrey$"]|";
					else
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFExplosiveMessage'.Static.GetString(sa.iGrenadeKills, none, none, none)$clrCodeGrey$"]|";
					boolTemp = true;
				}
			}
			content $=clrCodeGrey$"Explosive level = "$IntToColorBlue(sa.iGrenadeKills)$strTemp;

			// Spawn raids
			countTemp = 1;
			boolTemp = false;
			while(!boolTemp)
			{
				if(sa.iSpawnKills - countTemp < 0)
				{
					strTemp = "|";
					boolTemp = true;
					break;
				}

				if(class'CFSpawnKillMessage'.default.KillString[Min(sa.iSpawnKills-countTemp,14)] == "")
				{
					countTemp += 1;
				}
				else
				{
					if(countTemp >= 1)
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFSpawnKillMessage'.Static.GetString(sa.iSpawnKills - countTemp + 1, none, none, none)$clrCodeGrey$"]|";
					else
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFSpawnKillMessage'.Static.GetString(sa.iSpawnKills, none, none, none)$clrCodeGrey$"]|";
					boolTemp = true;
				}
			}
			content $=clrCodeGrey$"Spawn raids = "$IntToColorBlue(sa.iSpawnKills)$strTemp;


			// HEADSHOTS
			content $="|"$clrCodeGrey$"Headshots = "$IntToColorBlue(sa.iHeadshots)$"|";

			// Melee
			countTemp = 1;
			boolTemp = false;
			while(!boolTemp)
			{
				if(sa.iKnifeKills - countTemp < 0)
				{
					strTemp = "|";
					boolTemp = true;
					break;
				}

				if(class'CFHrDoctorMessage'.default.KillString[Min(sa.iKnifeKills-countTemp,14)] == "")
				{
					countTemp += 1;
				}
				else
				{
					if(countTemp >= 1)
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFHrDoctorMessage'.Static.GetString(sa.iKnifeKills - countTemp + 1, none, none, none)$clrCodeGrey$"]|";
					else
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFHrDoctorMessage'.Static.GetString(sa.iKnifeKills, none, none, none)$clrCodeGrey$"]|";
					boolTemp = true;
				}
			}
			content $=clrCodeGrey$"Melee level = "$IntToColorBlue(sa.iKnifeKills)$strTemp;

			// Blunt
			countTemp = 1;
			boolTemp = false;
			while(!boolTemp)
			{
				if(sa.iBluntKills - countTemp < 0)
				{
					strTemp = "|";
					boolTemp = true;
					break;
				}

				if(class'CFBluntMessage'.default.KillString[Min(sa.iBluntKills-countTemp,14)] == "")
				{
					countTemp += 1;
				}
				else
				{
					if(countTemp >= 1)
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFBluntMessage'.Static.GetString(sa.iBluntKills - countTemp + 1, none, none, none)$clrCodeGrey$"]|";
					else
						strTemp = clrCodeGrey$"  ["$clrCodeOrange$class'CFBluntMessage'.Static.GetString(sa.iBluntKills, none, none, none)$clrCodeGrey$"]|";
					boolTemp = true;
				}
			}
			content $=clrCodeGrey$"Blunt level = "$IntToColorBlue(sa.iBluntKills)$strTemp;

			// PYRO
			content $=clrCodeGrey$"Pyro level = "$IntToColorBlue(sa.iPyro);

			// GAS
			content $="|"$clrCodeGrey$"Gassed = "$IntToColorBlue(sa.iGas);

			content $="|"$clrCodeBlack$"|*** *** ***   ";

			for(i = 0; i < Len(sa.pri.PlayerName); i++)
				content $= "*";

			content $= "   *** *** ***|";
		}
	}

	lbSettings.SetContent(content);


}

function CFClientServiceActor GetClientServiceActor(Controller C)
{
	local int i;

	if(C != none)
	{
		for(i = 0; i < C.Attached.Length; ++i)
		{
			if(C.Attached[i].IsA('CFClientServiceActor'))
				return CFClientServiceActor(C.Attached[i]);
		}
	}

	return none;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==btnOK) // CANCEL
	{
		Controller.CloseMenu();
	}else if(Sender==btnDisconnect)
	{
		PC.ConsoleCommand("DISCONNECT",false);
	}
	return true;
}

function string BoolToColorString(bool b)
{
	local string clrCodeRed;
	local Color clrRed;
	local string clrCodeGreen;
	local Color clrGreen;

	clrRed = Class'Canvas'.static.MakeColor(127,0,0,255);
	clrCodeRed = MakeColorCode(clrRed);

	clrGreen = Class'Canvas'.static.MakeColor(0,127,14,255);
	clrCodeGreen = MakeColorCode(clrGreen);

	if(b)
		return clrCodeGreen$"True";
	else
		return clrCodeRed$"False";
}

function string FloatToColorBlue(float f)
{
	local string clrCodeBlue;
	local Color clrBlue;

	clrBlue = Class'Canvas'.static.MakeColor(0,74,127,255);
	clrCodeBlue = MakeColorCode(clrBlue);

	return clrCodeBlue$f;
}

function string IntToColorBlue(int i)
{
	local string clrCodeBlue;
	local Color clrBlue;

	clrBlue = Class'Canvas'.static.MakeColor(0,74,127,255);
	clrCodeBlue = MakeColorCode(clrBlue);
	return clrCodeBlue$i;
}

function string IntToColorRed(int i)
{
	local string clrCodeRed;
	local Color clrRed;

	clrRed = Class'Canvas'.static.MakeColor(127,0,0,255);
	clrCodeRed = MakeColorCode(clrRed);
	return clrCodeRed$i;
}

function string IntToColorGreen(int i)
{
	local string clrCodeGreen;
	local Color clrGreen;

	clrGreen = Class'Canvas'.static.MakeColor(0,127,14,255);
	clrCodeGreen = MakeColorCode(clrGreen);
	return clrCodeGreen$i;
}

simulated function bool CloseMenu()
{
	return InternalOnClick(btnOK);
}

delegate OnClose(optional bool bCancelled)
{
	//Controller.PlayInterfaceSound(CS_Click);

	Controller.MouseOverSound = originalMouseOverSound;
	Controller.ClickSound = originalClickSound;

	if(previPage != none)
		previPage.Show();
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'CFMutatorTex.Controls.AchievementsDialog'
         ImageStyle=ISTY_Scaled
         WinTop=0.100000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'cfmutator.CFScoreboardMenu.BackImage'

     Begin Object Class=GUIImage Name=picBlood2I
         Image=Texture'BallisticBlood25.Decals.Slash1'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Modulated
         WinTop=0.170000
         WinLeft=0.290000
         WinWidth=0.280000
         WinHeight=0.220000
         RenderWeight=0.002000
     End Object
     picBlood2=GUIImage'cfmutator.CFScoreboardMenu.picBlood2I'

     Begin Object Class=GUIImage Name=picBulletHoleI
         Image=Texture'PlayerPictures.cBotCA'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.408000
         WinLeft=0.162000
         WinWidth=0.087000
         WinHeight=0.282500
     End Object
     picBulletHole=GUIImage'cfmutator.CFScoreboardMenu.picBulletHoleI'

     Begin Object Class=GUIImage Name=picAExplosiveI
         Image=Texture'CFMutatorTex.Badges.Explosives'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.580000
         WinLeft=0.267000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picAExplosive=GUIImage'cfmutator.CFScoreboardMenu.picAExplosiveI'

     Begin Object Class=GUIImage Name=picARevolverI
         Image=Texture'CFMutatorTex.Badges.Revolver'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.395000
         WinLeft=0.267000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picARevolver=GUIImage'cfmutator.CFScoreboardMenu.picARevolverI'

     Begin Object Class=GUIImage Name=picAMGI
         Image=Texture'CFMutatorTex.Badges.MG'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.465000
         WinLeft=0.267000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picAMG=GUIImage'cfmutator.CFScoreboardMenu.picAMGI'

     Begin Object Class=GUIImage Name=picASniperI
         Image=Texture'CFMutatorTex.Badges.Sniper'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.525000
         WinLeft=0.267000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picASniper=GUIImage'cfmutator.CFScoreboardMenu.picASniperI'

     Begin Object Class=GUIImage Name=picAGasI
         Image=Texture'CFMutatorTex.Badges.Gas'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.640000
         WinLeft=0.307000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picAGas=GUIImage'cfmutator.CFScoreboardMenu.picAGasI'

     Begin Object Class=GUIImage Name=picASpawnI
         Image=Texture'CFMutatorTex.Badges.SpawnRaid'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.640000
         WinLeft=0.267000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picASpawn=GUIImage'cfmutator.CFScoreboardMenu.picASpawnI'

     Begin Object Class=GUIImage Name=picAHeadshotI
         Image=Texture'CFMutatorTex.Badges.Headshot'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.395000
         WinLeft=0.307000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picAHeadshot=GUIImage'cfmutator.CFScoreboardMenu.picAHeadshotI'

     Begin Object Class=GUIImage Name=picAKnifeI
         Image=Texture'CFMutatorTex.Badges.Melee'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.465000
         WinLeft=0.307000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picAKnife=GUIImage'cfmutator.CFScoreboardMenu.picAKnifeI'

     Begin Object Class=GUIImage Name=picABluntI
         Image=Texture'CFMutatorTex.Badges.Blunt'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.525000
         WinLeft=0.307000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picABlunt=GUIImage'cfmutator.CFScoreboardMenu.picABluntI'

     Begin Object Class=GUIImage Name=picAPyroI
         Image=Texture'CFMutatorTex.Badges.Pyro'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.580000
         WinLeft=0.307000
         WinWidth=0.030000
         WinHeight=0.060000
     End Object
     picAPyro=GUIImage'cfmutator.CFScoreboardMenu.picAPyroI'

     Begin Object Class=GUILabel Name=lTestL
         Caption="Loading"
         TextAlign=TXTA_Center
         TextColor=(B=0)
         FontScale=FNS_Large
         WinTop=0.290000
         WinLeft=0.260000
         WinWidth=0.600000
         WinHeight=0.035000
     End Object
     lAdministratorInfoDesc=GUILabel'cfmutator.CFScoreboardMenu.lTestL'

     Begin Object Class=GUILabel Name=lAdministratorInfoL
         TextAlign=TXTA_Center
         TextColor=(B=0)
         bMultiLine=True
         WinTop=0.320000
         WinLeft=0.260000
         WinWidth=0.600000
         WinHeight=0.070000
     End Object
     lAdministratorInfo=GUILabel'cfmutator.CFScoreboardMenu.lAdministratorInfoL'

     Begin Object Class=GUILabel Name=lMessageOfTheDayL
         TextAlign=TXTA_Center
         TextColor=(B=0)
         bMultiLine=True
         FontScale=FNS_Large
         WinTop=0.220000
         WinLeft=0.260000
         WinWidth=0.580000
         WinHeight=0.070000
     End Object
     lMessageOfTheDay=GUILabel'cfmutator.CFScoreboardMenu.lMessageOfTheDayL'

     Begin Object Class=GUIButton Name=btnOKB
         StyleName="CFPlayBtn1"
         WinTop=0.740000
         WinLeft=0.300000
         WinWidth=0.100000
         TabOrder=1
         Begin Object Class=CF_PlayButton Name=cfStylePlayBtn
         End Object
         Style=CF_PlayButton'cfmutator.CFScoreboardMenu.cfStylePlayBtn'

         OnClick=CFScoreboardMenu.InternalOnClick
         OnKeyEvent=btnOKB.InternalOnKeyEvent
     End Object
     btnOK=GUIButton'cfmutator.CFScoreboardMenu.btnOKB'

     Begin Object Class=GUIButton Name=btnDisconnectB
         StyleName="CFLeaveBtn1"
         WinTop=0.740000
         WinLeft=0.600000
         WinWidth=0.100000
         TabOrder=2
         Begin Object Class=CF_LeaveButton Name=cfStyleLeaveBtn
         End Object
         Style=CF_LeaveButton'cfmutator.CFScoreboardMenu.cfStyleLeaveBtn'

         OnClick=CFScoreboardMenu.InternalOnClick
         OnKeyEvent=btnDisconnectB.InternalOnKeyEvent
     End Object
     btnDisconnect=GUIButton'cfmutator.CFScoreboardMenu.btnDisconnectB'

     Begin Object Class=GUIScrollTextBox Name=SettingsListBox
         bNoTeletype=True
         TextAlign=TXTA_Center
         OnCreateComponent=SettingsListBox.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.381000
         WinLeft=0.248000
         WinWidth=0.610000
         WinHeight=0.335000
         RenderWeight=0.520000
         TabOrder=0
     End Object
     lbSettings=GUIScrollTextBox'cfmutator.CFScoreboardMenu.SettingsListBox'

     Begin Object Class=CFSTY2VertDownButton Name=scrollDownBtnStyleB
     End Object
     scrollDownBtnStyle=CFSTY2VertDownButton'cfmutator.CFScoreboardMenu.scrollDownBtnStyleB'

     Begin Object Class=CFSTY2VertUpButton Name=CFSTY2VertUpButtonB
     End Object
     scrollUpBtnStyle=CFSTY2VertUpButton'cfmutator.CFScoreboardMenu.CFSTY2VertUpButtonB'

     Begin Object Class=CFSTY2ScrollZone Name=CFSTY2ScrollZoneB
     End Object
     scrollZoneStyle=CFSTY2ScrollZone'cfmutator.CFScoreboardMenu.CFSTY2ScrollZoneB'

     Begin Object Class=CFSTY2RoundButton Name=scrollButtonStyleB
     End Object
     scrollButtonStyle=CFSTY2RoundButton'cfmutator.CFScoreboardMenu.scrollButtonStyleB'

     bRenderWorld=True
     bCaptureInput=False
     bAllowedAsLast=True
     bAcceptsInput=False
}
