class ParticleStreamEffectChildAlt extends ParticleStreamEffectChild;

#exec OBJ LOAD FILE=BWBPOtherPackTex4.utx

simulated function SetColor()
{
	if (!bAltColor)
	{
		Skins[0] = TexPanner'BWBPOtherPackTex4.ProtonPack.ProtonPurplePanner';
	}
	else
	{
		Skins[0] = TexPanner'BWBPOtherPackTex4.ProtonPack.ProtonGreenPanner';
	}	
}

defaultproperties
{
     Skins(0)=TexPanner'BWBPOtherPackTex4.ProtonPack.ProtonPurplePanner'
}
