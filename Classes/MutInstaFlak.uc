//=============================================================================
// InstaFlak Muthafuckas!
//=============================================================================
class MutInstaFlak extends Mutator
	config (InstaFlakConfig);

var name WeaponName, AmmoName;
var string WeaponString, AmmoString;
var config int NumChunks;
var config int NumShells;
var localized string GUIDisplayText[2];
var localized string GUIDescText[2];

// var config bool bAllowTranslocator;
// var config bool bAllowBoost;
// var localized string TranslocDisplayText, BoostDisplayText, TranslocDescText, BoostDescText;

//Defines display text
static function string GetDisplayText(string PropName)
{
	switch (PropName)
	{
		case "NumChunks": return default.GUIDisplayText[0];
		case "NumShells": return default.GUIDisplayText[1];
	}
	//return Super.GetDisplayText(PropName);
}

//Defines description text
static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "NumChunks": return default.GUIDescText[0];
		case "NumShells": return default.GUIDescText[1];
	}
	//return Super.GetDescriptionText(PropName);
}

//Adds config options to config window
static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.RulesGroup, "NumChunks", GetDisplayText("NumChunks"), 0,0,"Text");
	PlayInfo.AddSetting(default.RulesGroup, "NumShells", GetDisplayText("NumShells"), 0,0,"Text");
}


// static function FillPlayInfo(PlayInfo PlayInfo)
// {
// 	Super.FillPlayInfo(PlayInfo);

// 	PlayInfo.AddSetting(default.RulesGroup, "bAllowTranslocator", default.TranslocDisplayText, 0, 1, "Check");
// 	PlayInfo.AddSetting(default.RulesGroup, "bAllowBoost", default.BoostDisplayText, 0, 1, "Check");
// }

// static event string GetDescriptionText(string PropName)
// {
// 	switch (PropName)
// 	{
// 		case "bAllowTranslocator":	return default.TranslocDescText;
// 		case "bAllowBoost":			return default.BoostDescText;
// 	}

// 	return Super.GetDescriptionText(PropName);
// }

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
	// if ( bAllowBoost && (TeamGame(Level.Game) != None) )
	// 	TeamGame(Level.Game).TeammateBoost = 1.0;
	// if ( bAllowTranslocator )
	// 	DeathMatch(Level.Game).bOverrideTranslocator = true;
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

		// if ( Other.IsA('TransLauncher') && bAllowTranslocator )
		// {
        //     bSuperRelevant = 0;
        //     return true;
        // }

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
    // TranslocDisplayText="Allow Translocator"
    // BoostDisplayText="Allow Teammate boosting"
    // TranslocDescText="Players get a Translocator in their inventory."
    // BoostDescText="Teammates get a big boost when shot by the instagib cannon."
    DefaultWeaponName="InstaFlak.SuperFlakCannon"
    GroupName="InstaFlak"
    FriendlyName="InstaFlak"
    Description="Instagib with Flak Cannons!"
    bNetTemporary=true
    bAlwaysRelevant=true
    RemoteRole=2
	NumChunks=20
	NumShells=3
	GUIDisplayText[0]="Chunks"
	GUIDisplayText[1]="Shells"
	GUIDescText[0]="Number of flaks for primary fire"
	GUIDescText[1]="Number of shells for secondary fire"
}