class WSMapVoteMultiColumnList extends MapVoteMultiColumnList;

#exec Texture Import File=Textures\NoPreview.tga

var Material Screenshot, NoPreviewTexture;
var string TexturePackage;
var WSMapClient MapClient;
var string LastTexture, CurrentTexture;

function bool InternalOnClick(GUIComponent Sender)
{
    local string mapName;
    local bool retval;

    retval = super.InternalOnClick(Sender);

    if(MapClient == None)
        foreach PlayerOwner().ChildActors(class'WSMapClient', MapClient)
            break;
    
    if(MapClient != None)
    {
        mapName = GetSelectedMapName();
        MapClient.ServerSelectMap(Index, mapName);
    }

    return retval;
}

function InternalOnRendered(Canvas C)
{
    local float CellLeft, CellWidth;
    local int UL, VL;

    super.OnRendered(C);
    
    if(MapClient == None)
        foreach PlayerOwner().ChildActors(class'WSMapClient', MapClient)
            break;
    
    if(MapClient != None)
    {
        CurrentTexture=MapClient.CurrentMapTexture;
    }

    if(CurrentTexture != "" && LastTexture != CurrentTexture)
    {
        Screenshot = Material(DynamicLoadObject(CurrentTexture, class'Material', true));
        LastTexture = CurrentTexture;
    }

    if(Index != -1)
    {
        if(Screenshot == None)
            Screenshot = NoPreviewTexture;

        UL = Screenshot.MaterialUSize();
        VL = Screenshot.MaterialVSize();

        GetCellLeftWidth( 3, CellLeft, CellWidth );
        C.SetPos(CellLeft, WinTop);
        C.ColorModulate.X=255;
        C.ColorModulate.Y=255;
        C.ColorModulate.Z=255;
        C.ColorModulate.W=255;
        C.SetDrawColor(255,255,255,255);
        C.DrawTile( Screenshot, CellWidth, WinHeight,0,0,UL,VL);
    }
}

defaultproperties
{
     ColumnHeadings(0)="Map Name"
     ColumnHeadings(1)="Played"
     ColumnHeadings(2)="Seq"
     ColumnHeadings(3)="Preview"
     InitColumnPerc(0)=0.300000
     InitColumnPerc(1)=0.200000
     InitColumnPerc(2)=0.200000
     InitColumnPerc(3)=0.300000
     ColumnHeadingHints(0)="Map Name"
     ColumnHeadingHints(1)="Number of times the map has been played."
     ColumnHeadingHints(2)="Sequence, The number of games that have been played since this map was last played."
     ColumnHeadingHints(3)="Preview"
     SelectedStyleName="BrowserListSelection"
     StyleName="ServerBrowserGrid"
     OnRendered=InternalOnRendered
     OnClick=InternalOnClick

    NoPreviewTexture=Texture'NoPreview'
    TexturePackage="WSVotingScreenshots"
}