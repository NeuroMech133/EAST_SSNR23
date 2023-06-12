function BiEMG_command_start(stim_parameters)

    ConfString = [];
    ConfString(1) = 25;
    ConfString(2) = bin2dec('00000000');
    ConfString(2) = ConfString(2) + bin2dec('00000000'); % 2000Hz sampling frequency
    ConfString(2) = ConfString(2) + bin2dec('00000000'); % EMG channels
    ConfString(2) = ConfString(2) + 1;
    ConfString(3) = 0;
    if isempty(stim_parameters.type)
        stim_parameters.type = 3*32;
    end
    ConfString(4) = stim_parameters.type + 30;
    ConfString(5) = 17; % Pulse width setting
    for i = 1 : 8
        ConfString(5+i) = 0;
    end
    ConfString(14)  =  30; % Time window Stim on
    ConfString(15)  =  30; % Time window Stim off
    ConfString(16)  =  1; % Timw window Read
    ConfString(17)  =  4; % Time window Stim
    ConfString(18)  =  0; % Trial sequence
    ConfString(19)  =  stim_parameters.mode;
    ConfString(20) = stim_parameters.tremor_threshold; % Tremor threshold
    ConfString(21) = 12; % Threshold gain Muscle ECR
    ConfString(22) = 12; % Threshold gain Muscle FCR
    ConfString(23) = 15; % Time RMS
    ConfString(24) = stim_parameters.muscle_type; % Tremor muscle detection: ECR = 1; FCR = 2
    ConfString(25) = CRC8(ConfString, 24);
    fwrite(stim_parameters.port, ConfString, 'uint8')

end