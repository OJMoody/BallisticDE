//=============================================================================
// IM_ShellHE.
//
// ImpactManager subclass for shotgun impacts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ShellHE extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(1)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(2)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(3)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(4)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(5)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(8)=Class'BWBPArchivePackDE.IE_ShellHE'
     HitEffects(9)=Class'BallisticDE.IE_ShellWater'
     HitEffects(10)=Class'BallisticDE.IE_BulletGlass'
     HitDecals(0)=Class'BallisticDE.AD_ShellConcrete'
     HitDecals(1)=Class'BallisticDE.AD_ShellConcrete'
     HitDecals(3)=Class'BallisticDE.AD_ShellMetal'
     HitDecals(4)=Class'BallisticDE.AD_ShellWood'
     HitDecals(5)=Class'BallisticDE.AD_ShellConcrete'
     HitDecals(6)=Class'BallisticDE.AD_ShellConcrete'
     HitDecals(7)=Class'BallisticDE.AD_ShellConcrete'
     HitDecals(10)=Class'BallisticDE.AD_ShellConcrete'
     HitSounds(0)=Sound'PackageSounds4Pro.Bulldog.Bulldog-Impact'
     HitSoundVolume=0.100000
     HitDelay=0.080000
}
