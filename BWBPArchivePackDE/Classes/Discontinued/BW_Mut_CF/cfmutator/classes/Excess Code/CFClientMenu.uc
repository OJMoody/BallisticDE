//=============================================================================
// CFClientMenu.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFClientMenu extends UT2k4GUIPage;

var CFClientMenuInterface MI;
var UT2K4GUIPage previPage;
var PlayerController PC;

simulated function GRIAccessible(){}

simulated function bool CloseMenu(){ return true; }

defaultproperties
{
}
