//=============================================================================
// CFTab_Misc.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFTab_Misc extends UT2k4TabPanel;

var automated moFloatEdit		fe_WelcomeMessageDelay;
var automated moCheckBox		chk_bAchievements;
var automated moCheckBox		chk_deadlyMover;
var automated moCheckBox		chk_CFPickUps;
var automated moCheckBox		chk_bAnimatedPickups;
var automated moFloatEdit		fe_spawnraidTimer;

var CFConfigMenu    		p_Anchor;
var bool					bInitialized;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	if (CFConfigMenu(Controller.ActivePage) != None)
		p_Anchor = CFConfigMenu(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
	super.ShowPanel(bShow);
	if (bInitialized)
		return;
	LoadSettings();
	bInitialized = true;
}

function LoadSettings()
{
	fe_WelcomeMessageDelay.SetValue(class'CFMutator.Mut_CFMutators'.default.serverWelcomeMessageDelay);
	chk_bAchievements.Checked(class'CFMutator.Mut_CFMutators'.default.bAchievements);
	chk_deadlyMover.Checked(class'CFMutator.Mut_CFMutators'.default.deadlyMover);
	fe_spawnraidTimer.SetValue(class'CFMutator.Mut_CFMutators'.default.spawnraidTimer);
	chk_CFPickUps.Checked(class'CFMutator.Mut_CFMutators'.default.CFPickUps);
	chk_bAnimatedPickups.Checked(class'CFMutator.Mut_CFMutators'.default.bAnimatedPickups);
}

function DefaultSettings()
{
	fe_WelcomeMessageDelay.SetValue(0);
	chk_bAchievements.Checked(true);
	chk_deadlyMover.Checked(true);
	fe_WelcomeMessageDelay.SetValue(5.0);
	chk_CFPickUps.Checked(true);
	chk_bAnimatedPickups.Checked(true);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'CFMutator.Mut_CFMutators'.default.serverWelcomeMessageDelay = fe_WelcomeMessageDelay.GetValue();
	class'CFMutator.Mut_CFMutators'.default.bAchievements = chk_bAchievements.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.deadlyMover = chk_deadlyMover.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.spawnraidTimer = fe_spawnraidTimer.GetValue();
	class'CFMutator.Mut_CFMutators'.default.CFPickUps = chk_CFPickUps.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bAnimatedPickups = chk_bAnimatedPickups.IsChecked();

	class'CFMutator.Mut_CFMutators'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moFloatEdit Name=fe_WelcomeMessageDelayE
         MinValue=0.000000
         MaxValue=30.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Welcome Message Delay:"
         OnCreateComponent=fe_WelcomeMessageDelayE.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the time when the server welcome message will appear in seconds."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_WelcomeMessageDelay=moFloatEdit'cfmutator.CFTab_Misc.fe_WelcomeMessageDelayE'

     Begin Object Class=moCheckBox Name=bAchievementsC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Enable ingame achievements"
         OnCreateComponent=bAchievementsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables cool ingame achievements."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bAchievements=moCheckBox'cfmutator.CFTab_Misc.bAchievementsC'

     Begin Object Class=moCheckBox Name=deadlyMoverC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Deadly Elevators"
         OnCreateComponent=deadlyMoverC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="All Movers on the map will crush you when blocked by you."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_deadlyMover=moCheckBox'cfmutator.CFTab_Misc.deadlyMoverC'

     Begin Object Class=moCheckBox Name=chk_CFPickUpsC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Alternative weapon pickups"
         OnCreateComponent=chk_CFPickUpsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Pickups must be picked up with the use key and show a tiny widget above them, indicating the ballistic weapontype and ammount and ammonition left in the gun."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_CFPickUps=moCheckBox'cfmutator.CFTab_Misc.chk_CFPickUpsC'

     Begin Object Class=moCheckBox Name=chk_bAnimatedPickupsC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Animated weapon pickups"
         OnCreateComponent=chk_bAnimatedPickupsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Weapon pickups will be picked up using a nice animation."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bAnimatedPickups=moCheckBox'cfmutator.CFTab_Misc.chk_bAnimatedPickupsC'

     Begin Object Class=moFloatEdit Name=fe_spawnraidTimerE
         MinValue=0.000000
         MaxValue=30.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Spawn raid timer:"
         OnCreateComponent=fe_spawnraidTimerE.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The time players get to score a spawn raid right after the victim the spawned."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_spawnraidTimer=moFloatEdit'cfmutator.CFTab_Misc.fe_spawnraidTimerE'

}
