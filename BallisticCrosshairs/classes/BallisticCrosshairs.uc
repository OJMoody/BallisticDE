//==============================================================================
//	_-=(K-Aus Crosshair Pack v8 for UT2004)=-_
//
//	Release Date: March 2005
//	Written by T. "Kyllian" Rypkema based on Ron Prestenback's code(Made it hard enough to figure out you fiend =P And thanks for the fix too)
//	© 2004, © 2005 Epic Games, Inc.  All Rights Reserved  © 2004, © 2005Kyrinos Systems Inc.
//	- Angel and Rache xhairs supplied by Rachel "AngelMapper" Cordone [www.angelmapper.com]
//	- Divine xhair created by Erik(DivineError) [divineerror.deviantart.com]
//	- Pub xhair supplied by PooBeard
//	- Sneeky xhair supplied by SneekyPeet
//	- [U2] Group are rebuilds of the Unreal2 xhairs based off of Unreal2 Textures
//	- [KAX] Group is identical to Unreal2 set except for color changes
//	- [uKA] Group is redesigned xhairs based off of Unreal2 xhairs
//	- [KAus] Ion name figured out by DivineError(Erik)
//	- [KVR] Group are intended as vehicle alignment reticles, but are sized to be used as normal xhairs(until Epic adds to custom xhair code to make it easier to tweak vehicle xhairs)
//
//	I wonder how many of you out there actually open up the code and find these notes...
//==============================================================================
class BallisticCrosshairs extends Crosshairpack
	notplaceable;
	#EXEC OBJ LOAD FILE=BWBP_CC_Tex.utx
	
	// This is a blank crosshair entry for easier code tweaking
	// Crosshair()=(FriendlyName="[] ",CrosshairTexture=Package.Name)

defaultproperties
{
     Crosshair(0)=(FriendlyName="[BW] Pentagram In",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.PentagramInA') 
	 Crosshair(1)=(FriendlyName="[BW] M50 Ring",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M50Out') 
     Crosshair(2)=(FriendlyName="[BW] M50 Pin",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M50In') 
     Crosshair(3)=(FriendlyName="[BW] M50 Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M50InA') 
     Crosshair(4)=(FriendlyName="[BW] M50 Ring2",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M50OutA') 
     Crosshair(5)=(FriendlyName="[BW] A73 Ring",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.A73OutA') 
     Crosshair(6)=(FriendlyName="[BW] A73 Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.A73InA') 
     Crosshair(7)=(FriendlyName="[BW] Knife Arrows",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.X3OutA') 
     Crosshair(8)=(FriendlyName="[BW] Knife Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.X3InA') 
     Crosshair(9)=(FriendlyName="[BW] M806 Ring",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M806OutA') 
     Crosshair(10)=(FriendlyName="[BW] M806 Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M806InA') 
     Crosshair(11)=(FriendlyName="[BW] Shotgun Box",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M763OutA') 
     Crosshair(12)=(FriendlyName="[BW] Shotgun Arrows",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M763InA') 
     Crosshair(13)=(FriendlyName="[BW] Machinegun Box",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M353OutA') 
     Crosshair(14)=(FriendlyName="[BW] Machinegun Marks",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.M353InA') 
     Crosshair(15)=(FriendlyName="[BW] Rifle Rings",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.R78OutA') 
     Crosshair(16)=(FriendlyName="[BW] Rifle Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.R78InA') 
     Crosshair(17)=(FriendlyName="[BW] G5 Octagon",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.G5OutA') 
     Crosshair(18)=(FriendlyName="[BW] G5 Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.G5InA') 
     Crosshair(19)=(FriendlyName="[BW] Grenade Curves",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.NRP57OutA') 
     Crosshair(20)=(FriendlyName="[BW] Grenade Box",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.NRP57InA') 
     Crosshair(21)=(FriendlyName="[BW] Cross1",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Cross1') 
     Crosshair(22)=(FriendlyName="[BW] Cross2",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Cross2') 
     Crosshair(23)=(FriendlyName="[BW] Cross3",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Cross3') 
     Crosshair(24)=(FriendlyName="[BW] Cross4",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Cross4') 
     Crosshair(25)=(FriendlyName="[BW] Round Brackets",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc1') 
     Crosshair(26)=(FriendlyName="[BW] Fat Brackets",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc7') 
     Crosshair(27)=(FriendlyName="[BW] Fat Ring",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc4') 
     Crosshair(28)=(FriendlyName="[BW] Plain Ring",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc8') 
     Crosshair(29)=(FriendlyName="[BW] Faded Circle",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc2') 
     Crosshair(30)=(FriendlyName="[BW] Sniper Box",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc6') 
     Crosshair(31)=(FriendlyName="[BW] Multi Cross",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc3') 
     Crosshair(32)=(FriendlyName="[BW] Cross Cricle",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc5') 
     Crosshair(33)=(FriendlyName="[BW] Scope Glass",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc11') 
     Crosshair(34)=(FriendlyName="[BW] Misc 1",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc9') 
     Crosshair(35)=(FriendlyName="[BW] Misc 2",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.Misc10') 
     Crosshair(36)=(FriendlyName="[BW] Pentagram Out",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.PentagramOutA') 
	 Crosshair(37)=(FriendlyName="[BW] Nova Out",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.NovaOutA')
	 Crosshair(38)=(FriendlyName="[BW] Nova In",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.NovaInA')
	 Crosshair(39)=(FriendlyName="[BW] DarkStar Out",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.DarkOutA')
	 Crosshair(40)=(FriendlyName="[BW] DarkStar In",CrosshairTexture=Texture'BWBP_CC_Tex.Crosshairs.DarkInA')
}
