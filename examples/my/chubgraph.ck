
class MyMandolin extends Chugraph {

    Mandolin inst;
    inst => JCRev r => outlet;
    0.9 => r.gain;
    0.025 => r.mix;
    0.9 => inst.bodySize; 

    fun void freq(float f) {
        f => inst.freq;
    }

    fun void noteOn(float gain) {
        gain => inst.noteOn;
    }

    fun void noteOff(float gain) {
        gain => inst.noteOff;
    }
}

class MyAddi0 extends Chugraph {

    ADSR env;
    SinOsc osc0 => env;
    SinOsc osc1 => env;
    SinOsc osc2 => env;
    SinOsc osc3 => env;
    env => dac;

    env.set(0.2 :: second, 0.2 :: second, 0.5, 0.2 :: second);
    0.1 => float gainBase;
    440 => float freqBase;

    Shred soundShred;

    fun void sound() {

        freqBase => osc0.freq;
        freqBase * 2 => osc1.freq;
        freqBase * 3 => osc2.freq;
        freqBase * 4 => osc3.freq;

        Math.random2f(0.007, 0.01) => float o1;
        Math.random2f(0.07, 0.1) => float o2;
        Math.random2f(0.07, 0.1) => float o3;

        0 => int i;
        while (1) {
            (Math.sin(i * o1) + 1.0) * 0.5 * 0.8 => float weight1;
            (Math.sin(i * o2) + 1.0) * 0.5 * 0.3 => float weight2;
            (Math.sin(i * o3) + 1.0) * 0.5 * 0.1 => float weight3;

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

MyAddi0 inst => dac;
//MyMandolin inst => dac;
//ModalBar inst => JCRev r => dac;
//BandedWG inst => JCRev r => dac;
//Moog inst => JCRev r => dac;
//VoicForm inst => JCRev r => dac;
//Shakers inst => JCRev r => dac;
//Mandolin inst => JCRev r => dac;
//Sitar inst => JCRev r => dac;
//Bowed inst => JCRev r => dac;

[ 61, 63, 65, 66, 68, 66, 67, 62 ] @=> int notes[];

while( true ) {
    Math.random2(-2, 3) => int off;
    Math.random2(1, 4) => int speed;
    <<<"offset speed:", off, speed>>>;
    for( int i; i < notes.size(); i++ ) {
        Std.mtof( notes[i] + off) => inst.freq;
        0.1 => inst.noteOn;
        (100 * speed)::ms => now;
        0.1 => inst.noteOff;
        0.2::second => now;
    }
}



