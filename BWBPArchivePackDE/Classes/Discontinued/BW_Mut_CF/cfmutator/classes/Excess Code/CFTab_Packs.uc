//=============================================================================
// CFTab_Packs.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFTab_Packs extends UT2K4TabPanel;

var automated moCheckBox		chk_bRemoveAmmoPacks;
var automated moCheckBox		chk_bRemoveUDamage;
var automated moCheckBox		chk_bRemoveShieldPack;
var automated moCheckBox		chk_bRemoveSuperShieldPack;
var automated moCheckBox		chk_bRemoveBandages;
var automated moCheckBox		chk_bRemoveHealthPack;
var automated moCheckBox		chk_bRemoveSuperHealthPack;
var automated moCheckBox		chk_bRemoveAdrenaline;

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
	chk_bRemoveAmmoPacks.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveAmmoPacks);
	chk_bRemoveUDamage.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveUDamage);
	chk_bRemoveShieldPack.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveShieldPack);
	chk_bRemoveSuperShieldPack.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveSuperShieldPack);
	chk_bRemoveBandages.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveBandages);
	chk_bRemoveHealthPack.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveHealthPack);
	chk_bRemoveSuperHealthPack.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveSuperHealthPack);
	chk_bRemoveAdrenaline.Checked(class'CFMutator.Mut_CFMutators'.default.bRemoveAdrenaline);
}

function DefaultSettings()
{
	chk_bRemoveAmmoPacks.Checked(false);
	chk_bRemoveUDamage.Checked(false);
	chk_bRemoveShieldPack.Checked(false);
	chk_bRemoveSuperShieldPack.Checked(false);
	chk_bRemoveBandages.Checked(false);
	chk_bRemoveHealthPack.Checked(false);
	chk_bRemoveSuperHealthPack.Checked(false);
	chk_bRemoveAdrenaline.Checked(false);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'CFMutator.Mut_CFMutators'.default.bRemoveAmmoPacks = chk_bRemoveAmmoPacks.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveUDamage = chk_bRemoveUDamage.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveShieldPack = chk_bRemoveShieldPack.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveSuperShieldPack = chk_bRemoveSuperShieldPack.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveBandages = chk_bRemoveBandages.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveHealthPack = chk_bRemoveHealthPack.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveSuperHealthPack = chk_bRemoveSuperHealthPack.IsChecked();
	class'CFMutator.Mut_CFMutators'.default.bRemoveAdrenaline = chk_bRemoveAdrenaline.IsChecked();

	class'CFMutator.Mut_CFMutators'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=chk_bRemoveAmmoPacksC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove ammo packs"
         OnCreateComponent=chk_bRemoveAmmoPacksC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all ammo packs from the game."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveAmmoPacks=moCheckBox'cfmutator.CFTab_Packs.chk_bRemoveAmmoPacksC'

     Begin Object Class=moCheckBox Name=chk_bRemoveUDamageC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove damage amplifiers"
         OnCreateComponent=chk_bRemoveUDamageC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all damage amplifiers from the game."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveUDamage=moCheckBox'cfmutator.CFTab_Packs.chk_bRemoveUDamageC'

     Begin Object Class=moCheckBox Name=bRemoveShieldPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove armors"
         OnCreateComponent=bRemoveShieldPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all armors from the game except super armor."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveShieldPack=moCheckBox'cfmutator.CFTab_Packs.bRemoveShieldPackC'

     Begin Object Class=moCheckBox Name=bRemoveSuperShieldPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove super armors"
         OnCreateComponent=bRemoveSuperShieldPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all super armors from the game."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveSuperShieldPack=moCheckBox'cfmutator.CFTab_Packs.bRemoveSuperShieldPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveBandagesC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove bandages"
         OnCreateComponent=chk_bRemoveBandagesC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all bandages from the game."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveBandages=moCheckBox'cfmutator.CFTab_Packs.chk_bRemoveBandagesC'

     Begin Object Class=moCheckBox Name=chk_bRemoveHealthPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove health packs"
         OnCreateComponent=chk_bRemoveHealthPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all health packs from the game."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveHealthPack=moCheckBox'cfmutator.CFTab_Packs.chk_bRemoveHealthPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveSuperHealthPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove super health packs"
         OnCreateComponent=chk_bRemoveSuperHealthPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all super health packs from the game."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveSuperHealthPack=moCheckBox'cfmutator.CFTab_Packs.chk_bRemoveSuperHealthPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveAdrenalineC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove adrenaline"
         OnCreateComponent=chk_bRemoveAdrenalineC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all adrenaline from the game."
         WinTop=0.750000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveAdrenaline=moCheckBox'cfmutator.CFTab_Packs.chk_bRemoveAdrenalineC'

}
