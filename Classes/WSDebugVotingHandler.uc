// this only exists for testing
// set [Engine.GameInfo] VotingHandlerType
// with 1 player it is hard to vote without winning vote :)
class WSDebugVotingHandler extends xVotingHandler;

function TallyVotes(bool bForceMapSwitch)
{
	local int        index,x,y,topmap,r,mapidx,gameidx;
	local array<int> VoteCount;
	local array<int> Ranking;
	local int        PlayersThatVoted;
	local int        TieCount;
	local string     CurrentMap;
	local int        Votes;
	//local MapHistoryInfo MapInfo;

	if(bLevelSwitchPending)
		return;

	PlayersThatVoted = 0;
	VoteCount.Length = GameConfig.Length * MapCount;
	// note: VoteCount array is a 2 dimension array VoteCount[GameConfigIndex, MapIndex]
	//       Maps ->
	//       0 1 2 3 4 5 6 7 8
	// G     - - - - - - - - -
	// a  0 |0 0 0 0 0 0 0 2 0
	// m  1 |0 0 0 2 0 0 0 0 0
	// e  2 |0 6 0 0 0 5 0 0 0
	// s  3 |0 0 0 3 0 0 0 0 0

	for(x=0;x < MVRI.Length;x++) // for each player
	{
		if(MVRI[x] != none && MVRI[x].MapVote > -1 && MVRI[x].GameVote > -1) // if this player has voted
		{
			PlayersThatVoted++;

			if(bScoreMode)
			{
				if(bAccumulationMode)
					Votes = GetAccVote(MVRI[x].PlayerOwner) + int(GetPlayerScore(MVRI[x].PlayerOwner));
				else
					Votes = int(GetPlayerScore(MVRI[x].PlayerOwner));
			}
			else
			{  // Not Score Mode == Majority (one vote per player)
				if(bAccumulationMode)
					Votes = GetAccVote(MVRI[x].PlayerOwner) + 1;
				else
					Votes = 1;
			}
			VoteCount[MVRI[x].GameVote * MapCount + MVRI[x].MapVote] = VoteCount[MVRI[x].GameVote * MapCount + MVRI[x].MapVote] + Votes;

			if(!bScoreMode)
			{
				// If more then half the players voted for the same map as this player then force a winner
				if(Level.Game.NumPlayers > 2 && float(VoteCount[MVRI[x].GameVote * MapCount + MVRI[x].MapVote]) / float(Level.Game.NumPlayers) > 0.5 && Level.Game.bGameEnded)
					bForceMapSwitch = true;
			}
		}
	}
	log("___Voted - " $ PlayersThatVoted,'MapVoteDebug');

	if(Level.Game.NumPlayers > 2 && !Level.Game.bGameEnded && !bMidGameVote && (float(PlayersThatVoted) / float(Level.Game.NumPlayers)) * 100 >= MidGameVotePercent) // Mid game vote initiated
	{
		Level.Game.Broadcast(self,lmsgMidGameVote);
		bMidGameVote = true;
		// Start voting count-down timer
		TimeLeft = VoteTimeLimit;
		ScoreBoardTime = 1;
		settimer(1,true);
	}

	index = 0;
	for(x=0;x < VoteCount.Length;x++) // for each map
	{
		if(VoteCount[x] > 0)
		{
			Ranking.Insert(index,1);
			Ranking[index++] = x; // copy all vote indexes to the ranking list if someone has voted for it.
		}
	}

	if(PlayersThatVoted > 1)
	{
		// bubble sort ranking list by vote count
		for(x=0; x<index-1; x++)
		{
			for(y=x+1; y<index; y++)
			{
				if(VoteCount[Ranking[x]] < VoteCount[Ranking[y]])
				{
				topmap = Ranking[x];
				Ranking[x] = Ranking[y];
				Ranking[y] = topmap;
				}
			}
		}
	}
	else
	{
		if(PlayersThatVoted == 0)
		{
			GetDefaultMap(mapidx, gameidx);
			topmap = gameidx * MapCount + mapidx;
		}
		else
			topmap = Ranking[0];  // only one player voted
	}

	//Check for a tie
	if(PlayersThatVoted > 1) // need more than one player vote for a tie
	{
		if(index > 1 && VoteCount[Ranking[0]] == VoteCount[Ranking[1]] && VoteCount[Ranking[0]] != 0)
		{
			TieCount = 1;
			for(x=1; x<index; x++)
			{
				if(VoteCount[Ranking[0]] == VoteCount[Ranking[x]])
				TieCount++;
			}
			//reminder ---> int Rand( int Max ); Returns a random number from 0 to Max-1.
			topmap = Ranking[Rand(TieCount)];

			// Don't allow same map to be choosen
			CurrentMap = GetURLMap();

			r = 0;
			while(MapList[topmap - (topmap/MapCount) * MapCount].MapName ~= CurrentMap)
			{
				topmap = Ranking[Rand(TieCount)];
				if(r++>100)
					break;  // just incase
			}
		}
		else
		{
			topmap = Ranking[0];
		}
	}

    /*
	// if everyone has voted go ahead and change map
	if(bForceMapSwitch || (Level.Game.NumPlayers == PlayersThatVoted && Level.Game.NumPlayers > 0) )
	{
		if(MapList[topmap - topmap/MapCount * MapCount].MapName == "")
			return;

		TextMessage = lmsgMapWon;
		TextMessage = repl(TextMessage,"%mapname%",MapList[topmap - topmap/MapCount * MapCount].MapName $ "(" $ GameConfig[topmap/MapCount].Acronym $ ")");
		Level.Game.Broadcast(self,TextMessage);

		CloseAllVoteWindows();

		MapInfo = History.PlayMap(MapList[topmap - topmap/MapCount * MapCount].MapName);

		ServerTravelString = SetupGameMap(MapList[topmap - topmap/MapCount * MapCount], topmap/MapCount, MapInfo);
		log("ServerTravelString = " $ ServerTravelString ,'MapVoteDebug');

		History.Save();

		if(bEliminationMode)
			RepeatLimit++;

		if(bAccumulationMode)
			SaveAccVotes(topmap - topmap/MapCount * MapCount, topmap/MapCount);

		//if(bEliminationMode || bAccumulationMode)
		CurrentGameConfig = topmap/MapCount;
		if( !bAutoDetectMode )
			SaveConfig();

		bLevelSwitchPending = true;
		settimer(Level.TimeDilation,true);  // timer() will monitor the server-travel and detect a failure

		Level.ServerTravel(ServerTravelString, false);    // change the map
	}
    */
}

defaultproperties
{
}