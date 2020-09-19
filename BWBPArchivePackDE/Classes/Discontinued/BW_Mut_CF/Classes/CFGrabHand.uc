//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFGrabHand extends Weapon;

struct PickupMeshInfo
{
	var() config string		ClassName;
	var() config rotator	Rotation;
	var() config vector		Location;
	var() config float		DrawScale;
	var() config int		AnimNo;
	var array<byte> 		AlphaTex;
};

var PickupMeshInfo pmi;
var PickupMeshActor pmesh;
var name attachBone;
var Pickup pick;
var int pickupAmmo;
var Rotator originalViewRotation;
var class<Inventory> InventoryType;

simulated function bool PutDown()
{
	return false; // return false if preventing weapon switch
}

simulated event AnimEnd (int Channel)
{
 	//if(Instigator != none && BallisticPawn(Instigator) != none)
		//BallisticPawn(Instigator).EquipPickUp(InventoryType);

	Destroy();
}

simulated event Destroyed()
{
	if(pmesh != none)
		pmesh.Destroy();
	Super.Destroyed();
}

simulated function SpawnMesh()
{
	local StaticMesh gunStatic;
	gunStatic = pick.StaticMesh;

	pmesh = Spawn(class'BW_Mut_CF.PickupMeshActor',,,pick.Location,pick.Rotation);
	if(pmesh != none)
	{
		pmesh.SetStaticMesh(gunStatic);
		pmesh.SetDrawScale(pick.DrawScale);
	}
}

simulated function Notify_HandOpen()
{
	local class<BallisticWeaponPickup> cl;
	local int i;

	cl = class<BallisticWeaponPickup>(class<BallisticWeapon>(InventoryType).default.PickupClass);
	pmesh.SetStaticMesh(cl.default.StaticMesh);

	if(pmesh != none)
	{
		AttachToBone(pmesh, attachBone);

		pmesh.SetDrawScale(pmi.DrawScale);
		pmesh.SetRelativeRotation(pmi.Rotation);
		pmesh.SetRelativeLocation(pmi.Location);

		for(i = 0; i < pmi.AlphaTex.Length; i++)
			pmesh.Skins[pmi.AlphaTex[i]] = Texture'ONSstructureTextures.CoreGroup.Invisible';
	}

	Instigator.bSpecialCalcView = false;
	Instigator.bMovable = true;
	//BallisticPawn(Instigator).bLockedView = false;
	Instigator.SetViewRotation(originalViewRotation);
}

simulated function bool HasAmmo()
{
	return true;
}

simulated function GetAmmoCount(out float MaxAmmoPrimary, out float CurAmmoPrimary)
{
	MaxAmmoPrimary = pickupAmmo;
	CurAmmoPrimary = pickupAmmo;
}

simulated function class<Ammunition> GetAmmoClass(int mode)
{
	return class<weapon>(InventoryType).default.FireModeClass[0].default.AmmoClass;
}

simulated function bool StartFire(int Mode)
{
	return false;
}

simulated function DoAutoSwitch()
{}

defaultproperties
{
     AttachBone="Gun"
     FireModeClass(0)=Class'Engine.WeaponFire'
     FireModeClass(1)=Class'Engine.WeaponFire'
     IdleAnim="Action"
     RestAnim="Action"
     AimAnim="Action"
     RunAnim="Action"
     SelectAnim="Action"
     SelectAnimRate=2.000000
     BringUpTime=600.000000
     bCanThrow=False
     bForceSwitch=True
     InventoryGroup=10
     PlayerViewOffset=(X=40.000000)
     IconMaterial=Texture'HUDContent.Generic.HUD'
     ItemName=" "
     Mesh=SkeletalMesh'CFMutatorAnims.GrabAnims'
     bGameRelevant=True
}
