class SuperFlakChunk extends FlakChunk;

simulated function PostBeginPlay()
{
    local float r;

    if ( Level.NetMode != NM_DedicatedServer )
    {
        if ( !PhysicsVolume.bWaterVolume )
        {
            Trail = Spawn(class'SuperFlakTrail',self);
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

// Decompiled with UE Explorer.
defaultproperties
{
    Bounces=30
    DamageAtten=0.0
    Speed=3000.0
    Damage=3000.0
    AmbientGlow=0
    bBounce=true
    Lifespan=1.5
    // LightHue=195
    // LightBrightness=255.0
    // LightEffect=LE_Shock
    // LightType=LT_Steady
    // LightSaturation=255
}
