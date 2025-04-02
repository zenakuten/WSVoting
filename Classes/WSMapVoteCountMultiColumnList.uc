
// listbox of maps currently voted for
class WSMapVoteCountMultiColumnList extends MapVoteCountMultiColumnList;

#exec Texture Import File=Textures\NoPreview.tga

var Material Screenshot, NoPreviewTexture;
var string TexturePackage;
var WSMapClient MapClient;
var string LastTexture, CurrentTexture;
var int tickcount;

function InternalOnChange(GUIComponent Sender)
{
    local string mapName;

    if(MapClient == None)
        foreach PlayerOwner().ChildActors(class'WSMapClient', MapClient)
            break;
    
    if(MapClient != None)
    {
        mapName = GetSelectedMapName();
        MapClient.ServerVoteMap(Index, mapName);
        ColumnHeadings[3] = mapName;
    }
}

function bool InternalOnClick(GUIComponent sender)
{
    local string mapName;
    local bool clicked;
    clicked = super.InternalOnClick(sender);
    if(clicked)
    {
        if(MapClient == None)
            foreach PlayerOwner().ChildActors(class'WSMapClient', MapClient)
                break;
        
        if(MapClient != None)
        {
            mapName = GetSelectedMapName();
            MapClient.ServerVoteMap(Index, mapName);
            ColumnHeadings[3] = mapName;
        }
    }

    return clicked;
}

function InternalOnRendered(Canvas C)
{
    local float CellLeft, CellWidth;
    local int UL, VL;

    if(MapClient == None)
        foreach PlayerOwner().ChildActors(class'WSMapClient', MapClient)
            break;
    
    if(MapClient != None)
    {
        CurrentTexture=MapClient.CurrentVoteMapTexture;
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

        C.Reset();
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
     ColumnHeadings(0)="Game Type"
     ColumnHeadings(1)="Map Name"
     ColumnHeadings(2)="Votes"
     ColumnHeadings(3)="Preview"
     InitColumnPerc(0)=0.200000
     InitColumnPerc(1)=0.400000
     InitColumnPerc(2)=0.100000
     InitColumnPerc(3)=0.300000
     ColumnHeadingHints(0)="Game Type"
     ColumnHeadingHints(1)="Map Name"
     ColumnHeadingHints(2)="Votes"
     ColumnHeadingHints(3)="Preview"
     SelectedStyleName="BrowserListSelection"
     StyleName="ServerBrowserGrid"
     OnRendered=InternalOnRendered
     OnChange=InternalOnChange

    NoPreviewTexture=Texture'NoPreview'
    TexturePackage="WSVotingScreenshots"
}