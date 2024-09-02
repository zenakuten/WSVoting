class WSMapVoteMultiColumnListBox extends MapVoteMultiColumnListBox;

function LoadList(VotingReplicationInfo LoadVRI)
{
	local int i,g;
    local class<MapVoteMultiColumnList> mapVoteClass;

	ListArray.Length = LoadVRI.GameConfig.Length;
	for( i=0; i<LoadVRI.GameConfig.Length; i++)
	{
        //wtf why was this hardcoded
		//ListArray[i] = new class'MapVoteMultiColumnList';

		mapVoteClass = class<MapVoteMultiColumnList>(DynamicLoadObject(DefaultListClass, class'Class'));
		ListArray[i] = new mapVoteClass;
		ListArray[i].LoadList(LoadVRI,i);
		if( LoadVRI.GameConfig[i].GameClass ~= PlayerOwner().GameReplicationInfo.GameClass )
			g = i;
	}
	ChangeGameType(g);
}

defaultproperties
{
}