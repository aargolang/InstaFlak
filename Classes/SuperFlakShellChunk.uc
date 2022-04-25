class SuperFlakShellChunk extends SuperFlakChunk;

simulated function PostBeginPlay()
{
    local float r;

    if ( Level.NetMode != NM_DedicatedServer )
    {
        if ( !PhysicsVolume.bWaterVolume )
        {
            Trail = Spawn(class'SuperFlakShellChunkTrail',self);
            Trail.Lifespan = Lifespan;
        }
            
    }

    Velocity = Vector(Rotation) * (Speed);
    if (PhysicsVolume.bWaterVolume)
        Velocity *= 0.65;

    r = FRand();
    if (r > 0.75)
        Bounces = 2;
    else if (r > 0.25)
        Bounces = 1;
    else
        Bounces = 0;

    SetRotation(RotRand());

    Super(Projectile).PostBeginPlay();
}