

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



