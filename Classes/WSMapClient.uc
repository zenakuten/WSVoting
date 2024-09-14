class WSMapClient extends Actor;

var PlayerController PCOwner;
var bool foundMenu, foundListBox;
var string CurrentMapTexture;
var MutWSVoting MutatorOwner;

replication
{
    reliable if(Role == ROLE_Authority)
        CurrentMapTexture, ResetGui;

    reliable if(Role < ROLE_Authority)
        ServerSelectMap;
}

auto simulated state startup
{
    simulated function Tick(float deltaTime)
    {
        local MapVoteMultiColumnListBox LB;
        local GUIController GUI;

        super.Tick(deltaTime);

        if(Level.NetMode == NM_DedicatedServer)
        {
            Disable('Tick');
            GotoState('BegunPlay');
        }

        foreach AllObjects(class'GUIController', GUI)
        {
            GUI.MapVotingMenu = string(class'WSMapVotingPage');
            foundMenu = true;
        }

        foreach AllObjects(class'MapVoteMultiColumnListBox', LB)
        {
            LB.DefaultListClass = string(class'WSMapVoteMultiColumnList');
            foundListBox = true;
        }

        if(foundMenu && foundListBox)
            GotoState('BegunPlay');
    }
}

simulated state BegunPlay
{
    ignores tick;
}

function PostBeginPlay()
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

simulated function ResetGui()
{
    local MapVoteMultiColumnListBox LB;
    local GUIController GUI;

    foreach AllObjects(class'GUIController', GUI)
    {
        GUI.MapVotingMenu = string(class'MapVotingPage');
    }

    foreach AllObjects(class'MapVoteMultiColumnListBox', LB)
    {
        LB.DefaultListClass = string(class'MapVoteMultiColumnList');
    }
}

defaultproperties
{
    bHidden=true
    DrawType=DT_None
    RemoteRole=ROLE_SimulatedProxy
}