class MI48Vert extends Decoration;

singular function BaseChange();

defaultproperties
{
     bStatic=False
     bStasis=False
     RemoteRole=ROLE_SimulatedProxy
     Mesh=SkeletalMesh'DKVehiclesAnim.MI48V'
     Skins(0)=Shader'DKVehiclesTex.MI48.MI48_A_S'
     Style=STY_Additive
     bShouldBaseAtStartup=False
     bHardAttach=True
     Mass=0.000000
}
