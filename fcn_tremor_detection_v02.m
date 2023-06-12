%%% Function to compute EMG envelope and detect tremor bursts.
% emg_in --> emg raw signal
% fs --> sampling frequency (Hz)
% tremor_th --> tremor detection threshold
% muscle --> muscle to detect tremor

function [EMG_ENVELOPE, BURST_DETECTED] = fcn_tremor_detection_v02(emg_in, fs, tremor_th, muscle)

global inputs

% Filters
[BP_b,BP_a] = butter(2, [10 400]/(fs/2), 'bandpass');
[LP_b,LP_a] = butter(4, 10/(fs/2), 'low');

emg_in = emg_in(:,:)'; 
trial_length = length(emg_in);
window_rec_on = zeros(trial_length,1);

window_stim = 2*fs;
scale = 0.01;

EMG_burst_detected = [];
EMG_burst_predicted = [];
emg_seg = [];
a = [];

%%
% BANDPASS
EMG_fil1 = filtfilt(BP_b,BP_a, emg_in);
% HILBERT (not used here)
% EMG_fil_h = hilbert(EMG_fil1);
% ENVELOPE
EMG_fil_h_env = filtfilt(LP_b,LP_a, abs(EMG_fil1));

%%

for q_muscle=1:1
    
    tremor_burst = zeros(length(EMG_fil_h_env),1);
    tremor_burst_loc = [];
    tremor_burst_n = 1;
    for j=2:length(EMG_fil_h_env)-1
        if(EMG_fil_h_env(j,q_muscle) > tremor_th && EMG_fil_h_env(j,q_muscle) < 200 && EMG_fil_h_env(j,q_muscle) > EMG_fil_h_env(j+1,q_muscle) && EMG_fil_h_env(j,q_muscle) > EMG_fil_h_env(j-1,q_muscle))
            tremor_burst_loc(tremor_burst_n) = j;
            tremor_burst_n = tremor_burst_n+1;
        end
    end
    
    
    %%
    n_bursts = length(tremor_burst_loc);
    ibi = [];
    w=1;
    if(n_bursts>2)
%         if(w>29000)
%             w;
%         end
        for i = 1:n_bursts-1
            ibi = [ibi abs(tremor_burst_loc(i) - tremor_burst_loc(i+1))];
            
        end
        ibi_mean = mean(ibi)/fs;
        freq_tremor = 1/ibi_mean;
        
        next_bursts = [];
        k = 1;
        while(( round(tremor_burst_loc(end)/fs + ibi_mean*k*fs) < window_stim))
            %   for k = 1:n_bursts
            next_bursts(k) = round(tremor_burst_loc(end) + ibi_mean*k*fs);
            k = k + 1;
        end
       

        
    end

    
    BURST_detected = zeros(length(emg_in),muscle);
    % BURST_predicted = zeros(length(EMG_raw),muscle);
    BURST_detected(tremor_burst_loc) = 0.05;
    % BURST_predicted( ) = scale;
    if(isempty(EMG_fil_h_env))
        EMG_fil_h_env = zeros(1000,1);
    end
    
    BURST_DETECTED(:,q_muscle) = BURST_detected;
    
end
EMG_ENVELOPE = EMG_fil_h_env';

end