%%% Function to send the STOP stimulation command to EAST.

function command_sent = fcn_stop_stim_command()

global inputs
global port
global ConfString
global EMG_raw

Command_size = 25;
Mode = 0;

% ----------------- Fixed parameters, do not change --------------------- %
Resolution = 2;     % Resolution in byte
ConvFact = 0.000286*1000;% Conversion factor to get the signals in mV
% Datasets for stimulation frequencies, durations and amplitudes
StimFreqDataSet = [1 2 3 4 5 6 7 8 9 10 12 14 16 18 20 22 24 26 28 30 35 40 45 50 55 60 65 70 80 90 100];
StimDurDataSet  = [100 125 150 175 200 225 250 275 300 325 350 375 400 425 450 475 500 525 550 575 600 625 650 675 700 750 800 850 900 950 1000];
StimAmpDataSet  = [0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 12 13 14 15 16 17 18 19 20];
% ----------------------------------------------------------------------- %
ConfString = [];


ConfString(1) = Command_size;
ConfString(2) = 0;
ConfString(3) = 0;
[minValue,StimFreqIndex] = min(abs(StimFreqDataSet-1));
ConfString(4) = 32 + StimFreqIndex;

% BYTE 5. Pulse width
[minValue,StimDurIndex] = min(abs(StimDurDataSet-100));
ConfString(5) = StimDurIndex;

% BYTE 6-13. Stimulation amplitude.
for i = 1 : 8
    ConfString(5+i) = 0;
end

ConfString(14) =  0;
ConfString(15) =  0;
ConfString(16) =  0;
ConfString(17) =  0;
ConfString(18) =  0;
ConfString(19) =  0;
ConfString(20) =  0;
ConfString(21) =  0;
ConfString(22) =  0;
ConfString(23) =  0;
ConfString(24) =  0;

ConfString(Command_size) = CRC8(ConfString, Command_size-1);

% Send command via serial port
fwrite(port, ConfString, 'uint8')

command_sent = 1;
inputs.stop = 1;

end