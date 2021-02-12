//=============================================================================
// BulldogAttachment.
//
// 3rd person weapon attachment for the Suzuki XL7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class PUGAttachment extends BallisticShotgunAttachment;
var() class<actor>			AltBrassClass1;			//Alternate Fire's brass
var() class<actor>			AltBrassClass2;			//Alternate Fire's brass (whole FRAG-12)

// Fling out shell casing
simulated function EjectBrass(byte Mode)
{
	local Rotator R;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (BrassMode == MU_None || (BrassMode == MU_Secondary && Mode == 0) || (BrassMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (Mode == 0)
		Spawn(BrassClass, self,, GetEjectorLocation(R), R);
	else if (Mode != 0)
		Spawn(AltBrassClass1, self,, GetEjectorLocation(R), R);
}

defaultproperties
{
     AltBrassClass1=Class'BWBP_SWC_Pro.Brass_FRAGSpent'
     AltBrassClass2=Class'BWBP_SWC_Pro.Brass_FRAG'
     FireClass=Class'BWBP_SWC_Pro.PUGPrimaryFire'
     MuzzleFlashClass=Class'BWBP_SWC_Pro.PUGFlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_SWC_Pro.PUGFlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     AltFlashBone="Tip2"
	 TracerMode=MU_Primary
	 PrePivot=(Z=2.000000)
	 FlashScale=0.200000
     BrassClass=Class'BWBP_SWC_Pro.Brass_BOLT'
     BrassMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BWBP_SWC_Pro.TraceEmitter_Flechette'
     Mesh=SkeletalMesh'BWBP_CC_Anim.PUG12_TPm'
     DrawScale=1.000000
}
