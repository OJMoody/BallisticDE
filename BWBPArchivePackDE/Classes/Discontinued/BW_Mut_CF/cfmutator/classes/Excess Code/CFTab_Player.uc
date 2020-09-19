//=============================================================================
// CFTab_Player.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFTab_Player extends UT2K4TabPanel;

var automated moNumericEdit		ne_playerHealth;
var automated moNumericEdit		ne_playerHealthCap;
var automated moNumericEdit     ne_playerSuperHealthCap;
var automated moNumericEdit     ne_iAdrenaline;
var automated moNumericEdit     ne_iAdrenalineCap;
var automated moFloatEdit       fe_dieSoundAmplifier;
var automated moFloatEdit       fe_dieSoundRangeAmplifier;
var automated moFloatEdit       fe_hitSoundAmplifier;
var automated moFloatEdit       fe_hitSoundRangeAmplifier;

var automated moFloatEdit       fe_jumpDamageAmplifier;
var automated moCheckBox       	cb_bNeckBreak;

var automated moNumericEdit 	ne_iArmor;
var automated moNumericEdit 	ne_iArmorCap;

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
	ne_playerHealth.SetValue(class'CFMutator.Mut_CFMutators'.default.playerHealth);
	ne_playerHealthCap.SetValue(class'CFMutator.Mut_CFMutators'.default.playerHealthCap);
	ne_playerSuperHealthCap.SetValue(class'CFMutator.Mut_CFMutators'.default.playerSuperHealthCap);
	ne_iAdrenaline.SetValue(class'CFMutator.Mut_CFMutators'.default.iAdrenaline);
	ne_iAdrenalineCap.SetValue(class'CFMutator.Mut_CFMutators'.default.iAdrenalineCap);
	fe_dieSoundAmplifier.SetValue(class'CFMutator.Mut_CFMutators'.default.dieSoundAmplifier);
	fe_dieSoundRangeAmplifier.SetValue(class'CFMutator.Mut_CFMutators'.default.dieSoundRangeAmplifier);
	fe_hitSoundAmplifier.SetValue(class'CFMutator.Mut_CFMutators'.default.hitSoundAmplifier);
	fe_hitSoundRangeAmplifier.SetValue(class'CFMutator.Mut_CFMutators'.default.hitSoundRangeAmplifier);
	fe_jumpDamageAmplifier.SetValue(class'CFMutator.Mut_CFMutators'.default.jumpDamageAmplifier);
	cb_bNeckBreak.Checked(class'CFMutator.Mut_CFMutators'.default.bNeckBreak);
	ne_iArmor.SetValue(class'CFMutator.Mut_CFMutators'.default.iArmor);
	ne_iArmorCap.SetValue(class'CFMutator.Mut_CFMutators'.default.iArmorCap);
}

