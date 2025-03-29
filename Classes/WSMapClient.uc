// this runs on server and client so that when client selects a map,
// server response with texture name
class WSMapClient extends Actor;

var bool foundMenu, foundListBox;
var string CurrentMapTexture, CurrentVoteMapTexture;
var MutWSVoting MutatorOwner;

replication
{
    reliable if(Role == ROLE_Authority)
        CurrentMapTexture, CurrentVoteMapTexture;

    reliable if(Role < ROLE_Authority)
        ServerSelectMap, ServerVoteMap;
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if(MutatorOwner == None)
        foreach DynamicActors(class'MutWSVoting', MutatorOwner)
            break;
}

function ServerSelectMap(int index, string mapName)
{
    local WSVotingConfig Config;
    local int i;
    if(MutatorOwner != none)
    {
        Config = MutatorOwner.Config;
    }

    if(Config == None)
        return;

    CurrentMapTexture = "";
    for(i=0;i<Config.Maps.Length;i++)
    {
        if(Config.Maps[i].MapName ~= mapName)
            CurrentMapTexture = Config.Maps[i].Texture;
    }

    if(CurrentMapTexture == "")
        CurrentMapTexture = Config.DefaultTexturePackage$"."$mapName;
}

function ServerVoteMap(int index, string mapName)
{
    local WSVotingConfig Config;
    local int i;
    if(MutatorOwner != none)
    {
        Config = MutatorOwner.Config;
    }

    if(Config == None)
        return;

    CurrentVoteMapTexture = "";
    for(i=0;i<Config.Maps.Length;i++)
    {
        if(Config.Maps[i].MapName ~= mapName)
            CurrentVoteMapTexture = Config.Maps[i].Texture;
    }

    if(CurrentVoteMapTexture == "")
        CurrentVoteMapTexture = Config.DefaultTexturePackage$"."$mapName;
}

defaultproperties
{
    bHidden=true
    DrawType=DT_None
    RemoteRole=ROLE_SimulatedProxy
    bUpdateSimulatedPosition=false
    bAlwaysRelevant=true
}