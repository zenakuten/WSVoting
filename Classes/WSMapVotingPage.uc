class WSMapVotingPage extends MapVotingPage;

var WSMapClient ClientOwner;

function Cleanup()
{
    Controller.MapVotingMenu = string(class'MapVotingPage');
    Controller.ReplaceMenu(Controller.MapVotingMenu);
    Free();
}

function WSInternalOnOpen()
{
    local MutWSVoting Mut;

    foreach PlayerOwner().DynamicActors(class'MutWSVoting', Mut)
        break;

    if(default.ClientOwner != None && default.ClientOwner.Level.GetAddressURL() != PlayerOwner().Level.GetAddressURL() && Mut == None)
    {
        // we've changed servers and there is no mutator here, 
        // restore the old voting menu
        Cleanup();
    }
    else
    {
        // call base
        InternalOnOpen();
    }
}

defaultproperties
{
    ClientOwner=None
     Begin Object Class=WSMapVoteMultiColumnListBox Name=WSMapListBox
         HeaderColumnPerc(0)=0.300000
         HeaderColumnPerc(1)=0.200000
         HeaderColumnPerc(2)=0.200000
         HeaderColumnPerc(3)=0.300000
         bVisibleWhenEmpty=True
         OnCreateComponent=WSMapListBox.InternalOnCreateComponent
         StyleName="ServerBrowserGrid"
         WinTop=0.371020
         WinLeft=0.020000
         WinWidth=0.960000
         WinHeight=0.293104
         bBoundToParent=True
         bScaleToParent=True
         OnRightClick=WSMapListBox.InternalOnRightClick
     End Object
     lb_MapListBox=WSMapVoteMultiColumnListBox'WSVoting.WSMapVotingPage.WSMapListBox'
     OnOpen=WSMapVotingPage.WSInternalOnOpen
}
