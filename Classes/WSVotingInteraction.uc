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
    local GUIController GUI;

    foreach AllObjects(class'GUIController', GUI)
    {
        GUI.MapVotingMenu = string(class'WSMapVotingPage');
    }

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
    local GUIController GUI;

    foreach AllObjects(class'MapVoteMultiColumnListBox', LB)
    {
        LB.DefaultListClass = string(class'MapVoteMultiColumnList');
    }

    foreach AllObjects(class'MapVoteCountMultiColumnListBox', LBVoteCount)
    {
        LBVoteCount.DefaultListClass = string(class'MapVoteCountMultiColumnList');
    }

    foreach AllObjects(class'GUIController', GUI)
    {
        GUI.MapVotingMenu = string(class'MapVotingPage');
    }
}

function Tick (float DeltaTime)
{
    if (!bModifiedMenu)
    {
        ModifyMenu();
    }
}

defaultproperties
{
    bRequiresTick=true
}