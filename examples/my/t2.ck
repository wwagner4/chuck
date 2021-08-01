SinOsc so => dac;
SinOsc so1 => dac;

300 => int num;
0.4 => so.gain;
0 => int i;
40 => int s1;
while (i <= 30) {
    Std.mtof(i + s1) => float f1;
    f1 => so.freq;
    Math.random2f(1.95, 2.05) => float df;
    f1 * df => so1.freq;
    if (i % 2 == 0) 0.5::second => now;
    else 0.2::second => now;
    i++;
}
