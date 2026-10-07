class WSVotingInteraction extends Interaction;

var bool bModifiedMenu;

event NotifyLevelChange()
{
    RestoreMenu();
    Master.RemoveInteraction(self);
}

function ModifyMenu()
{
    local MapVoteMultiColumnListBox LB;
    local MapVoteCountMultiColumnListBox LBVoteCount;

    foreach AllObjects(class'MapVoteMultiColumnListBox', LB)
    {
        LB.DefaultListClass = string(class'WSMapVoteMultiColumnList');
    }

    foreach AllObjects(class'MapVoteCountMultiColumnListBox', LBVoteCount)
    {
        LBVoteCount.DefaultListClass = string(class'WSMapVoteCountMultiColumnList');
    }

    bModifiedMenu=true;
}

function RestoreMenu()
{
    local MapVoteMultiColumnListBox LB;
    local MapVoteCountMultiColumnListBox LBVoteCount;

    foreach AllObjects(class'MapVoteMultiColumnListBox', LB)
    {
        LB.DefaultListClass = string(class'MapVoteMultiColumnList');
    }

    foreach AllObjects(class'MapVoteCountMultiColumnListBox', LBVoteCount)
    {
        LBVoteCount.DefaultListClass = string(class'MapVoteCountMultiColumnList');
    }
}

// Older versions changed GUIController.MapVotingMenu, which could get saved to User.ini and break
// voting on servers without WSVoting. Put the stock page back in the ini if we find it there.
function FixSavedVotingMenu()
{
    local GUIController GUI;

    if (ViewportOwner == None)
        return;

    GUI = GUIController(ViewportOwner.GUIController);
    if (GUI != None && GUI.MapVotingMenu ~= string(class'WSMapVotingPage'))
    {
        ConsoleCommand("set" @ string(GUI.Class) @ "MapVotingMenu" @ string(class'MapVotingPage'));
    }
}

// Swap the stock voting page for ours once it opens. GUIController.MapVotingMenu is a
// config(User) var, so changing it can get saved to User.ini and break voting on other servers.
function ReplaceVotingPage()
{
    local GUIController GUI;

    if (ViewportOwner == None)
        return;

    GUI = GUIController(ViewportOwner.GUIController);
    if (GUI != None && GUI.ActivePage != None && GUI.ActivePage.Class == class'MapVotingPage')
    {
        GUI.ReplaceMenu(string(class'WSMapVotingPage'));
    }
}

function Tick (float DeltaTime)
{
    if (!bModifiedMenu)
    {
        FixSavedVotingMenu();
        ModifyMenu();
    }

    ReplaceVotingPage();
}

defaultproperties
{
    bRequiresTick=true
}