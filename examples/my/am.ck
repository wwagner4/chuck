SinOsc osc => dac;

1.0 => float lfreq; // HZ
0.1 => float d;
0.5 => float a;

/*
LFO for the amplitude with an offset d and an aplitude a.

The frequenz lfreq is in Hz.
d is a value greater 0
a is relative to d. The value can be between 0 and 1. 
0 ... No amplitude.
1 ... The value varies between 0 and d.
*/


Math.pi * 2.0 => float _2pi; 

fun void setGain() {
    0.0001 => float sr;
    0.0 => float t;
d - a * d / 2.0 => float d1;
a * d / 2.0 => float a1;
    while(1) {
        d1 + a1 * Math.sin(t * lfreq * _2pi) => float g;
        //<<<"t,g", t, g>>>;
        g => osc.gain;
        t + sr => t;
        sr::second => now;
    }
}


333 => osc.freq;
spork ~ setGain();
5::second => now;
