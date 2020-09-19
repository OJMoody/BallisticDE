//=============================================================================
// CFTab_Weapons.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFTab_Weapons extends UT2K4TabPanel;

var automated moCheckBox		chk_disableCrosshairs;
var automated moCheckBox		chk_disableTurretCrosshairs;
var automated moCheckBox		chk_SetGrenadeLongThrowDefault;
var automated moCheckBox		chk_SetBortFlareDefault;
var automated moCheckBox		chk_disableBortGrenade;
var automated moCheckBox		chk_bStrongerA73Melee;
var automated moFloatEdit		ne_soulAmountAmplifier;
var automated moCheckBox		chk_bXMK5DartFix;
var automated moCheckBox		chk_bHAMRScopeFix;
var automated moCheckBox		chk_bOwnMineMarker;
var automated moCheckBox		chk_bA500Fix;
var automated moCheckBox		chk_bFixBort;
var automated moCheckBox		chk_improvedFP9;
var automated moNumericEdit		ne_flamePackHealth;

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
	chk_disableCrosshairs.Checked(class'CFMutator.Mut_CFMutators'.default.bDisableCrosshairs);
	chk_disableTurretCrosshairs.Checked(class'CFMutator.Mut_CFMutators'.default.bDisableTurretCrosshairs);
	chk_SetGrenadeLongThrowDefault.Checked(class'CFMutator.Mut_CFMutators'.default.bSetGrenadeLongThrowDefault);
	chk_SetBortFlareDefault.Checked(class'CFMutator.Mut_CFMutators'.default.bSetBortFlareDefault);
	chk_disableBortGrenade.Checked(class'CFMutator.Mut_CFMutators'.default.bDisableBortGrenade);
	chk_bStrongerA73Melee.Checked(class'CFMutator.Mut_CFMutators'.default.bStrongerA73Melee);
	ne_soulAmountAmplifier.SetValue(class'CFMutator.Mut_CFMutators'.default.soulAmountAmplifier);
	chk_bXMK5DartFix.Checked(class'CFMutator.Mut_CFMutators'.default.bXMK5DartFix);
	chk_bHAMRScopeFix.Checked(class'CFMutator.Mut_CFMutators'.default.bHAMRScopeFix);
	chk_bOwnMineMarker.Checked(class'CFMutator.Mut_CFMutators'.default.bOwnMineMarker);
	chk_bA500Fix.Checked(class'CFMutator.Mut_CFMutators'.default.bA500Fix);
	chk_bFixBort.Checked(class'CFMutator.Mut_CFMutators'.default.bFixBort);
	chk_improvedFP9.Checked(class'CFMutator.Mut_CFMutators'.default.improvedFP9);
	ne_flamePackHealth.SetValue(class'CFMutator.Mut_CFMutators'.default.flamePackHealth);

}

