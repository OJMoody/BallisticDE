//=============================================================================
// MGA88Attachment.
//
// 3rd person weapon attachment for MGA88 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGA88Attachment extends BallisticAttachment;

simulated Event PostNetBeginPlay()
{
    super.PostNetBeginPlay();
    if (BallisticTurret(Instigator) != None)
        bHidden=true;
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;

    if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
        C = Instigator.Weapon.GetBoneCoords('tip');
    else if (BallisticTurret(Instigator) != None)
        C = Instigator.GetBoneCoords('tip');
    else
        C = GetBoneCoords('tip');
    if (Instigator != None && VSize(C.Origin - Instigator.Location) > 250)
        return Instigator.Location;
    return C.Origin;
}
// Return location of brass ejector
simulated function Vector GetEjectorLocation(optional out Rotator EjectorAngle)
{
    local Coords C;
    if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
        C = Instigator.Weapon.GetBoneCoords(BrassBone);
    else if (BallisticTurret(Instigator) != None)
        C = Instigator.GetBoneCoords(BrassBone);
    else
        C = GetBoneCoords(BrassBone);
    if (Instigator != None && VSize(C.Origin - Instigator.Location) > 200)
    {
        EjectorAngle = Instigator.Rotation;
        return Instigator.Location;
    }
    if (BallisticTurret(Instigator) != None)
        EjectorAngle = Instigator.GetBoneRotation(BrassBone);
    else
        EjectorAngle = GetBoneRotation(BrassBone);
    return C.Origin;
}

simulated function FlashMuzzleFlash(byte Mode)
{
    local rotator R;

    if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
        return;
    if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
        return;

    if (Mode != 0 && AltMuzzleFlashClass != None)
    {
        if (AltMuzzleFlash == None)
        {
            if (BallisticTurret(Instigator) != None)
                class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*1.666, Instigator, AltFlashBone);
            else
                class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
        }
        AltMuzzleFlash.Trigger(self, Instigator);
        if (bRandomFlashRoll)   SetBoneRotation(AltFlashBone, R, 0, 1.f);
    }
    else if (Mode == 0 && MuzzleFlashClass != None)
    {
        if (MuzzleFlash == None)
        {
            if (BallisticTurret(Instigator) != None)
                class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*1.666, Instigator, FlashBone);
            else
                class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
        }
        MuzzleFlash.Trigger(self, Instigator);
        if (bRandomFlashRoll)   SetBoneRotation(FlashBone, R, 0, 1.f);
    }
}
simulated function PlayPawnFiring(byte Mode)
{
    if ( xPawn(Instigator) == None )
        return;

    if (FiringMode != 1)
    {
        if (TrackAnimMode == MU_Both || (TrackAnimMode == MU_Primary && Mode == 0) || (TrackAnimMode == MU_Secondary && Mode != 0))
            PlayPawnTrackAnim(Mode);
        else
        {
            if (FiringMode == 0)
            {
                PlayAnim('Fire');

                if (bIsAimed)
                    xPawn(Instigator).StartFiring(False, bRapidFire);
                else
                    xPawn(Instigator).StartFiring(True, bRapidFire);
            }
            else
            {
                if (bIsAimed)
                    xPawn(Instigator).StartFiring(False, bAltRapidFire);
                else
                    xPawn(Instigator).StartFiring(True, bAltRapidFire);
            }
                SetTimer(WeaponLightTime, false);
        }
    }else
    {
        Instigator.SetAnimAction('Melee_Smack');
    }
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticDE.M353FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     BrassClass=Class'BallisticDE.Brass_MG'
     TracerClass=Class'BallisticDE.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_MG"
     CockingAnim="Cock_RearPull"
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWXWeaponAnims.MGA88-3rdm'
     RelativeLocation=(X=3.000000,Y=-5.000000,Z=-8.000000)
     DrawScale=1.300000
}
