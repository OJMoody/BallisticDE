//=============================================================================
// CFTab_Rules.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFTab_Rules extends UT2K4TabPanel;

var automated moNumericEdit		ne_killRewardHealthpoints;
var automated moNumericEdit		ne_killRewardHealthcap;
var automated moNumericEdit		ne_killRewardAdrenaline;

var automated moNumericEdit ne_ADRKill;
var automated moNumericEdit ne_ADRMajorKill;
var automated moNumericEdit ne_ADRMinorBonus;
var automated moNumericEdit ne_ADRKillTeamMate;
var automated moNumericEdit ne_ADRMinorError;

var automated moNumericEdit ne_killrewardArmor;
var automated moNumericEdit ne_killrewardArmorCap;

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
	ne_killRewardHealthpoints.SetValue(class'CFMutator.Mut_CFMutators'.default.killRewardHealthpoints);
	ne_killRewardHealthcap.SetValue(class'CFMutator.Mut_CFMutators'.default.killRewardHealthcap);
	ne_ADRKill.SetValue(class'CFMutator.Mut_CFMutators'.default.ADRKill);
	ne_ADRMajorKill.SetValue(class'CFMutator.Mut_CFMutators'.default.ADRMajorKill);
	ne_ADRMinorBonus.SetValue(class'CFMutator.Mut_CFMutators'.default.ADRMinorBonus);
	ne_ADRKillTeamMate.SetValue(class'CFMutator.Mut_CFMutators'.default.ADRKillTeamMate);
	ne_ADRMinorError.SetValue(class'CFMutator.Mut_CFMutators'.default.ADRMinorError);
	ne_killrewardArmor.SetValue(class'CFMutator.Mut_CFMutators'.default.killrewardArmor);
	ne_killrewardArmorCap.SetValue(class'CFMutator.Mut_CFMutators'.default.killrewardArmorCap);
}

function DefaultSettings()
{
	ne_killRewardHealthpoints.SetValue(15);
	ne_killRewardHealthcap.SetValue(0);
	ne_ADRKill.SetValue(10);
	ne_ADRMajorKill.SetValue(15);
	ne_ADRMinorBonus.SetValue(5);
	ne_ADRKillTeamMate.SetValue(0);
	ne_ADRMinorError.SetValue(-5);
	ne_killrewardArmor.SetValue(5);
	ne_killrewardArmorCap.SetValue(0);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'CFMutator.Mut_CFMutators'.default.killRewardHealthpoints 	= ne_killRewardHealthpoints.GetValue();
	class'CFMutator.Mut_CFMutators'.default.killRewardHealthcap = ne_killRewardHealthcap.GetValue();
	class'CFMutator.Mut_CFMutators'.default.ADRKill = ne_ADRKill.GetValue();
	class'CFMutator.Mut_CFMutators'.default.ADRMajorKill = ne_ADRMajorKill.GetValue();
	class'CFMutator.Mut_CFMutators'.default.ADRMinorBonus = ne_ADRMinorBonus.GetValue();
	class'CFMutator.Mut_CFMutators'.default.ADRKillTeamMate = ne_ADRKillTeamMate.GetValue();
	class'CFMutator.Mut_CFMutators'.default.ADRMinorError = ne_ADRMinorError.GetValue();
	class'CFMutator.Mut_CFMutators'.default.killrewardArmor = ne_killrewardArmor.GetValue();
	class'CFMutator.Mut_CFMutators'.default.killrewardArmorCap = ne_killrewardArmorCap.GetValue();

	class'CFMutator.Mut_CFMutators'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moNumericEdit Name=ne_killRewardHealthpointsE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward in health points:"
         OnCreateComponent=ne_killRewardHealthpointsE.InternalOnCreateComponent
         Hint="The kill reward in health points given to the dominator."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killRewardHealthpoints=moNumericEdit'cfmutator.CFTab_Rules.ne_killRewardHealthpointsE'

     Begin Object Class=moNumericEdit Name=ne_killRewardHealthcapE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward health cap:"
         OnCreateComponent=ne_killRewardHealthcapE.InternalOnCreateComponent
         Hint="The kill reward health cap for the dominator. 0 = player super health cap."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killRewardHealthcap=moNumericEdit'cfmutator.CFTab_Rules.ne_killRewardHealthcapE'

     Begin Object Class=moNumericEdit Name=ne_ADRKillC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline for kill:"
         OnCreateComponent=ne_ADRKillC.InternalOnCreateComponent
         Hint="The given adrenaline for a kill."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRKill=moNumericEdit'cfmutator.CFTab_Rules.ne_ADRKillC'

     Begin Object Class=moNumericEdit Name=ne_ADRMajorKillC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline for major kill:"
         OnCreateComponent=ne_ADRMajorKillC.InternalOnCreateComponent
         Hint="The given adrenaline for a major kill."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRMajorKill=moNumericEdit'cfmutator.CFTab_Rules.ne_ADRMajorKillC'

     Begin Object Class=moNumericEdit Name=ne_ADRMinorBonusC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline for minor bonus:"
         OnCreateComponent=ne_ADRMinorBonusC.InternalOnCreateComponent
         Hint="The given adrenaline for a minor bonus."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRMinorBonus=moNumericEdit'cfmutator.CFTab_Rules.ne_ADRMinorBonusC'

     Begin Object Class=moNumericEdit Name=ne_ADRKillTeamMateC
         MinValue=-999
         MaxValue=0
         ComponentWidth=0.175000
         Caption="Adrenaline deduction for team kill:"
         OnCreateComponent=ne_ADRKillTeamMateC.InternalOnCreateComponent
         Hint="The adrenaline deduction for a team kill."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRKillTeamMate=moNumericEdit'cfmutator.CFTab_Rules.ne_ADRKillTeamMateC'

     Begin Object Class=moNumericEdit Name=ne_ADRMinorErrorC
         MinValue=-999
         MaxValue=0
         ComponentWidth=0.175000
         Caption="Adrenaline deduction for minor error:"
         OnCreateComponent=ne_ADRMinorErrorC.InternalOnCreateComponent
         Hint="The adrenaline deduction for a minor error."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRMinorError=moNumericEdit'cfmutator.CFTab_Rules.ne_ADRMinorErrorC'

     Begin Object Class=moNumericEdit Name=ne_killrewardArmorC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward in armor points:"
         OnCreateComponent=ne_killrewardArmorC.InternalOnCreateComponent
         Hint="The kill reward in armor points given to the dominator."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killrewardArmor=moNumericEdit'cfmutator.CFTab_Rules.ne_killrewardArmorC'

     Begin Object Class=moNumericEdit Name=ne_killrewardArmorCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward armor cap:"
         OnCreateComponent=ne_killrewardArmorCapC.InternalOnCreateComponent
         Hint="The kill reward armor cap for the dominator. 0 = player armor cap."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killrewardArmorCap=moNumericEdit'cfmutator.CFTab_Rules.ne_killrewardArmorCapC'

}
