//=============================================================================
// PUGAssaultCannon
//
// Shots 4-rubbers + smokey things. We are unsure as to what PUG stands for.
// 
// Political Umbrella Generator.
// Pretty Under Garments.
// Police - Urban Gun.
// Peter's Undying Grape
// Please Undress Gary
// Party Unto Greece
// Pontificating Unilateral Greco-Roman Alliance
// Pardon Ugly Grannys
// Pulchritudinous Unitologist Greifer
// Punch Up, Goyim
// Poopy Underwear Gentleman
// Praise Unofficial Germans
// Poisonous Undershirt Gratification
// Pale Ugly Grapefruit
// Patty's Ugly Gerbil
// Papa Uniform Golf
// Papa, Untie Gertrude
//
// by Gary "Gary" Gary.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class PUGAssaultCannon extends BallisticWeapon;

var() name		GrenadeLoadAnim;	//Anim for grenade reload

var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else
			PUGSecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			PUGSecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return PUGSecondaryFire(FireMode[1]).bLoaded;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == GrenadeLoadAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
		
	Super.AnimEnd(Channel);
}

// Load in a grenade
simulated function LoadGrenade()
{
    if (bScopeView && Instigator.IsLocallyControlled())
        TemporaryScopeDown(0.5);

    if (Ammo[1].AmmoAmount < 1 || PUGSecondaryFire(FireMode[1]).bLoaded)
        return;
    if (ReloadState == RS_None)
    {
        ReloadState = RS_Cocking;
        PlayAnim(GrenadeLoadAnim, 1.1, , 0);
    }        
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	
	if (seq == GrenadeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

// Notifys for greande loading sounds
simulated function Notify_PUGGrenadeSlideUp()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_PUGGrenadeIn()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_PUGGrenadeSlideDown()	
{	
	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); 
	PUGSecondaryFire(FireMode[1]).bLoaded = true; 
	FireMode[1].PreFireTime = FireMode[1].default.PreFireTime;
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
}

// AI Interface =====

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
			return false;
		}
	}
	return super.CanAttack(Other);
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
     GrenOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     GrenCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
	 GrenadeLoadAnim="ReloadGrenade"
     PlayerSpeedFactor=0.900000
     PlayerJumpFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BWBPAnotherPackTex.PUG12.BigIcon_PUG12'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="120.0;15.0;0.8;70.0;0.75;0.5;0.0")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-PullOut',Volume=1.600000)
     PutDownSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-PutAway',Volume=1.400000)
     MagAmmo=15
     CockSound=(Sound=Sound'BWBPAnotherPackSounds.PUG.PUG-Cock',Volume=4.000000)
     ReloadAnim="Reload"
     ClipHitSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-MagHit')
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-MagOut',Volume=1.000000)
     ClipInSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-MagIn',Volume=1.700000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     bNeedCock=False
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	 WeaponModes(1)=(ModeName="Laser-Auto",bUnavailable=True,Value=7.000000)
     WeaponModes(3)=(ModeName="FRAG-12 Loaded",bUnavailable=True,ModeID="WM_FullAuto")
     WeaponModes(4)=(ModeName="ERROR",bUnavailable=True,ModeID="WM_FullAuto")
     WeaponModes(5)=(ModeName="ERROR",bUnavailable=True,ModeID="WM_FullAuto")
     CurrentWeaponMode=0
     SightPivot=(Pitch=256)
     SightOffset=(X=10.000000,Y=-1.160000,Z=20.900000)
     SightDisplayFOV=40.000000
     GunLength=48.000000
     FireModeClass(0)=Class'BWBPAnotherPackDE.PUGPrimaryFire'
     FireModeClass(1)=Class'BWBPAnotherPackDE.PUGSecondaryFire'
     PutDownTime=0.900000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     Description="No matter what year it is, there will always be those who don't have the same ideals as the UTC troops. Even during the skrith wars, there'll be conscientious objectors who oppose violence and they'll adapt to suppressive tools like the PUG Suppression Cannon.  Designed to fire both rubber slugs and tear gas grenades, it was supposed to be a versatile tool to quell any riots; only it worked a little too well as the slugs managed to break bones and rupture vital organs while the gas suffocated those who got too close. The suppression cannon no longer is used in upholding the law, rather it has ironically found its way in troopers hands to flush out Skrith in their hiding holes."
     Priority=162
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     GroupOffset=13
     PickupClass=Class'BWBPAnotherPackDE.PUGPickup'
     PlayerViewOffset=(X=12.000000,Y=8.000000,Z=-16.000000)
     BobDamping=1.600000
     AttachmentClass=Class'BWBPAnotherPackDE.PUGAttachment'
     IconMaterial=Texture'BWBPAnotherPackTex.PUG12.SmallIcon_PUG12'
     IconCoords=(X2=127,Y2=31)
     ItemName="PUG-M2 Riot Supression Cannon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClass=Class'PUGWeaponParams'
     Mesh=SkeletalMesh'BWBPAnotherPackAnims.FPm_Pug12'
     DrawScale=1.600000
}
