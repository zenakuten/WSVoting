class WSVotingConfig extends Object
    config(WSVoting);

struct MapSetting
{
    var string MapName;
    var string Texture;
};

var config string DefaultTexturePackage;
var config array<MapSetting> Maps;

defaultproperties
{
    DefaultTexturePackage="WSVotingScreenshots"
    Maps(0)=(MapName="Map Name",Texture="TexturePackage.TextureName")
}