function DefaultSettings()
{
	ne_playerHealth.SetValue(100);
	ne_playerHealthCap.SetValue(100);
	ne_playerSuperHealthCap.SetValue(150);
	ne_iAdrenaline.SetValue(50);
	ne_iAdrenalineCap.SetValue(150);
	fe_dieSoundAmplifier.SetValue(6.5);
	fe_dieSoundRangeAmplifier.SetValue(1.0);
	fe_hitSoundAmplifier.SetValue(8.0);
	fe_hitSoundRangeAmplifier.SetValue(1.5);
	fe_jumpDamageAmplifier.SetValue(40);
	cb_bNeckBreak.Checked(true);
	ne_iArmor.SetValue(50);
	ne_iArmorCap.SetValue(150);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'CFMutator.Mut_CFMutators'.default.playerHealth 	= ne_playerHealth.GetValue();
	class'CFMutator.Mut_CFMutators'.default.playerHealthCap = ne_playerHealthCap.GetValue();
	class'CFMutator.Mut_CFMutators'.default.playerSuperHealthCap = ne_playerSuperHealthCap.GetValue();
	class'CFMutator.Mut_CFMutators'.default.iAdrenaline = ne_iAdrenaline.GetValue();
	class'CFMutator.Mut_CFMutators'.default.iAdrenalineCap = ne_iAdrenalineCap.GetValue();
	class'CFMutator.Mut_CFMutators'.default.dieSoundAmplifier = fe_dieSoundAmplifier.GetValue();
	class'CFMutator.Mut_CFMutators'.default.dieSoundRangeAmplifier = fe_dieSoundRangeAmplifier.GetValue();
	class'CFMutator.Mut_CFMutators'.default.hitSoundAmplifier = fe_hitSoundAmplifier.GetValue();
	class'CFMutator.Mut_CFMutators'.default.hitSoundRangeAmplifier = fe_hitSoundRangeAmplifier.GetValue();
	class'CFMutator.Mut_CFMutators'.default.jumpDamageAmplifier = fe_jumpDamageAmplifier.GetValue();
	class'CFMutator.Mut_CFMutators'.default.bNeckBreak = cb_bNeckBreak.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.iArmor = ne_iArmor.GetValue();
	class'CFMutator.Mut_CFMutators'.default.iArmorCap = ne_iArmorCap.GetValue();

	class'CFMutator.Mut_CFMutators'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moNumericEdit Name=ne_playerHealthEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player health:"
         OnCreateComponent=ne_playerHealthEdit.InternalOnCreateComponent
         Hint="The health players spawn with."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_playerHealth=moNumericEdit'cfmutator.CFTab_Player.ne_playerHealthEdit'

     Begin Object Class=moNumericEdit Name=ne_playerHealthCapEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player health cap:"
         OnCreateComponent=ne_playerHealthEdit.InternalOnCreateComponent
         Hint="The players health cap."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_playerHealthCap=moNumericEdit'cfmutator.CFTab_Player.ne_playerHealthCapEdit'

     Begin Object Class=moNumericEdit Name=ne_playerSuperHealthCapEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player super health cap:"
         OnCreateComponent=ne_playerHealthEdit.InternalOnCreateComponent
         Hint="The super health cap."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_playerSuperHealthCap=moNumericEdit'cfmutator.CFTab_Player.ne_playerSuperHealthCapEdit'

     Begin Object Class=moNumericEdit Name=ne_iAdrenalineC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player adrenaline:"
         OnCreateComponent=ne_iAdrenalineC.InternalOnCreateComponent
         Hint="The adrenaline players spawn with."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iAdrenaline=moNumericEdit'cfmutator.CFTab_Player.ne_iAdrenalineC'

     Begin Object Class=moNumericEdit Name=ne_iAdrenalineCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player adrenaline cap:"
         OnCreateComponent=ne_iAdrenalineCapC.InternalOnCreateComponent
         Hint="The adrenaline cap."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iAdrenalineCap=moNumericEdit'cfmutator.CFTab_Player.ne_iAdrenalineCapC'

     Begin Object Class=moFloatEdit Name=fe_dieSoundAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Die sound amplifier:"
         OnCreateComponent=fe_dieSoundAmplifierC.InternalOnCreateComponent
         Hint="The die sound amplifier."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_dieSoundAmplifier=moFloatEdit'cfmutator.CFTab_Player.fe_dieSoundAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_dieSoundRangeAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Die sound range amplifier:"
         OnCreateComponent=fe_dieSoundRangeAmplifierC.InternalOnCreateComponent
         Hint="The die sound range amplifier."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_dieSoundRangeAmplifier=moFloatEdit'cfmutator.CFTab_Player.fe_dieSoundRangeAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_hitSoundAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Hit sound amplifier:"
         OnCreateComponent=fe_hitSoundAmplifierC.InternalOnCreateComponent
         Hint="The hit sound amplifier."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_hitSoundAmplifier=moFloatEdit'cfmutator.CFTab_Player.fe_hitSoundAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_hitSoundRangeAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Hit sound range amplifier:"
         OnCreateComponent=fe_hitSoundRangeAmplifierC.InternalOnCreateComponent
         Hint="The hit sound range amplifier."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_hitSoundRangeAmplifier=moFloatEdit'cfmutator.CFTab_Player.fe_hitSoundRangeAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_jumpDamageAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Jump damage amplifier:"
         OnCreateComponent=fe_jumpDamageAmplifierC.InternalOnCreateComponent
         Hint="The damage amplifier when you jump on other players or actors."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_jumpDamageAmplifier=moFloatEdit'cfmutator.CFTab_Player.fe_jumpDamageAmplifierC'

     Begin Object Class=moCheckBox Name=cb_bNeckBreakC
         ComponentWidth=0.175000
         Caption="Enable neck break:"
         OnCreateComponent=cb_bNeckBreakC.InternalOnCreateComponent
         Hint="Enables the ability to break your enemies neck when jumping on them with corresponding sound."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bNeckBreak=moCheckBox'cfmutator.CFTab_Player.cb_bNeckBreakC'

     Begin Object Class=moNumericEdit Name=ne_iArmorC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player armor:"
         OnCreateComponent=ne_iArmorC.InternalOnCreateComponent
         Hint="The armor players spawn with."
         WinTop=0.800000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iArmor=moNumericEdit'cfmutator.CFTab_Player.ne_iArmorC'

     Begin Object Class=moNumericEdit Name=ne_iArmorCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Player armor cap:"
         OnCreateComponent=ne_iArmorCapC.InternalOnCreateComponent
         Hint="The armor cap."
         WinTop=0.850000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iArmorCap=moNumericEdit'cfmutator.CFTab_Player.ne_iArmorCapC'

}
