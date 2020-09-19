class JWVan_PlayerDamager extends Actor;

var float Damage, DamageInterval;
var class<DamageType>	DamageType;
var array<Sound> Music

;function PostBeginPlay()
{
 if (Role == ROLE_Authority)
 {
  SetBase(Owner);
  SetTimer(DamageInterval, true);
  AmbientSound = Music[Rand(Music.Length)];
 }
}

function Timer()
{
	local Pawn Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Pawn', Victims, SoundRadius, Location)
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims != Owner) && (Victims.Role == ROLE_Authority))
		{
			dir = Victims.Location - Location;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/SoundRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * Damage,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				vect(0,0,0),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

defaultproperties
{
     Damage=8.000000
     DamageInterval=0.500000
     DamageType=Class'JWVanDE.DTplayer'
     Music(0)=Sound'jwvansound.rickastley'
     Music(1)=Sound'jwvansound.bibi'
     Music(2)=Sound'jwvansound.gangnam'
     Music(3)=Sound'jwvansound.ilikethatshit'
     Music(4)=Sound'jwvansound.whatislove'
     Music(5)=Sound'jwvansound.scatman'
     Music(6)=Sound'jwvansound.babo'
     Music(7)=Sound'jwvansound.tube'
     Music(8)=Sound'jwvansound.tunak'
     Music(9)=Sound'jwvansound.NEX.thriller'
     Music(10)=Sound'jwvansound.freak'
     Music(11)=Sound'jwvansound.chicken'
     bHidden=True
     bUpdateSimulatedPosition=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=16.000000
     bHardAttach=True
     SoundVolume=255
     SoundRadius=1024.000000
}
