%%% Function to send the stimulation command to EAST.
function command_sent = fcn_start_stim_command(handles)

global inputs
global port
global ConfString
global EMG_raw

Command_size = 25;
Mode = 0;
inputs.stop = 0;
% ----------------- Fixed parameters, do not change --------------------- %
Resolution = 2;     % Resolution in byte
ConvFact = 0.000286*1000;% Conversion factor to get the signals in mV
% Datasets for stimulation frequencies, durations and amplitudes
% StimFreqDataSet = [1 2 3 4 5 6 7 8 9 10 12 14 16 18 20 22 24 26 28 30 35 40 45 50 55 60 65 70 80 90 100];
StimFreqDataSet = [1 2 3 4 5 6 7 8 9 10 12 14 16 18 20 22 24 26 28 30 35 40 45 50 55 60 70 80 90 100 150];
StimDurDataSet  = [100 125 150 175 200 225 250 275 300 325 350 375 400 425 450 475 500 525 550 575 600 625 650 675 700 750 800 850 900 950 1000];
StimAmpDataSet  = [0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 12 13 14 15 16 17 18 19 20];
% ----------------------------------------------------------------------- %
ConfString = [];

%BYTE 1.
ConfString(1) = Command_size;

% BYTE 2.
%Test mode
switch Mode
    case 0,
        ConfString(2) = bin2dec('00000000');
    case 1,
        ConfString(2) = bin2dec('01000000');
    case 2,
        ConfString(2) = bin2dec('10000000');
    otherwise,
        ConfString(2) = bin2dec('00000000');
end

% Sampling frequency
if(strcmp('1000 Hz',inputs.emg_fs))
    Fsamp = 1000;
    ConfString(2) = ConfString(2) + bin2dec('00110000');
elseif(strcmp('2000 Hz',inputs.emg_fs))
    Fsamp = 2000;
    ConfString(2) = ConfString(2) + bin2dec('00000000');
elseif(strcmp('4000 Hz',inputs.emg_fs))
    Fsamp = 4000;
    ConfString(2) = ConfString(2) + bin2dec('00010000');
elseif(strcmp('8000 Hz',inputs.emg_fs))
    Fsamp = 8000;
    ConfString(2) = ConfString(2) + bin2dec('00100000');
end

% EMG channels
if(strcmp('Channel 1-2',inputs.emg_ch))
    ConfString(2) = ConfString(2) + bin2dec('00000000');
elseif(strcmp('Channel 1-4',inputs.emg_ch))
    ConfString(2) = ConfString(2) + bin2dec('00000100');
elseif(strcmp('Channel 1-8',inputs.emg_ch))
    ConfString(2) = ConfString(2) + bin2dec('00001000');
elseif(strcmp('Channel 1-16',inputs.emg_ch))
    ConfString(2) = ConfString(2) + bin2dec('00001100');
end

% Start data transfer by setting the GO bit = 1.
ConfString(2) = ConfString(2) + 1;


% BYTE 3. Stimulation active channels.
ConfString(3) = 0;
for i = 1 : 8
    if(inputs.stim_channel(i)>0)
        ConfString(3) = ConfString(3) + bitshift(1,i-1);
    else
        ConfString(3) = ConfString(3) + bitshift(0,i-1);
    end
end

% BYTE 4. STIM FREQ AND TYPE byte
[minValue,StimFreqIndex] = min(abs(StimFreqDataSet-inputs.freq_stim));
if(strcmp('Biphasic',inputs.stim_phase))
    StimType = 3*32;
elseif(strcmp('Positive',inputs.stim_phase))
    StimType = 1*32;
elseif(strcmp('Negative',inputs.stim_phase))
    StimType = 2*32;
end
ConfString(4) = StimType + StimFreqIndex;

% BYTE 5. Pulse width
[minValue,StimDurIndex] = min(abs(StimDurDataSet-inputs.pulse_width));
ConfString(5) = StimDurIndex;

% BYTE 6-13. Stimulation amplitude.
for i = 1 : 8
    [minValue,StimAmpIndex] = min(abs(StimAmpDataSet-inputs.stim_channel(i)));
    ConfString(5+i) = StimAmpIndex;
end

ConfString(14)  =  inputs.time_window_stim_on;
ConfString(15)  =  inputs.time_window_stim_off;
ConfString(16)  =  inputs.time_window_read;
ConfString(17)  =  inputs.time_window_stim;
ConfString(18)  =  inputs.trial_sequence;

if(strcmp('Manual',inputs.mode))
    ConfString(19)  =  0;
elseif(strcmp('Out-of-phase',inputs.mode))
    ConfString(19)  =  1;
elseif(strcmp('SATS',inputs.mode))
    ConfString(19)  =  2;
elseif(strcmp('CON',inputs.mode))
    ConfString(19)  =  3;
end

ConfString(20) = inputs.tremor_threshold;
ConfString(21) = inputs.threshold_gain_muscle_1;
ConfString(22) = inputs.threshold_gain_muscle_2;
ConfString(23) = inputs.time_rms;
ConfString(24) = inputs.tremor_detection_muscle;

ConfString(Command_size) = CRC8(ConfString, Command_size-1);

% Send command via serial port
fwrite(port, ConfString, 'uint8')
% Acquire EMG function
% EMG_raw = fcn_read_EMG_NT();
EMG_raw = fcn_read_EMG_NT_v02(handles);
command_sent = 1;
inputs.stop = 0;
end