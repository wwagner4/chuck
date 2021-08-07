public class MyMandolin extends Chugraph {

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
