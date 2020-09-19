//=============================================================================
// CFConfigMenu.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFConfigMenu extends UT2K4GUIPage;

var Automated GUIImage		bg;
var Automated GUIButton		BDone, BCancel, BReset, BDefault, BPurge;
var automated GUIHeader		header;
var automated GUITabControl	ctrl_Tabs;

var() editconst noexport CFTab_Player			tab_Player;
var() editconst noexport CFTab_Weapons			tab_Weapons;
var() editconst noexport CFTab_Packs			tab_Packs;
var() editconst noexport CFTab_Rules			tab_Rules;
var() editconst noexport CFTab_Sprint			tab_Sprint;
var() editconst noexport CFTab_Misc			    tab_Misc;

var() localized string 	HeaderCaption;
var() localized string  TabPlayerLabel, TabPlayerHint,
						TabWeaponLabel, TabWeaponHint,
						TabPacksLabel, TabPacksHint,
						TabRulesLabel, TabRulesHint,
						TabMiscLabel, TabMiscHint,
						TabSprintLabel, TabSprintHint;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.Initcomponent(MyController, MyOwner);

	header.DockedTabs 	= ctrl_Tabs;
	tab_Player		  	= CFTab_Player(ctrl_Tabs.AddTab(TabPlayerLabel,"CFMutator.CFTab_Player",,TabPlayerHint));
	tab_Weapons		  	= CFTab_Weapons(ctrl_Tabs.AddTab(TabWeaponLabel,"CFMutator.CFTab_Weapons",,TabPlayerHint));
	tab_Packs		  	= CFTab_Packs(ctrl_Tabs.AddTab(TabPacksLabel,"CFMutator.CFTab_Packs",,TabPacksHint));
	tab_Rules		  	= CFTab_Rules(ctrl_Tabs.AddTab(TabRulesLabel,"CFMutator.CFTab_Rules",,TabRulesHint));
	tab_Sprint          = CFTab_Sprint(ctrl_Tabs.AddTab(TabSprintLabel, "CFMutator.CFTab_Sprint",,TabSprintHint));
	tab_Misc            = CFTab_Misc(ctrl_Tabs.AddTab(TabMiscLabel, "CFMutator.CFTab_Misc",,TabMiscHint));
}

function InternalOnChange(GUIComponent Sender)
{
	if (GUITabButton(Sender)==none)
		return;

	header.SetCaption(HeaderCaption@"|"@GUITabButton(Sender).Caption);
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);
	else if (Key == 0x1B && State == 3)	// Escape
		return InternalOnClick(BCancel);

	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==BCancel) // CANCEL
		Controller.CloseMenu();
	else if (Sender==BPurge) // ???
	{
		PurgeSettings();
		LoadSettings();

	}
	else if (Sender==BDone) // DONE
	{
		SaveSettings();
		Controller.CloseMenu();
	}
	else if (Sender==BReset) // RESET
	{
		switch (ctrl_Tabs.ActiveTab.MyPanel)
		{
			 case tab_Player:		tab_Player.LoadSettings(); break;
			 case tab_Weapons:		tab_Weapons.LoadSettings(); break;
			 case tab_Packs:		tab_Packs.LoadSettings(); break;
			 case tab_Rules:		tab_Rules.LoadSettings(); break;
			 case tab_Sprint:       tab_Sprint.LoadSettings(); break;
			 case tab_Misc:         tab_Misc.LoadSettings(); break;
		}

	}
	else if (Sender==BDefault) // DEFAULTS
	{
		switch (ctrl_Tabs.ActiveTab.MyPanel)
		{
			 case tab_Player:		tab_Player.DefaultSettings(); break;
			 case tab_Weapons:		tab_Weapons.DefaultSettings(); break;
			 case tab_Packs:		tab_Packs.DefaultSettings(); break;
			 case tab_Rules:		tab_Rules.DefaultSettings(); break;
			 case tab_Sprint:       tab_Sprint.DefaultSettings(); break;
			 case tab_Misc:         tab_Misc.DefaultSettings(); break;
		}
	}
	return true;
}

