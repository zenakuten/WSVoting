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
    FriendlyName="WS Voting V5"
    Description="WS Voting V5"
    RemoteRole=ROLE_SimulatedProxy
    bEnabled=true
}