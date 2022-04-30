//=============================================================================
// InstaFlak Muthafuckas!
//=============================================================================
class MutInstaFlak extends Mutator
	config (InstaFlakConfig);

var name WeaponName, AmmoName;
var string WeaponString, AmmoString;
var config int NumChunks;
var config int NumShells;
var config int NumShellChunks;
var config int ExplosionRadius;
var localized string GUIDisplayText[4];
var localized string GUIDescText[4];


//Defines display text
static function string GetDisplayText(string PropName)
{
	switch (PropName)
	{
		case "NumChunks": return default.GUIDisplayText[0];
		case "NumShells": return default.GUIDisplayText[1];
		case "NumShellChunks": return default.GUIDisplayText[2];
		case "ExplosionRadius": return default.GUIDisplayText[3];
	}
}

//Defines description text
static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "NumChunks": return default.GUIDescText[0];
		case "NumShells": return default.GUIDescText[1];
		case "NumSHellChunks": return default.GUIDescText[2];
		case "ExplosionRadius": return default.GUIDescText[3];
	}
}

//Adds config options to config window
static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.RulesGroup, "NumChunks", GetDisplayText("NumChunks"), 0, 0, "Text", "4;1:50");
	PlayInfo.AddSetting(default.RulesGroup, "NumShells", GetDisplayText("NumShells"), 0, 0, "Text", "4;1:10");
	PlayInfo.AddSetting(default.RulesGroup, "NumShellChunks", GetDisplayText("NumShellChunks"), 0, 0, "Text", "4;1:50");
	PlayInfo.AddSetting(default.RulesGroup, "ExplosionRadius", GetDisplayText("ExplosionRadius"), 0, 0, "Text", "4;0:500");
}


simulated function BeginPlay()
{
	local xPickupBase P;
	local Pickup L;

	foreach AllActors(class'xPickupBase', P)
	{
		P.bHidden = true;
		if (P.myEmitter != None)
			P.myEmitter.Destroy();
	}
	foreach AllActors(class'Pickup', L)
		if ( L.IsA('WeaponLocker') )
			L.GotoState('Disabled');

	Super.BeginPlay();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
}

function string RecommendCombo(string ComboName)
{
	if ( (ComboName != "xGame.ComboSpeed") && (ComboName != "xGame.ComboInvis") )
	{
		if ( FRand() < 0.65 )
			ComboName = "xGame.ComboInvis";
		else
			ComboName = "xGame.ComboSpeed";
	}

	return Super.RecommendCombo(ComboName);
}

function bool AlwaysKeep(Actor Other)
{
	if ( Other.IsA(WeaponName) || Other.IsA(AmmoName) )
	{
		if ( NextMutator != None )
			NextMutator.AlwaysKeep(Other);

		return true;
	}

	if ( NextMutator != None )
		return ( NextMutator.AlwaysKeep(Other) );
	return false;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if ( Other.IsA('Weapon') )
	{
        if ( Weapon(Other).bNoInstagibReplace )
        {
            bSuperRelevant = 0;
            return true;
        }

		if ( !Other.IsA(WeaponName) )
		{
			Level.Game.bWeaponStay = false;
			return false;
		}
	}

	if ( Other.IsA('Pickup') )
	{
		if ( Other.bStatic || Other.bNoDelete )
			Other.GotoState('Disabled');
		return false;
	}

	bSuperRelevant = 0;
	return true;
}


// Decompiled with UE Explorer.
defaultproperties
{
    WeaponName=SuperFlakCannon
    AmmoName=SuperFlakAmmo
    WeaponString="InstaFlak.SuperFlakCannon"
    AmmoString="InstaFlak.SuperFlakAmmo"
    DefaultWeaponName="InstaFlak.SuperFlakCannon"
    GroupName="InstaFlak"
    FriendlyName="InstaFlak"
    Description="Instagib with Flak Cannons!"
    bNetTemporary=true
    bAlwaysRelevant=true
    RemoteRole=2
	NumChunks=20
	NumShells=3
	NumShellChunks=30
	ExplosionRadius=300
	GUIDisplayText[0]="Chunks"
	GUIDisplayText[1]="Shells"
	GUIDisplayText[2]="Shell Chunks"
	GUIDisplayText[3]="Explosion Radius"
	GUIDescText[0]="Number of flaks for primary fire"
	GUIDescText[1]="Number of shells for secondary fire"
	GUIDescText[2]="Number of flaks from shell explosion"
	GUIDescText[3]="Radius of damage from shell explosion"
	bAddToServerPackages=True
}