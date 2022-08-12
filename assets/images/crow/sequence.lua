-- sequence.lua
return {
    { name="wait", start=1, count=2, time=500 },
    { name="left", start=3, count=3, time=500 },
    { name="right", start=6, count=3, time=500 },
    { name="down", start=3, count=3, time=500 },
    { name="up", start=6, count=3, time=500 },
    { name="attack", start=15, count=1, loopCount=1 },
    { name="damage", start=16, count=1, loopCount=1 },
    { name="death", start=17, count=1, loopCount=1 },
}
