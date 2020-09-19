//=============================================================================
// CFWelcomeMenu.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFWelcomeMenu extends CFClientMenu;

var Automated GUIImage MyBack, picBlood1, picBlood2, picBulletHole;
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
	local array<Texture> bloodStances, bloodStances2;

	Super.InitComponent(MyController, MyOwner);

	originalMouseOverSound = Controller.MouseOverSound;
	originalClickSound = Controller.ClickSound;

	Controller.MouseOverSound=Sound'BWBP4-Sounds.Art-StandClose-1';
//	Controller.ClickSound=Sound'BallisticSounds3.R78.R78-Fire';
//	Controller.PlayInterfaceSound(CS_Click);
	Controller.ClickSound=Sound'BallisticSounds3.USSR.USSR-Fire';

	bloodStances.Insert(0,3);
	bloodStances[0] = Texture'BallisticBlood25.Decals.Saw1';
	bloodStances[1] = Texture'BallisticBlood25.Decals.Saw3';
	bloodStances[2] = Texture'BallisticBlood25.Decals.Saw4';

	bloodStances2.Insert(0,4);
	bloodStances2[0] = Texture'BallisticBlood25.Decals.Slash1';
	bloodStances2[1] = Texture'BallisticBlood25.Decals.Slash2';
	bloodStances2[2] = Texture'BallisticBlood25.Decals.Slash3';
	bloodStances2[3] = Texture'BallisticBlood25.Decals.Slash4';

	picBlood1.Image = bloodStances[Rand(bloodStances.length)];
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
	lAdministratorInfo.Caption = "Loading"@"(Loading)";
	Controller.FocusedControl = lbSettings;
}

function GRIAccessible()
{
	lAdministratorInfo.Caption = PC.GameReplicationInfo.AdminName@"("$PC.GameReplicationInfo.AdminEmail$")";
	lMessageOfTheDay.Caption = PC.GameReplicationInfo.MessageOfTheDay;

	fillSettingsList();
}

