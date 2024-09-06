class MutWSVoting extends Mutator;

var WSVotingConfig Config;

function PostBeginPlay()
{
    super.PostBeginPlay();

    foreach AllObjects(class'WSVotingConfig', Config)
        break;

    if(Config == None)
    {
        Config = new(None, "WSVoting") class'WSVotingConfig';
        Config.SaveConfig();
    }
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    local PlayerController PC;
    PC = PlayerController(Other);
    if(PC != None)
    {
        spawn(class'WSMapClient', PC);
    }

    if(NextMutator != None)
        return NextMutator.CheckReplacement(Other, bSuperRelevant);

    return true;
}

defaultproperties
{
    bAddToServerPackages=true
    FriendlyName="WS Voting"
    Description="WS Voting"
    RemoteRole=ROLE_SimulatedProxy
}