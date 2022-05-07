class SuperFlakCannon extends FlakCannon;

//maybe copy contents of flakcannon for networking?

defaultproperties
{
     ItemName="Super Flak Cannon"
     Mesh=mesh'InstaFlak.Flak_1st'
     CustomCrossHairColor=(R=255,G=0,B=255,A=255)
     FireModeClass[0]=Class'InstaFlak.SuperFlakFire'
     FireModeClass[1]=Class'InstaFlak.SuperFlakAltFire'
     bCanThrow=false
     PickupClass=Class'InstaFlak.SuperFlakCannonPickup'
}