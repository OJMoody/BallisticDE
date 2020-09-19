//=============================================================================
// MRS138Shotgun.
//
// A combat shotgun with a Flashlight and Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASShotgun extends BallisticWeapon;

simulated function AltFire(float F)	{	FirePressed(F);	}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 450)
		return 1;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 0;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(Instigator.Velocity) < 0.5))
		return 1;
	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (!HasMagAmmo(0) && Ammo[0].AmmoAmount < 1)
	{
		if (Dist > 400)
			return 0;
		return Result / (1+(Dist/400));
	}
	// Enemy too far away
	if (Dist > 1000)
		Result -= (Dist-1000) / 2000;
	// If the enemy has a knife, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.1 * B.Skill;
	// Sniper bad, very bad
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.3;
	Result += 1 - Dist / 1000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

    return 0.3 - (B.Skill / 6) * (1-(Dist/3000));
}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWWeaponPackArchive-Tex.SPAS.BigIcon_SPAS'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Shotgun=True
     SpecialInfo(0)=(Info="240.0;30.0;1.5;100.0;0.0;2.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway')
     MagAmmo=10
     CockSound=(Sound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-Cock',Volume=0.800000)
     ReloadAnim="ReloadLoop"
     ClipInSound=(Sound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-ShellIn')
     ClipInFrame=0.375000
     bCockOnEmpty=True
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="PrepReload"
     EndShovelAnim="EndReload"
	 ReloadAnimRate=1.5
     WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightOffset=(X=-4.000000,Y=-0.130000,Z=8.650000)
     SightingTime=0.450000
     GunLength=32.000000
     LongGunPivot=(Pitch=4500,Yaw=-8000)
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     JumpOffSet=(Pitch=1000,Yaw=-3000)
     JumpChaos=0.700000
     ViewAimFactor=0.150000
     ChaosSpeedThreshold=550.000000
	 bNoCrosshairInScope=True
	 AimSpread=16
     ChaosDeclineTime=0.750000
     ChaosAimSpread=256
     
	 ViewRecoilFactor=0.4
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.100000
     RecoilYFactor=0.100000
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.75
	 
     FireModeClass(0)=Class'BWBPArchivePackDE.SPASSecondaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.SPASPrimaryFire'
     PutDownTime=0.500000
     AIRating=0.600000
     CurrentRating=0.600000
     Description="SPAS-12 Shotgun||Manufacturer: Classic Weapons Industries|Primary: Pump Shot|Secondary: Semi-Auto Shot||The SPAS is another well known firearm brought back to life by Classic Weapons Industries. A highly accurate 12-gauge shotgun, the 8 shell SPAS 12 was originally produced by Franchi in the pre-war period. It was a formidible dual-mode shotgun that could be fired in both semi-automatic and pump-action firemodes. CWI has worked to improve this venerable classic and has overhauled the original pump action firemode for improved accuracy and range. Users have the option of quickly switching between these modes to deal with different tactical situations. Comes with a variety of pre-war attachments for all your shooting needs."
     DisplayFOV=50.000000
     Priority=36
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     GroupOffset=6
     PickupClass=Class'BWBPArchivePackDE.SPASPickup'
     PlayerViewOffset=(X=5.000000,Y=3.000000,Z=-6.000000)
     AttachmentClass=Class'BWBPArchivePackDE.SPASAttachment'
     IconMaterial=Texture'BWWeaponPackArchive-Tex.SPAS.SmallIcon_SPAS'
     IconCoords=(X2=127,Y2=30)
     ItemName="SPAS-12 Automatic Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.Spas_FPm'
     DrawScale=1.000000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
