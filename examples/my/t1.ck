TriOsc so => dac;

300 => float bf;
for (0 => int i; i < 4; i++) {
    bf => so.freq;
    0.2 => so.gain;
    0.1::second => now;

    bf * 2.0 => so.freq;
    0.3 => so.gain;
    0.2::second => now;

    bf * 0.5 => so.freq;
    0.6 => so.gain;
    0.2::second => now;

    bf * 4 => so.freq;
    0.1 => so.gain;
    0.1::second => now;
}

