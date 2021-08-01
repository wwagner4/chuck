//Flute inst => JCRev r => dac;
//ModalBar inst => JCRev r => dac;
//BandedWG inst => JCRev r => dac;
//Moog inst => JCRev r => dac;
VoicForm inst => JCRev r => dac;
//Shakers inst => JCRev r => dac;
//Mandolin inst => JCRev r => dac;
//Sitar inst => JCRev r => dac;
//Bowed inst => JCRev r => dac;

0.75 => r.gain;
.025 => r.mix;

[ 61, 63, 65, 66, 68, 66, 68, 63 ] @=> int notes[];

while( true ) {
    Math.random2(2, 3) => int off;
    for( int i; i < notes.size(); i++ ) {
        Std.mtof( notes[i] + off) => inst.freq;
        0.1 => inst.noteOn;
        200::ms => now;
        0.1 => inst.noteOff;
        220::ms => now;
    }
}

