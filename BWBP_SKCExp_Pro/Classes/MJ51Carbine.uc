//=============================================================================
// MJ51Carbine.
//
// Medium range, controllable 3-round burst carbine.
// Lacks power and accuracy at range, but is easier to aim
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MJ51Carbine extends BallisticWeapon;

var() bool		bFirstDraw;
var() name		GrenadeLoadAnim;	//Anim for grenade reload
var()   bool		bLoaded;


var() name		GrenBone;			
var() name		GrenBoneBase;
var() Sound		GrenSlideSound;		//Sounds for grenade reloading
var() Sound		ClipInSoundEmpty;		//			

var name			BulletBone;
var name			BulletBone2;


static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_STANAGChaff';
}

//Chaff grenade spawn moved here
function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
	
	if ( Instigator.FindInventoryType(class'BCGhostWeapon') != None ) //ghosts are scary
	return;

	if(Instigator.FindInventoryType(class'BWBP_SKC_Pro.ChaffGrenadeWeapon')!=None )
	{
		W = Spawn(class'BWBP_SKC_Pro.ChaffGrenadeWeapon',,,Instigator.Location);
		if( W != None)
		{
			W.GiveTo(Instigator);
			W.ConsumeAmmo(0, 9999, true);
			W.ConsumeAmmo(1, 9999, true);
		}
	}
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'Fire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 2)
		{
			SetBoneScale(2,0.0,BulletBone);
			SetBoneScale(3,0.0,BulletBone2);
		}
	}
	super.AnimEnd(Channel);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (bFirstDraw && MagAmmo > 0)
	{
     	BringUpTime=2.0;
     	SelectAnim='Pullout';
		bFirstDraw=false;
		bLoaded=False;
	}
	else
	{
     	BringUpTime=default.BringUpTime;
		SelectAnim='Pullout';
	}
	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{

		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
		ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		ReloadAnim = 'Reload';
	}
	super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{

	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}

	if (super.PutDown())
	{
		return true;
	}
	return false;
}


// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || bLoaded)
		return;
	if (ReloadState == RS_None)
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(2,1.0,BulletBone);
	SetBoneScale(3,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
	}
}


// Notifys for greande loading sounds
simulated function Notify_GrenVisible()	{	SetBoneScale (0, 1.0, GrenBone); SetBoneScale (1, 1.0, GrenBoneBase);	ReloadState = RS_PreClipOut;}
simulated function Notify_GrenSlide()	{	PlaySound(GrenSlideSound, SLOT_Misc, 2.2, ,64);	}
simulated function Notify_GrenLoaded()	
{
    	local Inventory Inv;

	MJ51Attachment(ThirdPersonActor).bGrenadier=true;	
	MJ51Attachment(ThirdPersonActor).IAOverride(True);

	Ammo[1].UseAmmo (1, True);
	if (Ammo[1].AmmoAmount == 0)
	{
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			if (ChaffGrenadeWeapon(Inv) != None)
			{
				ChaffGrenadeWeapon(Inv).RemoteKill();	
				break;
			}
	}
}
simulated function Notify_GrenReady()	{	ReloadState = RS_None; bLoaded = true;	}
simulated function Notify_GrenLaunch()	
{
	SetBoneScale (0, 0.0, GrenBone); 	
	MJ51Attachment(ThirdPersonActor).IAOverride(False);
	MJ51Attachment(ThirdPersonActor).bGrenadier=false;
}
simulated function Notify_GrenInvisible()	{ SetBoneScale (1, 0.0, GrenBoneBase);	}


simulated function PlayReload()
{

    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadEmpty';
       ClipHitSound.Sound=ClipInSoundEmpty;
    }
    else
    {
       ReloadAnim='Reload';
       ClipHitSound.Sound=default.ClipHitSound.Sound;
    }
	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}
	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function IndirectLaunch()
{
//	StartFire(1);
}

