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
    mParticleType=6
    mSpawnVecB=(X=10.0,Y=0.0,Z=0.0)
    mLifeRange[0]=0.50
    mLifeRange[1]=0.50
    mRegenRange[0]=160.0
    mRegenRange[1]=160.0
    mSizeRange[0]=10.0
    mSizeRange[1]=12.0
    mGrowthRate=-0.10
}