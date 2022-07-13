-- rectRed_sequence.lua
return {
    { name="wait", start=80+1, count=2, time=200 },
    { name="down", start=80+3, count=2, time=200 },
    { name="up", start=80+5, count=2, time=200 },
    { name="left", start=80+7, count=2, time=200 },
    { name="right", start=80+9, count=2, time=200 },
    { name="win", start=80+11, count=2, time=200 },
    { name="lose", start=80+13, count=2, time=200 },
    { name="start", start=80+15, count=4, time=200 },
    { name="damage", start=80+19, count=1, time=200 },
    { name="dead", start=80+20, count=1, time=200 }
}