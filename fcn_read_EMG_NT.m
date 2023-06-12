%%% Function to receive and plot EMG from EAST.
function EMG_raw = fcn_read_EMG_NT()

global port
global inputs

inputs.stop = 0;
NumCyc = inputs.emg_recording_time;     % Number of plot cycle in secs
% Acquire EMG until stop button is pressed.
if(NumCyc == 0)
    NumCyc = 9999;
end
PlotTime = 1;    % Plot time in s
%%Fsamp = 1000;
NumChan = 2;
% Offset = [520 -664 -150 -480];         % Plot offset in mV MADRID
Offset = [90 -318 -150 -480];         % Plot offset in mV SRALAB
Offset = [4.39 4.39 -150 -480]; %highpass firm

ConvFact = 0.000286*1000;

Nch = dec2bin(inputs.emg_ch); %%%%%%%
for i=1:length(Nch)
    NumChan = NumChan + str2double(Nch(i));
end

Fsamp = 2000;
if(strcmp('1000 Hz',inputs.emg_fs))
    Fsamp = 1000;
elseif (strcmp('2000 Hz',inputs.emg_fs))
    Fsamp = 2000;
elseif (strcmp('4000 Hz',inputs.emg_fs))
    Fsamp = 4000;
elseif (strcmp('8000 Hz',inputs.emg_fs))
    Fsamp = 8000;
end

% EMG channels
if(strcmp('Channel 1-2',inputs.emg_ch))
    NumChan = 2;
elseif(strcmp('Channel 1-4',inputs.emg_ch))
    NumChan = 4;
elseif(strcmp('Channel 1-8',inputs.emg_ch))
    NumChan = 8;
elseif(strcmp('Channel 1-16',inputs.emg_ch))
    NumChan = 16;
end


% COM buffer size
NumSamples = Fsamp*PlotTime;
% NumSamples = Fsamp*1;
t = 0:1/Fsamp:(NumSamples-1)/Fsamp;
% Send the command byte to the NV08

NotchFr=60;
Wo=NotchFr/(Fsamp/2);
BW=Wo;
[bNotc,aNotc]=iirnotch(Wo,BW);

% fig1 = figure('units','normalized','outerposition',[0 0 1 1])
fig1 = figure(1)
% --------------------- RECEIVE EMG DATA AND PLOT ---------------------

EMG_raw = [];
data = [];
first = 1;
t = linspace(0, PlotTime, NumSamples);

% Acquire EMG for NumCyc time
for j=1:NumCyc
    
    tstart = tic;
    % wait the desired amount of time
    while toc(tstart) <= PlotTime
        %         inputs = fcn_get_parameters_v02(handles);
        pause(0.001);
    end
    
    % Read data from the COM
    if(inputs.stop == 0)
        tic()
        Sig = fread(port, [NumChan, NumSamples],'int16');
%         Sig = filtfilt(bNotc,aNotc,[Sig]')';
        data = [data Sig*ConvFact];

        % EMG signal plot
        for i = 1 : NumChan
            
            % FOR 2 MUSCLES
            if(NumChan < 3)
                % Compute envelope and detect tremor bursts
                [EMG_ENVELOPE, BURST_DETECTED] = fcn_tremor_detection_v02(Sig(i,:)*ConvFact-Offset(i), Fsamp, 40, 1);
                
                subplot(2,1,i)
                plot(t,Sig(i,:)*ConvFact-Offset(i)) %
                if(NumChan == 2)
                    hold on
                    plot(t,EMG_ENVELOPE(:,:),'linewidth',1.2)
                    plot(t,BURST_DETECTED(:,:),'linewidth',1.5)
                    hold off
                end
                ylim([-200 200]) %%%% CHANGE EMG SCALE
                
            % If EMG channels >3
            else
                
                subplot(2,2,i)
                plot(t,Sig(i,:)*ConvFact-Offset(i),'linewidth',1.1) %

                ylim([-200 200]) %%%% CHANGE EMG SCALE    
                
            end
            
        end
        hold off;
        ylabel('EMG(mV)')
        xlabel('Time(s)')
        drawnow
        toc()
    end
    %%%%%%%%%%%%%%%%%%%
    % end
end

EMG_raw = data;

% Send stop command when acquisition is over
command_sent = fcn_stop_stim_command();
if(port.BytesAvailable>0)
fread(port, port.BytesAvailable);
end
% Save rawdata
if(inputs.emg_save > 0)
    save([ inputs.emg_file_name '.mat'], 'EMG_raw')
end

end