function SaveSettings()
{
	tab_Player.SaveSettings();
	tab_Weapons.SaveSettings();
	tab_Packs.SaveSettings();
	tab_Rules.SaveSettings();
	tab_Sprint.SaveSettings();
	tab_Misc.SaveSettings();
}

function LoadSettings()
{
	tab_Player.LoadSettings();
	tab_Weapons.LoadSettings();
	tab_Packs.LoadSettings();
	tab_Rules.LoadSettings();
	tab_Sprint.DefaultSettings();
	tab_Misc.LoadSettings();
}

function DefaultSettings()
{
	tab_Player.DefaultSettings();
	tab_Weapons.DefaultSettings();
	tab_Packs.DefaultSettings();
	tab_Rules.DefaultSettings();
	tab_Sprint.DefaultSettings();
	tab_Misc.DefaultSettings();
}

function PurgeSettings()
{
	class'Mut_CFMutators'.static.StaticClearConfig();
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinLeft=0.100000
         WinWidth=0.800000
         WinHeight=1.000000
         RenderWeight=0.001000
     End Object
     Bg=GUIImage'cfmutator.CFConfigMenu.BackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="OK"
         Hint="Save settings and exit menu."
         WinTop=0.900000
         WinLeft=0.200000
         WinWidth=0.100000
         TabOrder=0
         OnClick=CFConfigMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'cfmutator.CFConfigMenu.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         Hint="Exit menu without saving."
         WinTop=0.900000
         WinLeft=0.700000
         WinWidth=0.100000
         TabOrder=1
         OnClick=CFConfigMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'cfmutator.CFConfigMenu.CancelButton'

     Begin Object Class=GUIButton Name=BResetButton
         Caption="RESET"
         Hint="Undo all changes."
         WinTop=0.900000
         WinLeft=0.375000
         WinWidth=0.100000
         TabOrder=2
         OnClick=CFConfigMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bReset=GUIButton'cfmutator.CFConfigMenu.BResetButton'

     Begin Object Class=GUIButton Name=BDefaultButton
         Caption="DEFAULTS"
         Hint="Load default settings."
         WinTop=0.900000
         WinLeft=0.525000
         WinWidth=0.100000
         TabOrder=3
         OnClick=CFConfigMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bDefault=GUIButton'cfmutator.CFConfigMenu.BDefaultButton'

     Begin Object Class=GUIHeader Name=dlgHeader
         bUseTextHeight=True
         Caption="Crazy-Froggers Mutator"
         FontScale=FNS_Medium
         WinLeft=0.100000
         WinWidth=0.800000
         WinHeight=1.000000
     End Object
     Header=GUIHeader'cfmutator.CFConfigMenu.dlgHeader'

     Begin Object Class=GUITabControl Name=PageTabs
         bDockPanels=True
         TabHeight=0.040000
         BackgroundStyleName="TabBackground"
         WinLeft=0.110000
         WinWidth=0.780000
         WinHeight=0.040000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=CFConfigMenu.InternalOnChange
     End Object
     ctrl_Tabs=GUITabControl'cfmutator.CFConfigMenu.PageTabs'

     HeaderCaption="Crazy-Froggers Mutator"
     TabPlayerLabel="Player"
     TabPlayerHint="Player related settings"
     TabWeaponLabel="Weapons"
     TabWeaponHint="Weapons related settings"
     TabPacksLabel="Items"
     TabPacksHint="Items related settings. Health packs, ammo packs, armor, adrenaline ect ..."
     TabRulesLabel="Rules"
     TabRulesHint="Define additional game rules such as kill rewards in health point or adrenaline"
     TabMiscLabel="Misc"
     TabMiscHint="Miscellaneous stuff."
     TabSprintLabel="Sprint"
     TabSprintHint="Sprint related settings."
     bRenderWorld=True
     bAllowedAsLast=True
     OnKeyEvent=CFConfigMenu.InternalOnKeyEvent
}
