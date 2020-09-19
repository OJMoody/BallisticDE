//=============================================================================
// VSKttachment.
//
// 3rd person weapon attachment for VSK Tranquilizer Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class VSKAttachment extends BallisticAttachment;

simulated function Vector GetTipLocation()
{
    local Coords C;
    local Vector X, Y, Z;

	if (Instigator.IsFirstPerson())
	{
		if (VSKTranqRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			C = Instigator.Weapon.GetBoneCoords('tip');
	}
	else
		C = GetBoneCoords('tip');
    return C.Origin;
}

defaultproperties
{
	 RelativeLocation=(X=20.000000,Z=25.000000)
	 RelativeRotation=(Pitch=32768)
     MuzzleFlashClass=Class'BWBPAnotherPackDE.VSKSilencedFlash'
     ImpactManager=Class'BWBPAnotherPackDE.IM_Tranq'
     FlashScale=0.300000
     BrassClass=Class'BWBPAnotherPackDE.Brass_Tranq'
     TracerClass=Class'BWBPAnotherPackDE.TraceEmitter_Tranq'
     TracerMix=0
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBPAnotherPackAnims.552Commando_TPm'
     DrawScale=1.000000
}
