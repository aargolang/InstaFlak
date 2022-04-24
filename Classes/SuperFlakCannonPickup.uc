// class SuperFlakCannonPickup extends FlakCannonPickup;
class SuperFlakCannonPickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=InstaFlakTextures.utx

//===

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'InstaFlakTextures.skins.InstaFlakTex0');
    super.StaticPrecache(L);
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'InstaFlakTextures.skins.InstaFlakTex0');
	super.UpdatePrecacheMaterials();
}

defaultproperties
{
    MaxDesireability=0.750
    InventoryType=class'InstaFlak.SuperFlakCannon'
    PickupSound=Sound'PickupSounds.FlakCannonPickup'
    PickupForce="FlakCannonPickup"
    DrawType=8
    StaticMesh=StaticMesh'WeaponStaticMesh.FlakCannonPickup'
    DrawScale=0.550
}
