class SuperFlakCannon extends FlakCannon;

defaultproperties
{
     Mesh=mesh'InstaFlak.Flak_1st'
     CustomCrossHairColor=(R=255,G=0,B=255,A=255)
     FireModeClass[0]=Class'InstaFlak.SuperFlakFire'
     FireModeClass[1]=Class'InstaFlak.SuperFlakAltFire'
     bCanThrow=false
     PickupClass=Class'InstaFlak.SuperFlakCannonPickup'
}