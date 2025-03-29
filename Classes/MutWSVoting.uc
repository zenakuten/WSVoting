class MutWSVoting extends Mutator;

var WSVotingConfig Config;
var config bool bEnabled;

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

    if(bEnabled)
    {
        PC = PlayerController(Other);
        if(PC != None)
        {
            spawn(class'WSMapClient', PC);
        }
    }

    return true;
}

simulated function Tick(float DeltaTime)
{
    local PlayerController LocalPC;

    if (Level.NetMode == NM_DedicatedServer)
    {
        Disable('Tick');
        return;
    }

    if (LocalPC == None)
        LocalPC = Level.GetLocalPlayerController();

    if ( (LocalPC != None) && (LocalPC.Player != None) && (LocalPC.Player.InteractionMaster != None) )
    {
        LocalPC.Player.InteractionMaster.AddInteraction(string(Class'WSVotingInteraction'), LocalPC.Player);
        Disable('Tick');
    }
}

static function FillPlayInfo (PlayInfo PlayInfo)
{
    local byte weight;

	PlayInfo.AddClass(Default.Class);
    PlayInfo.AddSetting("WSVoting", "bEnabled", "Enable WSVoting", 0, weight++, "Check");
    PlayInfo.PopClass();

    super.FillPlayInfo(PlayInfo);
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "bEnabled": return "Check this to enable WSVoting";
    }

	return Super.GetDescriptionText(PropName);
}


defaultproperties
{
    bAddToServerPackages=true
    FriendlyName="WS Voting V6"
    Description="WS Voting V6"
    RemoteRole=ROLE_SimulatedProxy
    bAlwaysRelevant=true
    bEnabled=true
}