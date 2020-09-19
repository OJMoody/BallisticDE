//=============================================================================
// CFTab_Misc.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFTab_Sprint extends UT2k4TabPanel;

var automated moCheckBox		cb_bUseSprint;
var automated moFloatEdit		fe_InitStamina;
var automated moFloatEdit       fe_InitMaxStamina;
var automated moFloatEdit       fe_InitStaminaDrainRate;
var automated moFloatEdit       fe_InitStaminaChargeRate;
var automated moFloatEdit       fe_InitSpeedFactor;
var automated moFloatEdit       fe_JumpDrainFactor;

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
	cb_bUseSprint.Checked(class'CFMutator.Mut_CFMutators'.default.bUseSprint);
	fe_InitStamina.SetValue(class'CFMutator.Mut_CFMutators'.default.InitStamina);
	fe_InitMaxStamina.SetValue(class'CFMutator.Mut_CFMutators'.default.InitMaxStamina);
	fe_InitStaminaDrainRate.SetValue(class'CFMutator.Mut_CFMutators'.default.InitStaminaDrainRate);
	fe_InitStaminaChargeRate.SetValue(class'CFMutator.Mut_CFMutators'.default.InitStaminaChargeRate);
	fe_InitSpeedFactor.SetValue(class'CFMutator.Mut_CFMutators'.default.InitSpeedFactor);
	fe_JumpDrainFactor.SetValue(class'CFMutator.Mut_CFMutators'.default.JumpDrainFactor);
}

function DefaultSettings()
{
	cb_bUseSprint.Checked(true);
	fe_InitStamina.SetValue(100.000000);
	fe_InitMaxStamina.SetValue(100.000000);
	fe_InitStaminaDrainRate.SetValue(10.000000);
	fe_InitStaminaChargeRate.SetValue(7.000000);
	fe_InitSpeedFactor.SetValue(1.350000);
	fe_JumpDrainFactor.SetValue(2);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'CFMutator.Mut_CFMutators'.default.bUseSprint = cb_bUseSprint.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.InitStamina = fe_InitStamina.GetValue();
	class'CFMutator.Mut_CFMutators'.default.InitMaxStamina = fe_InitMaxStamina.GetValue();
	class'CFMutator.Mut_CFMutators'.default.InitStaminaDrainRate = fe_InitStaminaDrainRate.GetValue();
	class'CFMutator.Mut_CFMutators'.default.InitStaminaChargeRate = fe_InitStaminaChargeRate.GetValue();
	class'CFMutator.Mut_CFMutators'.default.InitSpeedFactor = fe_InitSpeedFactor.GetValue();
	class'CFMutator.Mut_CFMutators'.default.JumpDrainFactor = fe_JumpDrainFactor.GetValue();

	class'CFMutator.Mut_CFMutators'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=cb_bUseSprintC
         ComponentWidth=0.175000
         Caption="Enable sprint:"
         OnCreateComponent=cb_bUseSprintC.InternalOnCreateComponent
         Hint="Enables sprint."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bUseSprint=moCheckBox'cfmutator.CFTab_Sprint.cb_bUseSprintC'

     Begin Object Class=moFloatEdit Name=fe_InitStaminaC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Initial Stamina:"
         OnCreateComponent=fe_InitStaminaC.InternalOnCreateComponent
         Hint="The initial stamina."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitStamina=moFloatEdit'cfmutator.CFTab_Sprint.fe_InitStaminaC'

     Begin Object Class=moFloatEdit Name=fe_InitMaxStaminaC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Max stamina:"
         OnCreateComponent=fe_InitMaxStaminaC.InternalOnCreateComponent
         Hint="The maximal stamina."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitMaxStamina=moFloatEdit'cfmutator.CFTab_Sprint.fe_InitMaxStaminaC'

     Begin Object Class=moFloatEdit Name=fe_InitStaminaDrainRateC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Stamina drain rate:"
         OnCreateComponent=fe_InitStaminaDrainRateC.InternalOnCreateComponent
         Hint="The stamina drain rate."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitStaminaDrainRate=moFloatEdit'cfmutator.CFTab_Sprint.fe_InitStaminaDrainRateC'

     Begin Object Class=moFloatEdit Name=fe_InitStaminaChargeRateC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Stamina charge rate:"
         OnCreateComponent=fe_InitStaminaChargeRateC.InternalOnCreateComponent
         Hint="The stamina charge rate."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitStaminaChargeRate=moFloatEdit'cfmutator.CFTab_Sprint.fe_InitStaminaChargeRateC'

     Begin Object Class=moFloatEdit Name=fe_InitSpeedFactorC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Speed factor:"
         OnCreateComponent=fe_InitSpeedFactorC.InternalOnCreateComponent
         Hint="The speed factor during sprint."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitSpeedFactor=moFloatEdit'cfmutator.CFTab_Sprint.fe_InitSpeedFactorC'

     Begin Object Class=moFloatEdit Name=fe_JumpDrainFactorC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Jump drain factor:"
         OnCreateComponent=fe_JumpDrainFactorC.InternalOnCreateComponent
         Hint="The jump drain factor during sprint."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_JumpDrainFactor=moFloatEdit'cfmutator.CFTab_Sprint.fe_JumpDrainFactorC'

}