function fillSettingsList()
{
	local string content;
	local string clrCodeBlack;
	local Color clrBlack;
	local string clrCodeGrey;
	local Color clrGrey;

	clrBlack = Class'Canvas'.static.MakeColor(0,0,0,255);
	clrCodeBlack = MakeColorCode(clrBlack);

	clrGrey = Class'Canvas'.static.MakeColor(79,79,79,255);
	clrCodeGrey = MakeColorCode(clrGrey);

	content $= clrCodeBlack$"|- RULES -|"$clrCodeGrey;
	content $= "Kill reward in health points: "$IntToColorBlue(MI.killRewardHealthpoints)$clrCodeGrey$"|";
	content $= "Kill reward health cap: "$IntToColorBlue(MI.killRewardHealthcap)$clrCodeGrey$"|";
	content $= "Adrenaline reward for kill: "$IntToColorBlue(MI.ADRKill)$clrCodeGrey$"|";
	content $= "Adrenaline reward for major kill: "$IntToColorBlue(MI.ADRMajorKill)$clrCodeGrey$"|";
	content $= "Adrenaline reward for minor bonus: "$IntToColorBlue(MI.ADRMinorBonus)$clrCodeGrey$"|";
	content $= "Adrenaline deduction for team kill: "$IntToColorBlue(MI.ADRKillTeamMate)$clrCodeGrey$"|";
	content $= "Adrenaline deduction for minor error: "$IntToColorBlue(MI.ADRMinorError)$clrCodeGrey$"|";
	content $= "Kill reward in armor points: "$IntToColorBlue(MI.killrewardArmor)$clrCodeGrey$"|";
	content $= "Kill reward armor cap: "$IntToColorBlue(MI.killrewardArmorCap)$clrCodeGrey$"|";
	content $= "|";

	content $= clrCodeBlack$"- PLAYER -|"$clrCodeGrey;
	content $= "Player health: "$IntToColorBlue(MI.playerHealth)$clrCodeGrey$"|";
	content $= "Player health cap: "$IntToColorBlue(MI.playerHealthCap)$clrCodeGrey$"|";
	content $= "Player super health cap: "$IntToColorBlue(MI.playerSuperHealthCap)$clrCodeGrey$"|";
	content $= "Player adrenaline: "$IntToColorBlue(MI.iAdrenaline)$clrCodeGrey$"|";
	content $= "Player adrenaline cap: "$IntToColorBlue(MI.iAdrenalineCap)$clrCodeGrey$"|";
	content $= "Die sound amplifier: "$FloatToColorBlue(MI.dieSoundAmplifier)$clrCodeGrey$"|";
	content $= "Die sound range amplifier: "$FloatToColorBlue(MI.dieSoundRangeAmplifier)$clrCodeGrey$"|";
	content $= "Hit sound amplifier: "$FloatToColorBlue(MI.hitSoundAmplifier)$clrCodeGrey$"|";
	content $= "Hit sound range amplifier: "$FloatToColorBlue(MI.hitSoundRangeAmplifier)$clrCodeGrey$"|";
	content $= "Jump damage amplifier: "$FloatToColorBlue(MI.jumpDamageAmplifier)$clrCodeGrey$"|";
	content $= "Enable neck break: "$BoolToColorString(MI.bNeckBreak)$clrCodeGrey$"|";
	content $= "Player armor: "$IntToColorBlue(MI.iArmor)$clrCodeGrey$"|";
	content $= "Player armor cap: "$IntToColorBlue(MI.iArmorCap)$clrCodeGrey$"|";
	content $= "|";

	content $= clrCodeBlack$"- WEAPONS -|"$clrCodeGrey;
	content $= "Disable crosshairs: "$BoolToColorString(MI.bDisableCrosshairs)$clrCodeGrey$"|";
	content $= "Disable turret crosshairs: "$BoolToColorString(MI.bDisableTurretCrosshairs)$clrCodeGrey$"|";
	content $= "Set 'Long Throw' default grenade mode: "$BoolToColorString(MI.bSetGrenadeLongThrowDefault)$clrCodeGrey$"|";
	content $= "Set 'Flare' default BORT weapon mode: "$BoolToColorString(MI.bSetBortFlareDefault)$clrCodeGrey$"|";
	content $= "Disable 'Grenade' BORT weapon mode: "$BoolToColorString(MI.bDisableBortGrenade)$clrCodeGrey$"|";
	content $= "Enable stronger A73 melee: "$BoolToColorString(MI.bStrongerA73Melee)$clrCodeGrey$"|";
	content $= "Staff soul amount amplifier: "$FloatToColorBlue(MI.soulAmountAmplifier)$clrCodeGrey$"|";
	content $= "XMK5 dart fix: "$BoolToColorString(MI.bXMK5DartFix)$clrCodeGrey$"|";
	content $= "HAMR HUD fix: "$BoolToColorString(MI.bHAMRScopeFix)$clrCodeGrey$"|";
	content $= "Tactical mines: "$BoolToColorString(MI.bOwnMineMarker)$clrCodeGrey$"|";
	content $= "Improved FP9: "$BoolToColorString(MI.improvedFP9)$clrCodeGrey$"|";
	content $= "Fix A500 log errors: "$BoolToColorString(MI.bA500Fix)$clrCodeGrey$"|";
	content $= "Fix BORT log error: "$BoolToColorString(MI.bFixBort)$clrCodeGrey$"|";
	content $= "RX22A gas tank health: "$IntToColorBlue(MI.flamePackHealth)$clrCodeGrey$"|";
	content $= "|";

	content $= clrCodeBlack$"- PACKS -|"$clrCodeGrey;
	content $= "Remove ammo packs: "$BoolToColorString(MI.bRemoveAmmoPacks)$clrCodeGrey$"|";
	content $= "Remove armors: "$BoolToColorString(MI.bRemoveShieldPack)$clrCodeGrey$"|";
	content $= "Remove super armors: "$BoolToColorString(MI.bRemoveSuperShieldPack)$clrCodeGrey$"|";
	content $= "Remove bandages: "$BoolToColorString(MI.bRemoveBandages)$clrCodeGrey$"|";
	content $= "Remove health packs: "$BoolToColorString(MI.bRemoveHealthPack)$clrCodeGrey$"|";
	content $= "Remove super health packs: "$BoolToColorString(MI.bRemoveSuperHealthPack)$clrCodeGrey$"|";
	content $= "Remove damage amplifiers: "$BoolToColorString(MI.bRemoveUDamage)$clrCodeGrey$"|";
	content $= "Remove adrenaline: "$BoolToColorString(MI.bRemoveAdrenaline)$clrCodeGrey$"|";
	content $= "|";

	content $= clrCodeBlack$"- SPRINT -|"$clrCodeGrey;
	content $= "Sprint enabled: "$BoolToColorString(MI.bUseSprint)$clrCodeGrey$"|";
	content $= "Initial stamina: "$FloatToColorBlue(MI.InitStamina)$clrCodeGrey$"|";
	content $= "Maximal stamina: "$FloatToColorBlue(MI.InitStamina)$clrCodeGrey$"|";
	content $= "Stamina drain rate: "$FloatToColorBlue(MI.InitStaminaDrainRate)$clrCodeGrey$"|";
	content $= "Stamina recharge rate: "$FloatToColorBlue(MI.InitStaminaChargeRate)$clrCodeGrey$"|";
	content $= "Speed factor: "$FloatToColorBlue(MI.InitSpeedFactor)$clrCodeGrey$"|";
	content $= "Jump drain factor: "$FloatToColorBlue(MI.JumpDrainFactor)$clrCodeGrey$"|";
	content $= "|";

	content $= clrCodeBlack$"- MISC -|"$clrCodeGrey;
	content $= "Achievements enabled: "$BoolToColorString(MI.bAchievements)$clrCodeGrey$"|";
	content $= "Deadly elevators: "$BoolToColorString(MI.deadlyMover)$clrCodeGrey$"|";
	content $= "Spawn raid timer: "$FloatToColorBlue(MI.spawnraidTimer)$clrCodeGrey$"|";
	content $= "Alternative weapon pickups: "$BoolToColorString(MI.CFPickUps)$clrCodeGrey$"|";
	content $= "Animated weapon pickups: "$BoolToColorString(MI.bAnimatedPickups)$clrCodeGrey$"|";

	lbSettings.SetContent(content);
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
         Image=Texture'CFMutatorTex.Controls.WelcomeDialog'
         ImageStyle=ISTY_Scaled
         WinTop=0.100000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'cfmutator.CFWelcomeMenu.BackImage'

     Begin Object Class=GUIImage Name=picBlood1I
         Image=Texture'BallisticBlood25.Decals.Saw4'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Modulated
         WinTop=0.381000
         WinLeft=0.550000
         WinWidth=0.300000
         WinHeight=0.335000
         RenderWeight=0.002000
     End Object
     picBlood1=GUIImage'cfmutator.CFWelcomeMenu.picBlood1I'

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
     picBlood2=GUIImage'cfmutator.CFWelcomeMenu.picBlood2I'

     Begin Object Class=GUIImage Name=picBulletHoleI
         Image=Texture'BallisticEffects2.Decals.Bullet_Concrete'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Modulated
         WinTop=0.400000
         WinLeft=0.240000
         WinWidth=0.080000
         WinHeight=0.080000
         RenderWeight=0.002000
     End Object
     picBulletHole=GUIImage'cfmutator.CFWelcomeMenu.picBulletHoleI'

     Begin Object Class=GUILabel Name=lTestL
         Caption="This server is administered by"
         TextAlign=TXTA_Center
         TextColor=(B=0)
         WinTop=0.305000
         WinLeft=0.260000
         WinWidth=0.600000
         WinHeight=0.035000
     End Object
     lAdministratorInfoDesc=GUILabel'cfmutator.CFWelcomeMenu.lTestL'

     Begin Object Class=GUILabel Name=lAdministratorInfoL
         TextAlign=TXTA_Center
         TextColor=(B=0)
         WinTop=0.325000
         WinLeft=0.260000
         WinWidth=0.600000
         WinHeight=0.035000
     End Object
     lAdministratorInfo=GUILabel'cfmutator.CFWelcomeMenu.lAdministratorInfoL'

     Begin Object Class=GUILabel Name=lMessageOfTheDayL
         TextAlign=TXTA_Center
         TextColor=(B=0)
         FontScale=FNS_Large
         WinTop=0.210000
         WinLeft=0.280000
         WinWidth=0.580000
         WinHeight=0.070000
     End Object
     lMessageOfTheDay=GUILabel'cfmutator.CFWelcomeMenu.lMessageOfTheDayL'

     Begin Object Class=GUIButton Name=btnOKB
         StyleName="CFPlayBtn1"
         WinTop=0.740000
         WinLeft=0.300000
         WinWidth=0.100000
         TabOrder=1
         Begin Object Class=CF_PlayButton Name=cfStylePlayBtn
         End Object
         Style=CF_PlayButton'cfmutator.CFWelcomeMenu.cfStylePlayBtn'

         OnClick=CFWelcomeMenu.InternalOnClick
         OnKeyEvent=btnOKB.InternalOnKeyEvent
     End Object
     btnOK=GUIButton'cfmutator.CFWelcomeMenu.btnOKB'

     Begin Object Class=GUIButton Name=btnDisconnectB
         StyleName="CFLeaveBtn1"
         WinTop=0.740000
         WinLeft=0.600000
         WinWidth=0.100000
         TabOrder=2
         Begin Object Class=CF_LeaveButton Name=cfStyleLeaveBtn
         End Object
         Style=CF_LeaveButton'cfmutator.CFWelcomeMenu.cfStyleLeaveBtn'

         OnClick=CFWelcomeMenu.InternalOnClick
         OnKeyEvent=btnDisconnectB.InternalOnKeyEvent
     End Object
     btnDisconnect=GUIButton'cfmutator.CFWelcomeMenu.btnDisconnectB'

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
     lbSettings=GUIScrollTextBox'cfmutator.CFWelcomeMenu.SettingsListBox'

     Begin Object Class=CFSTY2VertDownButton Name=scrollDownBtnStyleB
     End Object
     scrollDownBtnStyle=CFSTY2VertDownButton'cfmutator.CFWelcomeMenu.scrollDownBtnStyleB'

     Begin Object Class=CFSTY2VertUpButton Name=CFSTY2VertUpButtonB
     End Object
     scrollUpBtnStyle=CFSTY2VertUpButton'cfmutator.CFWelcomeMenu.CFSTY2VertUpButtonB'

     Begin Object Class=CFSTY2ScrollZone Name=CFSTY2ScrollZoneB
     End Object
     scrollZoneStyle=CFSTY2ScrollZone'cfmutator.CFWelcomeMenu.CFSTY2ScrollZoneB'

     Begin Object Class=CFSTY2RoundButton Name=scrollButtonStyleB
     End Object
     scrollButtonStyle=CFSTY2RoundButton'cfmutator.CFWelcomeMenu.scrollButtonStyleB'

     bRenderWorld=True
     bCaptureInput=False
     bAllowedAsLast=True
     bAcceptsInput=False
}
