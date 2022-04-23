class SuperFlakTrail extends FlakTrail;


simulated function BeginPlay()
{
    mColorRange[0].R=128;
    mColorRange[0].G=0;
    mColorRange[0].B=128;
    mColorRange[1].R=Rand(2)*127 + 127;
    mColorRange[1].G=Rand(3)*127;
    mColorRange[1].B=Rand(3)*127;
}

defaultproperties
{
    mParticleType=6
    mSpawnVecB=(X=10.0,Y=0.0,Z=0.0)
    mLifeRange[0]=0.50
    mLifeRange[1]=0.50
    mRegenRange[0]=100.0
    mRegenRange[1]=100.0
    mSizeRange[0]=10.0
    mSizeRange[1]=12.0
    mGrowthRate=-0.10
}