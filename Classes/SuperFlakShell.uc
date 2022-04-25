class SuperFlakShell extends FlakShell;

//var int ShellChunks;

simulated function PostBeginPlay()
{
	local Rotator R;
	local PlayerController PC;
	
	if ( !PhysicsVolume.bWaterVolume && (Level.NetMode != NM_DedicatedServer) )
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 6000 )
			Trail = Spawn(class'SuperFlakTrail',self);
		Glow = Spawn(class'FlakGlow', self);
	}

	Super(Projectile).PostBeginPlay();
	Velocity = Vector(Rotation) * Speed;  
	R = Rotation;
	R.Roll = 32768;
	SetRotation(R);
	Velocity.z += TossZ; 
	initialDir = Velocity;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector start;
    local rotator rot;
    local int i;
    local SuperFlakShellChunk NewChunk;

	start = Location + 10 * HitNormal;
	if ( Role == ROLE_Authority )
	{
		HurtRadius(damage, class'MutInstaFlak'.default.ExplosionRadius, MyDamageType, MomentumTransfer, HitLocation);	//changed hurt radius from 220 to 300
		for (i=0; i<class'MutInstaFlak'.default.NumShellChunks; i++)
		{
			rot = Rotation;
			rot.yaw += FRand()*32000-16000;
			rot.pitch += FRand()*32000-16000;
			rot.roll += FRand()*32000-16000;
			NewChunk = Spawn( class 'SuperFlakShellChunk',, '', Start, rot);
		}
	}
    Destroy();
}


// Decompiled with UE Explorer.
defaultproperties
{
    Speed=1700.0
	//ShellChunks=30
    Damage=3000.0
}
