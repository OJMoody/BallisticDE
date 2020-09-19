class JunkWeapon_Special extends JunkWeapon_RandGroup;

simulated function SpawnMyRandomJunk ()
{
	local array<string>			JunkNameList;
	local class<JunkObject>		JC;
	local int i, j, By;

	GetAllInt("JunkObject", JunkNameList);
	i = Rand(JunkNameList.length);
	JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
	if (!JC.default.bListed || JC.default.InventoryGroup < RandomJunkInventoryGroup || FindJunkOfClass(JC)!=None)
	{
		if (FRand() > 0.5)
			By = -1;
		Else
			By = 1;
		while(j < JunkNameList.length-1)
		{
			i = class'BUtil'.static.Loop(i, By, JunkNameList.length-1);
			JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
			if (JC.default.bListed && JC.default.InventoryGroup >= RandomJunkInventoryGroup && FindJunkOfClass(JC)==None)
				break;
			j++;
		}
	}
	GiveJunk(JC);
}

defaultproperties
{
     RandomJunkInventoryGroup=99
     BigIconMaterial=Texture'JunkWarUI.Icons.BigIcon_Capacitor'
     InventorySize=20
     SpecialInfo(0)=(Info="240.0;15.0;0.3;25.0;-999.0;-999.0;-999.0")
     IconMaterial=Texture'JunkWarUI.Icons.SmallIcon-Capacitor'
     ItemName="Random Junk - Special"
}