function DefaultSettings()
{
	chk_disableCrosshairs.Checked(false);
	chk_disableTurretCrosshairs.Checked(false);
	chk_SetGrenadeLongThrowDefault.Checked(false);
	chk_SetBortFlareDefault.Checked(false);
	chk_disableBortGrenade.Checked(false);
	chk_bStrongerA73Melee.Checked(false);
	ne_soulAmountAmplifier.SetValue(2);
	chk_bXMK5DartFix.Checked(true);
	chk_bHAMRScopeFix.Checked(true);
	chk_bOwnMineMarker.Checked(false);
	chk_bA500Fix.Checked(true);
	chk_bFixBort.Checked(true);
	chk_improvedFP9.Checked(true);
	ne_flamePackHealth.SetValue(5);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'CFMutator.Mut_CFMutators'.default.bDisableCrosshairs = chk_disableCrosshairs.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bDisableTurretCrosshairs = chk_disableTurretCrosshairs.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bSetGrenadeLongThrowDefault = chk_SetGrenadeLongThrowDefault.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bSetBortFlareDefault = chk_SetBortFlareDefault.IsChecked();
  	class'CFMutator.Mut_CFMutators'.default.bDisableBortGrenade = chk_disableBortGrenade.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bStrongerA73Melee = chk_bStrongerA73Melee.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.soulAmountAmplifier = ne_soulAmountAmplifier.GetValue();
	class'CFMutator.Mut_CFMutators'.default.bXMK5DartFix = chk_bXMK5DartFix.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bHAMRScopeFix = chk_bHAMRScopeFix.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bOwnMineMarker = chk_bOwnMineMarker.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bA500Fix = chk_bA500Fix.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bFixBort = chk_bFixBort.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.improvedFP9 = chk_improvedFP9.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.flamePackHealth = ne_flamePackHealth.GetValue();

	class'CFMutator.Mut_CFMutators'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=chk_disableCrosshairsC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Disable client crosshairs"
         OnCreateComponent=chk_disableCrosshairsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables the crosshairs on clients, except ballistic turrets(MG353, MG925 etc ...)."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_disableCrosshairs=moCheckBox'cfmutator.CFTab_Weapons.chk_disableCrosshairsC'

     Begin Object Class=moCheckBox Name=chk_disableTurretCrosshairsC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Disable client turret crosshairs"
         OnCreateComponent=chk_disableTurretCrosshairsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables the ballistic turret crosshairs on clients. MG353, MG925 etc ..."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_disableTurretCrosshairs=moCheckBox'cfmutator.CFTab_Weapons.chk_disableTurretCrosshairsC'

     Begin Object Class=moCheckBox Name=chk_SetGrenadeLongThrowDefaultC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Set 'Long Throw' default grenade mode"
         OnCreateComponent=chk_SetGrenadeLongThrowDefaultC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets 'Long Throw' as default grenade mode rather then 'Auto Throw'."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_SetGrenadeLongThrowDefault=moCheckBox'cfmutator.CFTab_Weapons.chk_SetGrenadeLongThrowDefaultC'

     Begin Object Class=moCheckBox Name=chk_SetBortFlareDefaultC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Set 'Flare' default BORT weapon mode"
         OnCreateComponent=chk_SetBortFlareDefaultC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets 'Flare' as default BORT weapon mode rather then 'Grenade'."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_SetBortFlareDefault=moCheckBox'cfmutator.CFTab_Weapons.chk_SetBortFlareDefaultC'

     Begin Object Class=moCheckBox Name=chk_disableBortGrenadeC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Disable 'Grenade' BORT weapon mode"
         OnCreateComponent=chk_disableBortGrenadeC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removs the troll factor of the BORT by disabling the 'Grenade' BORT weapon mode. Sets secondary fire mode to primary fire mode"
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_disableBortGrenade=moCheckBox'cfmutator.CFTab_Weapons.chk_disableBortGrenadeC'

     Begin Object Class=moCheckBox Name=chk_bStrongerA73MeleeC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Enable stronger A73 melee"
         OnCreateComponent=chk_bStrongerA73MeleeC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Makes the A73 melee stronger."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bStrongerA73Melee=moCheckBox'cfmutator.CFTab_Weapons.chk_bStrongerA73MeleeC'

     Begin Object Class=moFloatEdit Name=ne_soulAmountAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Staff soul amount amplifier:"
         OnCreateComponent=ne_soulAmountAmplifierC.InternalOnCreateComponent
         Hint="Amplifies the amount of soul energy each soul gives the Darkstar or Nova Staff."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_soulAmountAmplifier=moFloatEdit'cfmutator.CFTab_Weapons.ne_soulAmountAmplifierC'

     Begin Object Class=moCheckBox Name=chk_bXMK5DartFixC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Enable XMK5 dart fix"
         OnCreateComponent=chk_bXMK5DartFixC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Fixes an issue with the XMK5 dart where players still have the visual dart poison effect right after they respawmned."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bXMK5DartFix=moCheckBox'cfmutator.CFTab_Weapons.chk_bXMK5DartFixC'

     Begin Object Class=moCheckBox Name=chk_bHAMRScopeFixC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Enable HAMR HUD fix"
         OnCreateComponent=chk_bHAMRScopeFixC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Fixes an issue with the HAMR where the players hud visibility gets a reset to 100."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bHAMRScopeFix=moCheckBox'cfmutator.CFTab_Weapons.chk_bHAMRScopeFixC'

     Begin Object Class=moCheckBox Name=chK_bOwnMineMarkerC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Tactical mines"
         OnCreateComponent=chK_bOwnMineMarkerC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Marks own BTX5- and M46 Proximity-mines with an orange marker and enables a chance for them to explode randomly when disarming.."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bOwnMineMarker=moCheckBox'cfmutator.CFTab_Weapons.chK_bOwnMineMarkerC'

     Begin Object Class=moCheckBox Name=chk_bA500FixC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Fix A500 log errors"
         OnCreateComponent=chk_bA500FixC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Fixes several errors logged into the server- and game-log."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bA500Fix=moCheckBox'cfmutator.CFTab_Weapons.chk_bA500FixC'

     Begin Object Class=moCheckBox Name=chk_bFixBortC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Fix BORT log error"
         OnCreateComponent=chk_bFixBortC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Fixes an error logged into the server- and game-log."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bFixBort=moCheckBox'cfmutator.CFTab_Weapons.chk_bFixBortC'

     Begin Object Class=moCheckBox Name=chk_improvedFP9C
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Improved FP9"
         OnCreateComponent=chk_improvedFP9C.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Allows FP9's to be detonated immediately after throwing and enables a chance for them to explode randomly when disarming."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_improvedFP9=moCheckBox'cfmutator.CFTab_Weapons.chk_improvedFP9C'

     Begin Object Class=moNumericEdit Name=ne_flamePackHealthC
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="RX22A gas tank health:"
         OnCreateComponent=ne_flamePackHealthC.InternalOnCreateComponent
         Hint="The Health of the RX22A flamer thrower gas tank."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_flamePackHealth=moNumericEdit'cfmutator.CFTab_Weapons.ne_flamePackHealthC'

}
