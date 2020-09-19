class ParticleStreamEffectNewAlt extends ParticleStreamEffectNew;

#exec OBJ LOAD FILE=BWBPOtherPackTex4.utx

simulated function SetColor()
{
	if (!bAltColor)
	{
		Skins[0] = TexPanner'BWBPOtherPackTex4.ProtonPack.ProtonGreenPanner';
	}
	else
	{
		Skins[0] = TexPanner'BWBPOtherPackTex4.ProtonPack.ProtonPurplePanner';
	}
}

defaultproperties
{
     Skins(0)=TexPanner'BWBPOtherPackTex4.ProtonPack.ProtonGreenPanner'
}
