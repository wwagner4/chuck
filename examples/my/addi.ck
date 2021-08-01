
ADSR env;
SinOsc osc0 => env;
SinOsc osc1 => env;
SinOsc osc2 => env;
SinOsc osc3 => env;
env => dac;

env.set(0.01 :: second, 0.1 :: second, 0.1, 0.5 :: second);
0.2 => float gainBase;

Math.random2(1, 4) => int lenSound;
Math.random2(200, 500) => float freqBase;

fun void sound() {

    freqBase => osc0.freq;
    freqBase * 2 => osc1.freq;
    freqBase * 3 => osc2.freq;
    freqBase * 4 => osc3.freq;

    Math.random2f(0.005, 0.01) => float o1;
    Math.random2f(0.005, 0.01) => float o2;
    Math.random2f(0.005, 0.01) => float o3;

    0 => int i;
    while (1) {
        (Math.sin(i * o1) + 1.0) * 0.5 * 0.7 => float weight1;
        (Math.sin(i * o2) + 1.0) * 0.5 * 0.5 => float weight2;
        (Math.sin(i * o3) + 1.0) * 0.5 * 0.2 => float weight3;

        gainBase => osc0.gain;
        gainBase * weight1 => osc1.gain;
        gainBase * weight2 => osc2.gain;
        gainBase * weight3 => osc3.gain;

        1::ms => now;
        i++;
    }
}

spork ~ sound();
1 => env.keyOn;
2::second => now;
1 => env.keyOff;
2.0::second => now;
