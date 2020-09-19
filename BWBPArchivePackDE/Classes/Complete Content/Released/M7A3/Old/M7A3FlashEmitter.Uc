//=============================================================================
// XK2FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
//	if (WeaponAttachment(Owner) != None)
	if (Weapon(Owner) == None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Emitters(0)=MeshEmitter'BallisticDE.XK2FlashEmitter.MeshEmitter4'

     Emitters(1)=SpriteEmitter'BallisticDE.XK2FlashEmitter.SpriteEmitter5'

}