// HARDCODED SIGHTING TIME
simulated function TickSighting (float DT)
{
	if (SightingState == SS_None || SightingState == SS_Active)
		return;

	if (SightingState == SS_Raising)
	{	// Raising gun to sight position
		if (SightingPhase < 1.0)
		{
			if ((bScopeHeld || bPendingSightUp) && CanUseSights())
				SightingPhase += DT/0.20;
			else
			{
				SightingState = SS_Lowering;

				Instigator.Controller.bRun = 0;
			}
		}
		else
		{	// Got all the way up. Now go to scope/sight view
			SightingPhase = 1.0;
			SightingState = SS_Active;
			ScopeUpAnimEnd();
		}
	}
	else if (SightingState == SS_Lowering)
	{	// Lowering gun from sight pos
		if (SightingPhase > 0.0)
		{
			if (bScopeHeld && CanUseSights())
				SightingState = SS_Raising;
			else
				SightingPhase -= DT/0.20;
		}
		else
		{	// Got all the way down. Tell the system our anim has ended...
			SightingPhase = 0.0;
			SightingState = SS_None;
			ScopeDownAnimEnd();
			DisplayFOv = default.DisplayFOV;
		}
	}
}


simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (AimComponent.GetChaos() < 0.1 || AimComponent.GetChaos() < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}
	else if (FRand() > 0.75)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     bFirstDraw=True
     GrenadeLoadAnim="LoadGrenade"
     GrenBone="Grenade"
     GrenBoneBase="GrenadeHandle"
     GrenSlideSound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51-GrenLock'
     ClipInSoundEmpty=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51-MagInEmpty'
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;0.8;0.7;0.2")
     AIReloadTime=1.000000
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_TexExp.M4A1.BigIcon_M4'
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-PullOut',Volume=2.200000)
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Putaway',Volume=2.200000)
     WeaponModes(0)=(ModeName="Semi-Auto")
     WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_Burst",Value=3.000000)
     WeaponModes(2)=(bUnavailable=True)
     WeaponModes(3)=(ModeName="Automatic",bUnavailable=True,ModeID="WM_FullAuto")
     CurrentWeaponMode=1
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',USize1=128,VSize1=128,USize2=128,VSize2=128,Color1=(B=0,G=0,R=255,A=158),Color2=(B=0,G=255,R=255,A=255),StartSize1=75,StartSize2=72)
     bNoCrosshairInScope=True
     SightOffset=(X=20.000000,Y=-6.450000,Z=20.500000)
     SightDisplayFOV=40.000000
     CockSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51-Cock',Volume=2.200000)
     ClipHitSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51-MagIn',Volume=4.800000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51-MagOut',Volume=4.800000)
     ClipInFrame=0.650000
     LongGunOffset=(X=10.000000)
     bWT_Bullet=True
     SightingTime=0.200000
     ReloadAnimRate=0.850000
     GunLength=50.000000
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.MJ51PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.MJ51SecondaryFire'
     IdleAnimRate=0.200000
     PutDownTime=0.700000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="MJ51 Carbine||Manufacturer: Majestic Firearms 12|Primary: 5.56mm CAP Rifle Fire|Secondary: Attach Smoke Grenade||The MJ51 is a 3-round burst carbine based off the popular M50 assault rifle. Unlike the M50 and SAR though, it fires a shorter 5.56mm CAP round and is more controllable than its larger cousin, though this comes at the expense of long range accuracy and power. While the S-AR 12 is the UTC's weapon of choice for close range engagements, the MJ51 is often seen in the hands of MP and urban security details. When paired with its native MOA-C Rifle Grenade attachment, the MJ51 makes an efficient riot control weapon. |Majestic Firearms 12 designed their MJ51 carbine alongside their MOA-C Chaff Grenade to produce a rifle with grenade launching capabilities without the need of a bulky launcher that has to be sperately maintained. Utilizing a hardened tungsten barrel and an advanced rifle grenade design, a soldier is able to seamlessly ready a grenade projectile without having to rechamber specilized rounds"
     Priority=41
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBP_SKCExp_Pro.MJ51Pickup'
     PlayerViewOffset=(X=-8.000000,Y=10.000000,Z=-14.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKCExp_Pro.MJ51Attachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.M4A1.SmallIcon_M4'
     IconCoords=(X2=127,Y2=31)
     ItemName="MJ51 Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_MJ55A3'
	 ParamsClasses(0)=Class'MJ51CarbineWeaponParamsArena'
     ParamsClasses(1)=Class'MJ51WeaponParamsClassic'
     DrawScale=0.300000
}
