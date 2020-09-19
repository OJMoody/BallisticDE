//=============================================================================
// A909Attachment.
//
// 3rd person weapon attachment for A909 Skrith Blades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class N3XPlazAttachment extends BallisticMeleeAttachment;

var() Sound DischargeSound;										// Sound of water discharge
var bool bPulse, bShock, bOldPulse, bOldShock;				// toggled to do pulse and shocks on clients

replication
{
	reliable if (Role == ROLE_Authority)
		bPulse, bShock;
}

simulated function DoWave(bool bIsShock)
{
	if (Level.NetMode == NM_DedicatedServer)
	{
		if (bIsShock)
			bShock = !bShock;
		else bPulse = !bPulse;
	}
	
	else if (bIsShock)
		DoShockWave();
	else DoPulseWave();
}

simulated function PostNetReceive()
{
	Super.PostNetReceive();
	
	if (bPulse != bOldPulse)
	{
		bOldPulse = bPulse;
		DoPulseWave();
	}
	
	else if (bShock != bOldShock)
	{
		bOldShock = bShock;
		DoShockWave();
	}
}

simulated function DoPulseWave()
{
	spawn(class'IE_N3XDischarge', Instigator,, Instigator.Location);
}

simulated function DoShockWave()
{
	spawn(class'IE_N3XDischarge', Instigator,, Instigator.Location);
	Instigator.PlaySound(DischargeSound, SLOT_None, 1.8, , 192, 1.0 , false);
}

defaultproperties
{
     DischargeSound=Sound'BWBP2-Sounds.LightningGun.LG-WaterDischarge'
     MeleeAltStrikeAnim="Punchies_UppercutRight"
     ImpactManager=Class'BallisticDE.IM_MRS138TazerHit'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
	 AmbientSound=Sound'PackageSounds4.NEX.NEX-Idle'
	 Mesh=SkeletalMesh'BWBPArchivePack1Anim.3RD-NEX'
     DrawScale=0.130000
	 bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
     TransientSoundVolume=2.000000
     TransientSoundRadius=256.000000
}
