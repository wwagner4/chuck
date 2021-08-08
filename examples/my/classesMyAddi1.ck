class MyAddi1 extends Chugraph {

    ADSR env;
    SinOsc osc0 => env;
    SinOsc osc1 => env;
    SinOsc osc2 => env;
    SinOsc osc3 => env;
    env => outlet;

    env.set(0.01 :: second, 0.2 :: second, 0.5, 0.2 :: second);
    0.1 => float gainBase;
    440 => float freqBase;
    [0.8, 0.3, 0.1] @=> float weights[];

    Shred soundShred;

    fun void sound() {

        freqBase => osc0.freq;
        freqBase * 2 => osc1.freq;
        freqBase * 3 => osc2.freq;
        freqBase * 4 => osc3.freq;

        0.020 => float o1;
        0.022 => float o2;
        0.024 => float o3;

        0 => int i;
        while (1) {
            (Math.sin(i * o1) + 1.0) * 0.5 * weights[0] => float weight1;
            (Math.sin(i * o2) + 1.0) * 0.5 * weights[1] => float weight2;
            (Math.sin(i * o3) + 1.0) * 0.5 * weights[2] => float weight3;

            gainBase => osc0.gain;
            gainBase * weight1 => osc1.gain;
            gainBase * weight2 => osc2.gain;
            gainBase * weight3 => osc3.gain;

            1::ms => now;
            i++;
        }

    }

    fun void freq(float f) {
        f => freqBase;
    }

    fun void noteOn(float gain) {
        spork ~ sound() @=> soundShred;
        1 => env.keyOn;
    }

    fun void noteOff(float gain) {
        1 => env.keyOff;
        soundShred.exit();
    }
}

fun float[] ranWeights() {
    return [Math.random2f(0, 1), Math.random2f(0, 1), Math.random2f(0, 1)];
}


 MyAddi1 inst => JCRev r => dac;

0.005 => r.mix;
0.5 => r.gain;

<<<"jcrev gain:", r.gain()>>>;
<<<"inst gain:", inst.gain()>>>;

[ 63, 63, 60, 63, 65, 67] @=> int notes[];
[ 1,  2,  1,  2,  2,  4] @=> int noteLengths[];

for(0 => int i; i < 3; i++) {
    3 => int off;
    ranWeights() @=> float ws[];
    ws @=> inst.weights;
    <<<"offset:", off, "weights:", ws[0], ws[1], ws[2]>>>;
    for( int i; i < notes.size(); i++ ) {
        Std.mtof( notes[i] + off) => inst.freq;
        0.1 => inst.noteOn;
        200 * noteLengths[i]::ms => now;
        0.1 => inst.noteOff;
        100::ms => now;
    }
}
400::ms => now;


