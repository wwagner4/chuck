SinOsc osc => dac;

1.0 => float lfreq;

fun void setGain() {
    0.0005 => float sr;
    0.0 => float t;
    while(1) {
        0.3 + Math.sin(t * lfreq) * 0.1 => float g;
        //<<<"t,g", t, g>>>;
        g => osc.gain;
        t + sr => t;
        sr::second => now;
    }
}


333 => osc.freq;
spork ~ setGain();
2::second => now;
