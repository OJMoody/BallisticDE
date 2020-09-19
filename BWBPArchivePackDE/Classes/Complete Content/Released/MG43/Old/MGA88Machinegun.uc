//=============================================================================
// MGA88Machinegun.
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
class MGA88Machinegun extends BallisticMachinegun;

simulated function PlayIdle()
{
    if (IsFiring())
        return;

    if (bPendingSightUp)
    {
        ScopeBackUp();
        return;
    }

    SightingTime = default.SightingTime * default.SightingTimeScale;

    if (SightingState != SS_None)
        IdleAnim = 'SightIdle';
    else
        IdleAnim = default.IdleAnim;

    if (SightingState != SS_None && SightingState != SS_Raising)
    {
        if (SafePlayAnim(IdleAnim, 1.0))
            FreezeAnimAt(0.0);
    }
    else if (bScopeView)
    {
        if(SafePlayAnim(ZoomOutAnim, 1.0))
            FreezeAnimAt(0.0);
    }
    else if(SightingState != SS_Raising)
    {
        SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
    }
}

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

simulated function TickAim(float DT)
{
    Super(BallisticWeapon).TickAim(DT);
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
        if (T != None && T.bWorldGeometry && HitNorm.Z >= 0.7 && FastTrace(HitLoc, Start))
            break;
        if (Forward <= 45)
            return;
    }

    FireMode[1].bIsFiring = false;
    FireMode[1].StopFiring();

    HitLoc.Z += Class'M353Turret'.default.CollisionHeight - 9;


    CompressedEq = Instigator.Rotation;

    //Rotator compression causes disparity between server and client rotations,
    //which then plays hob with the turret's aim.
    //Do the compression first then use that to spawn the turret.

    CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
    CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
    CompressedEq.Pitch = (CompressedEq.Pitch << 8);
    CompressedEq.Yaw = (CompressedEq.Yaw << 8);

    Turret = Spawn(class'MGA88TurretPawn', None,, HitLoc, CompressedEq);

    if (Turret != None)
    {


        Turret.InitDeployedTurretFor(self);
//      PlaySound(DeploySound, Slot_Interact, 0.7,,64,1,true);
        Turret.TryToDrive(Instigator);
        Destroy();
    }
    else
        log("Notify_Deploy: Could not spawn turret for M353Machinegun");
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

simulated function bool HasAmmo()
{
    //First Check the magazine
    if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
        return true;
    //If it is a non-mag or the magazine is empty
    if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
            return true;
    return false;   //This weapon is empty
}

// Play the scope up anim or start the 'sighting' repositioning of gun
simulated function PlayScopeUp()
{
    if (HasAnim(ZoomInAnim))
    {
        SafePlayAnim(ZoomInAnim, 1.0);
        SightingState = SS_Raising;
    }

    PlayerController(Instigator.Controller).bZooming = True;

    Instigator.Controller.bRun = 1;
}


simulated function PlayScopeDown(optional bool bNoAnim)
{
    if (!bNoAnim && HasAnim(ZoomOutAnim))
    {
        SafePlayAnim(ZoomOutAnim, 1.0);

        if (SightingState == SS_Active || SightingState == SS_Raising)
            SightingState = SS_Lowering;
    }
    Instigator.Controller.bRun = 0;
}

exec simulated function ScopeView()
{
    bScopeHeld=true;
    bPendingSightUp=false;

    if (!bUseSights)
        return;
    if (bScopeView)
    {
        bScopeHeld=false;
        StopScopeView();
        return;
    }

    if (!CanUseSights())
        return;

    ZeroAim(SightingTime); //Level out sights over aim adjust time to stop the "shunt" effect

    if (!IsFiring() && !bNoTweenToScope)
        TweenAnim(IdleAnim, SightingTime);

    bForceReaim=true;

    if (NewLongGunFactor == 0)
        PlayScopeUp();
}

simulated function PlayCocking(optional byte Type)
{
    if(bScopeView) // Sight Fire Cock
        SafePlayAnim('SightCock', CockAnimRate, 0.2, , "RELOAD");
    else if (Type == 2 && HasAnim('ReloadEndCock'))
        PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
    else
        PlayAnim(CockAnim, CockAnimRate, 0.2);
}

defaultproperties
{
	 BeltBones(0)="Bullet10"
     BeltBones(1)="Bullet9"
     BeltBones(2)="Bullet8"
     BeltBones(3)="Bullet7"
     BeltBones(4)="Bullet6"
     BeltBones(5)="Bullet5"
     BeltBones(6)="Bullet4"
     BeltBones(7)="Bullet3"
     BeltBones(8)="Bullet2"
     BeltBones(9)="Bullet1"
     BoxOnSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOn')
     BoxOffSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOff')
     FlapUpSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapUp')
     FlapDownSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapDown')
     PlayerSpeedFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBPArchivePackTex.MG42.BigIcon_MGX4'
     SightFXClass=Class'BallisticDE.M353SightLEDs'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M353.M353-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M353.M353-Putaway')
     MagAmmo=60
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock')
     ReloadAnim="ReloadStart"
     ClipOutSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(1)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=1
     bNoTweenToScope=True
     bNoCrosshairInScope=True
     SightPivot=(Pitch=128)
     SightOffset=(X=10.000000,Y=16.129999,Z=11.600000)
     CrouchAimFactor=0.500000
     SprintOffSet=(Pitch=-3072,Yaw=-8192)
     AimAdjustTime=0.800000
     ViewAimFactor=0.200000
     ViewRecoilFactor=0.450000
     ChaosAimSpread=(X=(Min=-1500.000000,Max=1500.000000),Y=(Max=2048.000000))
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.000000
     RecoilXFactor=0.400000
     RecoilYFactor=0.400000
     RecoilMax=3000.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.MGA88PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.MGA88SecondaryFire'
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="MGA88 MachineGun"
     DisplayFOV=50.000000
     Priority=43
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBPArchivePackDE.MGA88Pickup'
     PlayerViewOffset=(X=5.000000,Z=-10.000000)
     BobDamping=1.400000
     AttachmentClass=Class'BWBPArchivePackDE.MGA88Attachment'
     IconMaterial=Texture'BWBPArchivePackTex.MG42.SmallIcon_MGX4'
     IconCoords=(X2=127,Y2=31)
     ItemName="MGA88 MachineGun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWXWeaponAnims.MGA88-FPm'
     DrawScale=0.680000
}
