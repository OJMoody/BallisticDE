class AlligatorVert extends Decoration;

singular function BaseChange();

defaultproperties
{
     bStatic=False
     bStasis=False
     RemoteRole=ROLE_SimulatedProxy
     Mesh=SkeletalMesh'DKVehiclesAnim.AlligatorVert'
     Skins(0)=Shader'DKVehiclesTex.Alligator.AlligatorB'
     Style=STY_Additive
     bShouldBaseAtStartup=False
     bHardAttach=True
     Mass=0.000000
}
