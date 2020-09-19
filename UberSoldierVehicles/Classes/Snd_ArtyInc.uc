class Snd_ArtyInc extends ONSIncomingShellSound;


function StartTimer(float TimeToImpact)
{
	if (TimeToImpact > SoundLength)
		SetTimer(TimeToImpact - SoundLength, false);
	else
		Destroy();
}

defaultproperties
{
     SoundLength=3.500000
     Physics=PHYS_Trailer
     AmbientSound=SoundGroup'DKoppIISound.Incoming.ArtyShellInc'
     SoundVolume=255
     SoundRadius=5000.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=5000.000000
}
