//=============================================================================
// MGA88MachinegunTurret.
//
// 3rd Weapon used for MGA88 Turrets. Properties altered to be more like a deployed wepaon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MGA88MachinegunTurret extends MGA88Machinegun
    HideDropDown
    CacheExempt;

function InitTurretWeapon(BallisticTurret Turret)
{
    Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    FireMode[0].FireAnim = 'Fire';
    FireMode[0].FireLoopAnim = 'Fire';
    BallisticFire(FireMode[0]).BrassOffset = vect(0,0,0);
}

simulated function PostNetBeginPlay()
{
    super.PostNetBeginPlay();
    if (BallisticTurret(Instigator) != None && BallisticTurret(Instigator).bWeaponDeployed)
    {
        SelectAnim=IdleAnim;
        SelectAnimRate=IdleAnimRate;
        BringUpTime = 0.1;
    }
}

simulated event Timer()
{
    if (ClientState == WS_BringUp && BallisticTurret(Instigator) != None)
        BallisticTurret(Instigator).bWeaponDeployed = true;

    super.Timer();
}

// Rotates the player's view according to Aim
// Split into recoil and aim to accomodate no view decline
simulated function ApplyAimToView()
{
	local Rotator BaseAim, BaseRecoil;

	//DC 110313
	if (Instigator.Controller == None || AIController(Instigator.Controller) != None || !Instigator.IsLocallyControlled())
		return;

	BaseRecoil = GetRecoilPivot(true) * ViewRecoilFactor;
	BaseAim = Aim * ViewAimFactor ;
	if (bForceRecoilUpdate || LastFireTime >= Level.TimeSeconds - RecoilDeclineDelay)
	{
		bForceRecoilUpdate = False;
		Instigator.SetViewRotation((BaseAim - ViewAim) + (BaseRecoil - ViewRecoil));
	}
	else
		Instigator.SetViewRotation(BaseAim - ViewAim);
	ViewAim = BaseAim;
	ViewRecoil = BaseRecoil;	
}

simulated function Notify_Undeploy ()
{
    if (BallisticTurret(Instigator) != None && Role == ROLE_Authority)
        BallisticTurret(Instigator).UndeployTurret();
}

simulated function Notify_Deploy ();

simulated function PreDrawFPWeapon()
{
    super.PreDrawFPWeapon();
    SetRotation(Instigator.Rotation);
}

simulated function TickAim(float DT)
{
    Super(BallisticWeapon).TickAim(DT);
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (anim == 'Undeploy')
    {
        Notify_Undeploy();
        return;
    }
    Super.AnimEnd(Channel);
}

/*function AttachToPawn(Pawn P)
{
    Instigator = P;
    if ( ThirdPersonActor == None )
    {
        ThirdPersonActor = Spawn(AttachmentClass,Owner);
        InventoryAttachment(ThirdPersonActor).InitFor(self);
    }
    else
        ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;

    ThirdPersonActor.SetLocation(P.Location);
    ThirdPersonActor.SetBase(P);
}*/

simulated event RenderOverlays (Canvas C)
{
    DisplayFOV = Instigator.Controller.FovAngle;
    Super.RenderOverlays(C);
}

simulated function ApplyAimRotation()
{
    ApplyAimToView();

    BallisticTurret(Instigator).WeaponPivot = (GetAimPivot() + GetRecoilPivot()) * (DisplayFOV / Instigator.Controller.FovAngle);
}

simulated function PlayReload()
{
    PlayAnim('ReloadHandle', ReloadAnimRate, , 0.25);
}
// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
    if (bNeedCock && MagAmmo > 0)
        CommonCockGun(2);
    else
        PlayAnim('ReloadFinishHandle', ReloadAnimRate, 0.2);
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


defaultproperties
{
     bUseSights=False
     GunLength=0.000000
     bUseSpecialAim=True
     ViewRecoilFactor=0.000000
     AimDamageThreshold=2000.000000
     RecoilPitchFactor=0.000000
     RecoilXFactor=0.500000
     RecoilYFactor=0.100000
     RecoilMax=800.000000
     RecoilDeclineTime=1.000000
     SelectAnim="Deploy"
     BringUpTime=1.500000
     bCanThrow=False
     bNoInstagibReplace=True
     DisplayFOV=90.000000
     ClientState=WS_BringUp
     Priority=1
     PlayerViewOffset=(X=11.000000,Z=-14.000000)
     ItemName="MGA88 Machinegun Turret"
     Mesh=SkeletalMesh'BWXWeaponAnims.MGA88-FPm_Turret'
     DrawScale=0.700000
     CollisionHeight=26.000000
}
