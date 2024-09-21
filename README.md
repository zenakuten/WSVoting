# WSVoting


WSVoting is a mutator to show a preview of the map during map voting.  Normally the preview only works if the player has the map downloaded.  This mutator uses a texture package to load screenshots from.

![image](Pics/Preview.png)


## Usage 

On the server, enable `WSVoting.MutWSVoting` mutator.  Add `WSVotingScreenshots.utx` to the Textures folder.  In your UT2004.ini, under ServerPackages, add `WSVotingScreenshots`, and any other Texture packages you reference.


## Config

WSVoting.ini
```
[WSVoting WSVotingConfig]
DefaultTexturePackage=WSVotingScreenshots
Maps=(MapName="Map Name",Texture="TexturePackage.TextureName")
```

The mutator will first look for a matching `Maps` line, where the MapName property matches the name of the map, e.g. `MapName="DM-Rankin"`.  If found, the `Texture` value will be used as the screenshot for that map. Using the `Maps` list allows using different texture packages for different maps. 

If no matching `Maps` line is found, the mutator will attempt to load the texture from the DefaultTexturePackage, looking for a Material with the same name as the map, e.g. `WSVotingScreenshots.DM-Rankin`.  

If no texture can be found, a 'No Preview Available' texture is used.


## Changes

V4 - Fix issue where GUI is still modified after server travel
   - Update texture package 
V3 - Add config to disable
   - Fix bug causing server lag 
V2 - support keyboard event for preview changes
   - update config to not reference package name (use perobjectconfig)
V1 - initial release


## Included screenshots

```
DM-1on1-Albatross
DM-1on1-Crash
DM-1on1-Desolation
DM-1on1-Idoma
DM-1on1-Irondust
DM-1on1-Mixer
DM-1on1-Roughinery
DM-1on1-Serpentine
DM-1on1-Spirit
DM-1on1-Squader
DM-1on1-Trite
DM-Antalus
DM-Asbestos
DM-BP2-Calandras
DM-BP2-GoopGod
DM-CBP1-Arkanos
DM-CBP1-AugustNoon
DM-CBP1-BlackJackal
DM-CBP1-Downgrave
DM-CBP1-Elegance
DM-CBP1-Emperor
DM-CBP1-Finale
DM-CBP1-GoldenDawn
DM-CBP1-Neandertalus
DM-CBP1-Ougaldwin
DM-CBP1-Shifter
DM-CBP2-Achilles
DM-CBP2-Archipelago
DM-CBP2-Azures
DM-CBP2-Buliwyf
DM-CBP2-Drakonis
DM-CBP2-Griffin
DM-CBP2-Kadath
DM-CBP2-Kerosene
DM-CBP2-Khrono
DM-CBP2-KillbillyBarn
DM-CBP2-Koma
DM-CBP2-KroujKran
DM-CBP2-Masurao
DM-CBP2-Meitak
DM-CBP2-Niflheim
DM-CBP2-Reconstruct
DM-CBP2-Summit
DM-CBP2-TelMecoMEX
DM-CBP2-Tempest
DM-CBP2-TensileSteel
DM-CBP2-Torkenstein
DM-CBP2-Tydal
DM-Compressed
DM-Corrugation
DM-Curse4
DM-DE-Grendelkeep
DM-DE-Ironic
DM-DE-Osiris2
DM-Deck17
DM-DesertIsle
DM-Flux2
DM-Forbidden
DM-Gael
DM-Gestalt
DM-Goliath
DM-HyperBlast2
DM-Icetomb
DM-Inferno
DM-Injector
DM-Insidious
DM-IronDeity
DM-Junkyard
DM-Leviathan
DM-Metallurgy
DM-Morpheus3
DM-Oceanic
DM-Phobos2
DM-Plunge
DM-Rankin
DM-Rrajigar
DM-Rustatorium
DM-Sulphur
DM-TokaraForest
DM-TrainingDay
DM-UCMP-1on1-Derelict
DM-UCMP-BloodRun
DM-UCMP-Contrast
DM-UCMP-ImMortalis
DM-UCMP-PleasantValley
DM-UCMP-RancidMetal
DM-UCMP-ThePits
DM-UCMP-Xanadu
DM-UCMP2-Adamantium
DM-UCMP2-Churn
DM-UCMP2-Dynarak
DM-UCMP2-Hieron
DM-UCMP2-Saiko
DM-UCMP2-Taron
DM-UCMP2-Thebes
DM-UCMP3-Altitude
DM-UCMP3-Gantham
DM-UCMP3-Glorian
DM-UCMP3-Sympathy
DM-UCMP4-Elucidation
DM-UCMP4-Mania
DM-UCMP4-Propaganda
DM-UCMP4-Speos
```
