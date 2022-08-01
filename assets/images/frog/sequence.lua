-- sequence.lua
return {
    { name="wait", start=1, count=2, time=200 },
    { name="right", start=3, count=3, time=500 },
    { name="left", start=6, count=3, time=500 },
    { name="down", start=9, count=3, time=500 },
    { name="up", start=12, count=3, time=500 },
    { name="attack_right", start=4, count=1, loopCount=1 },
    { name="attack_left", start=7, count=1, loopCount=1 },
    { name="attack_down", start=10, count=1, loopCount=1 },
    { name="attack_up", start=13, count=1, loopCount=1 },
}