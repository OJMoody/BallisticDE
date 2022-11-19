//=============================================================================
// M353Machinegun.
//
// The "Guardian" M353 Machinegun has an extremely high fire rate, high ammo
// capacity and decent damage, but is extremely inacurate and can quickly fight
// its way from its owner's control. Secondary allows the user to mount the
// weapon on the ground by crouching.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CruMachinegun extends BallisticMachinegun
	transient
	HideDropDown
	CacheExempt;

var() BUtil.FullSound	LeverUpSound;	// Sound to play when Lever opens
var() BUtil.FullSound	LeverDownSound;	// Sound to play when Lever closes

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock=false;
}

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local int Forward;

	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	// BallisticPro specific: Can be deployed upon sandbags providing that sandbag is not hosting
	// another weapon already. When deployed upon sandbags, the weapon is automatically deployed 
	// to the centre of the bags.
	
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'M353Turret'.default.CollisionHeight + 30;
	}
	
	else
	{
		HitLoc.Z += class'M353Turret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'M353Turret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for M353 Machinegun");
}

// Run when Lever is Up
simulated function Notify_LeverUp ()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(LeverUpSound.Sound,LeverUpSound.Slot,LeverUpSound.Volume,LeverUpSound.bNoOverride,LeverUpSound.Radius,LeverUpSound.Pitch,LeverUpSound.bAtten);
	else
	    class'BUtil'.static.PlayFullSound(self, LeverUpSound);
}

// Run when Lever is Down
simulated function Notify_LeverDown ()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(LeverDownSound.Sound,LeverDownSound.Slot,LeverDownSound.Volume,LeverDownSound.bNoOverride,LeverDownSound.Radius,LeverDownSound.Pitch,LeverDownSound.bAtten);
	else
	    class'BUtil'.static.PlayFullSound(self, LeverDownSound);
}

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
	local SandbagLayer Bags;
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
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	if(BallisticTurret(Instigator) == None && Instigator.IsHumanControlled() && class'SandbagLayer'.static.ShouldGiveBags(Instigator))
    {
        Bags = Spawn(class'SandbagLayer',,,Instigator.Location);
		
		if (Instigator.Weapon == None)
			Instigator.Weapon = Self;
			
        if( Bags != None )
            Bags.GiveTo(Instigator);
    }
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 1024, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
	BeltBones(0)="Bullet2"
	LeverUpSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-LeverUp')
	LeverDownSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-LeverDown')
	BoxOnSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-BoxOn')
	BoxOffSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-BoxOff')
	FlapUpSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-FlapUp')
	FlapDownSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-FlapDown')
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BWBP_CC_Tex.MillitaryLaser.BigIcon_CruML'
	BigIconCoords=(Y1=50,Y2=240)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)=""
	ManualLines(1)=""
	ManualLines(2)=""
	SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-Cock')
	ReloadAnim="ReloadStart"
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-BulletsOff')
	ClipInSound=(Sound=Sound'BWBP_CC_Sounds.MillitaryLaser.MG-BulletsOn')
	ClipInFrame=0.650000
	bCockOnEmpty=True
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Burst of Three")
	WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
	WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
    
	
	
	CurrentWeaponMode=3
	bNoCrosshairInScope=True
	SightOffset=(X=-15.000000,Y=-0.900000,Z=19.30000)
	ParamsClasses(0)=Class'CruWeaponParams'
	FireModeClass(0)=Class'BWBP_APC_Pro.CruPrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.CruPrimaryFire'
	SelectAnimRate=1.350000
	PutDownTime=0.550000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.7500000
	CurrentRating=0.7500000
	Description=""
	DisplayFOV=50.000000
	Priority=43
	HudColor=(G=150,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	PickupClass=Class'BallisticProV55.M353Pickup'
	PlayerViewOffset=(X=15.000000,Y=7.000000,Z=-11.000000)
	AttachmentClass=Class'BallisticProV55.M353Attachment'
	IconMaterial=Texture'BWBP_CC_Tex.MillitaryLaser.SmallIcon_CruML'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] Trident MG"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_CruMG'
	DrawScale=0.350000
}
