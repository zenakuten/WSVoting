class WSMapVotingPage extends MapVotingPage;

defaultproperties
{
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
}
