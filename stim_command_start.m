%%% Function to send the stimulation command to EAST.
function stim_command_start(parameters)


    % Datasets for stimulation frequencies, durations and amplitudes
    StimFreqDataSet = [1 2 3 4 5 6 7 8 9 10 12 14 16 18 20 22 24 26 28 30 35 40 45 50 55 60 70 80 90 100 150];
    StimDurDataSet  = [100 125 150 175 200 225 250 275 300 325 350 375 400 425 450 475 500 525 550 575 600 625 650 675 700 750 800 850 900 950 1000];
    StimAmpDataSet  = [0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 12 13 14 15 16 17 18 19 20];
    % ----------------------------------------------------------------------- %
    
    ConfString = [];
    ConfString(1) = 25;
    ConfString(2) = bin2dec('00000000');
    ConfString(2) = ConfString(2) + bin2dec('00000000');
    ConfString(2) = ConfString(2) + bin2dec('00000000');
    ConfString(2) = ConfString(2) + 1;
    ConfString(3) = 0;
    for i = 1 : 8
        if(parameters.stim_channel(i)>0)
            ConfString(3) = ConfString(3) + bitshift(1,i-1);
        else
            ConfString(3) = ConfString(3) + bitshift(0,i-1);
        end
    end
    
    % BYTE 4. STIM FREQ AND TYPE byte
    [minValue,StimFreqIndex] = min(abs(StimFreqDataSet-parameters.frequency));
    if(strcmp('Biphasic',parameters.stim_phase))
        StimType = 3*32;
    elseif(strcmp('Positive',parameters.stim_phase))
        StimType = 1*32;
    elseif(strcmp('Negative',parameters.stim_phase))
        StimType = 2*32;
    end
    ConfString(4) = StimType + StimFreqIndex;
    
    % BYTE 5. Pulse width
    [minValue,StimDurIndex] = min(abs(StimDurDataSet-parameters.pulse_width));
    ConfString(5) = StimDurIndex;
    
    % BYTE 6-13. Stimulation amplitude.
    for i = 1 : 8
        [minValue,StimAmpIndex] = min(abs(StimAmpDataSet-parameters.stim_channel(i)));
        ConfString(5+i) = StimAmpIndex;
    end
    
    ConfString(14) = 30;
    ConfString(15) = 30;
    ConfString(16) = 1;
    ConfString(17) = 4;
    ConfString(18) = 1;
    ConfString(19) = parameters.mode;
    ConfString(20) = parameters.tremor_treshold;
    ConfString(21) = 12;
    ConfString(22) = 12;
    ConfString(23) = 15;
    ConfString(24) = parameters.muscle_type;
    
    ConfString(25) = CRC8(ConfString, 24);
    
    % Send command via serial port
    fwrite(port, ConfString, 'uint8');
end