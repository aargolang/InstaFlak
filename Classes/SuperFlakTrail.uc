class SuperFlakTrail extends FlakTrail;


simulated function BeginPlay()
{
    mColorRange[0].R=Rand(2)*255;
    mColorRange[0].G=Rand(2)*255;
    mColorRange[0].B=Rand(2)*255;
    mColorRange[1].R=Rand(2)*255;
    mColorRange[1].G=Rand(2)*255;
    mColorRange[1].B=Rand(2)*255;
}

defaultproperties
{
    mParticleType=1
    mSpawnVecB=(X=20.0,Y=0.0,Z=0.0)
    mLifeRange[0]=0.5
    mLifeRange[1]=0.5
    mRegenRange[0]=10.0
    mRegenRange[1]=10.0
    mSizeRange[0]=0.01
    mSizeRange[1]=0.01
    mGrowthRate=75.0
    mSpawningType=1
    // mAttenKa=0.01
    // mAttenKb=1.0
    //mAttenFunc=3
}