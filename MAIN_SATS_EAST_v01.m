
clc

% fs = round(fs_EMG);
fs=2000;
[BP_b,BP_a] = butter(2, [10 400]/(fs/2), 'bandpass');
[LP_b,LP_a] = butter(4, 10/(fs/2), 'low');
order = 200;
LP_cut_off = 8;
HP_cut_off = 3;
Wn_2 = (LP_cut_off)/(fs/2);
Wn_1 = (HP_cut_off)/(fs/2);
b_LP = fir1(order,[Wn_2],'bandpass');
Offset = [520 -664 -150 -480];

data = EMG_raw;
% EMG_raw= data;
% EMG_raw = double(Data(:,1:2))*1000;     %%%% FOR QUATTROCENTO RECORDINGS
% EMG_raw = EMG_raw(:,:)';  %%%% FOR NT recordings
EMG_raw = data(1:2,:)'-mean(data(1:2,:)');    %%%% FOR EAST recordings
% EMG_raw = [];
% EMG_raw = data(1,:)'-520;    %%%% FOR EAST recordings
% EMG_raw(:,2) = data(2,:)'+710;
% EMG_raw = EMG_raw(1:2,:)'-mean(EMG_raw(1:2,:)');
% EMG_raw(1,:) = EMG_raw(1,:)-Offset(1);
% EMG_raw(2,:) = EMG_raw(2,:)-Offset(2);
% EMG_raw = EMG_raw';
trial_length = length(EMG_raw);
window_rec_on = zeros(trial_length,1);

window_recording = 1*fs;
window_stim = 2*fs;
muscle = 1;
tremor_th = 40;
emg_rms_th = [0.004 0.002];
stim_duration_rel = 0.4 ; % In percentage
window_rms = 0.02;% In seconds
rms_threshold_gain_1 = 1.3;
rms_threshold_gain_2 = 1.3;

STATE = 0;

STIMULATION_OUTPUT = [];
STIMULATION_OUTPUT = zeros(trial_length,2);
EMG_burst_detected = [];
EMG_burst_predicted = [];
emg_seg = [];
current_global_pos = 1;
a = [];

%% LOOOOoooooooooOOOOOOOOOOoooooooooooooooooooOOOOOOOOOOOOOOOooooooooooooooOOOOP %%
w = round(1.2*fs);
k=1;
while(w < trial_length)
    tic()
    switch(STATE)
        %INIT
        case 0
            STATE = 1;
            
            % TREMOR DETECTION
        case 1
            window_rec_on(w:(w+window_recording)) = 50;
            
            EMG_seg = EMG_raw(w:w + window_recording,:);
            % BANDPASS
            %             EMG_fil1 = filtfilt(BP_b,BP_a, EMG_seg);
            % HILBERT
            %             EMG_fil_h = hilbert(EMG_fil1);
            % ENVELOPE
            EMG_fil_h_env = filter(b_LP,1,abs(EMG_seg));
            
            %             EMG_fil_h_env = EMG_fil1c;
            
            % DEFINE RMS THRESHOLD
            emg_rms_th(1) = rms(EMG_raw(w:w + window_recording,1))*rms_threshold_gain_1;
            emg_rms_th(2) = rms(EMG_raw(w:w + window_recording,2))*rms_threshold_gain_2;
            
            % FIND TREMOR BURSTS
            tremor_burst = zeros(length(EMG_fil_h_env),1);
            tremor_burst_loc = [];
            tremor_burst_n = 1;
            for j=2:length(EMG_fil_h_env)-1
                if(EMG_fil_h_env(j,muscle) > tremor_th && EMG_fil_h_env(j,muscle) < 550 && EMG_fil_h_env(j,muscle) > EMG_fil_h_env(j+1,muscle) && EMG_fil_h_env(j,muscle) > EMG_fil_h_env(j-1,muscle))
                    tremor_burst_loc(tremor_burst_n) = j-order/2;
                    tremor_burst_n = tremor_burst_n+1;
                end
            end
            
            tremor_burst(round(tremor_burst_loc)) = 30;
            
            n_bursts = length(tremor_burst_loc);
            ibi = [];
            if(n_bursts>2)
                tremor_present = 1;
                STATE = 2;
                for i = 1:n_bursts-1
                    ibi = [ibi abs(tremor_burst_loc(i) - tremor_burst_loc(i+1))];
                end
                
                ibi_mean = mean(ibi)/fs;
                stim_win_1 = ibi_mean*ibi_mean*0.8;
                freq_tremor = 1/ibi_mean;
                
                next_bursts = [];
                j = 1;
                while(( round(tremor_burst_loc(end)/fs + ibi_mean*j*fs) < window_stim))
                    %         for k = 1:n_bursts
                    next_bursts(j) = round(tremor_burst_loc(end) + ibi_mean*j*fs);
                    j = j + 1;
                end
                
                EMG_burst_detected = [EMG_burst_detected (tremor_burst_loc + w) ];
                EMG_burst_predicted = [EMG_burst_predicted  ( w + next_bursts)];
                
            else
                tremor_present = 0;
                
                if(w + window_recording + window_stim*2 < trial_length)
                    w = w + window_recording + window_stim;
                else
                    w = trial_length + 1;
                end
                STATE = 1;
                
                
            end
            
            
            
        case 2
            if(k < trial_length)
                if(k>trial_length)
                    k;
                end
                w = w + window_recording;
                k = w;
                
                while(k < w + window_stim - round(fs*window_rms))
                    EMG_rms = rms(EMG_raw(k:round(k + fs*window_rms),:));
                    current_global_pos = round(k + fs*window_rms);
                    
                    if(EMG_rms(2) > emg_rms_th(2))
                        STIMULATION_OUTPUT(current_global_pos:round(current_global_pos+fs*ibi_mean*stim_duration_rel),1) = 50;
                    end
                    if(EMG_rms(1) > emg_rms_th(1))
                        STIMULATION_OUTPUT(current_global_pos:round(current_global_pos+fs*ibi_mean*stim_duration_rel),2) = -50;
                    end
                    
                    if(EMG_rms(1) > emg_rms_th(1) || EMG_rms(2) > emg_rms_th(2))
                        k = round(current_global_pos+fs*ibi_mean*stim_duration_rel);
                    else
                        k = current_global_pos + 1;
                    end
                    
                end
                
                if(w + window_stim*2 < trial_length)
                    w = w + window_stim;
                    STATE = 1;
                else
                    w = trial_length + 1;
                    STATE = 0;
                end
            else
                w = trial_length + 1;
                STATE = 0;
            end
            
    end
    a = [a toc()];
    
end


%% ALL SIGNAL

% BANDPASS
EMG_fil1 = filtfilt(BP_b,BP_a, abs(EMG_raw));
% HILBERT
EMG_fil_h = hilbert(EMG_fil1);
% ENVELOPE
% EMG_fil_h_env = filtfilt(LP_b,LP_a, abs(EMG_raw));
EMG_fil_h_env = filter(b_LP,1,abs(EMG_raw));
EMG_fil_h_env1 = flip(filter(b_LP,1,abs(flip(EMG_fil_h_env))));
t = 0:1/fs:(length(EMG_fil_h_env)-1)/fs;
hold on
%%
figure,
% plot(t,EMG_fil_h_env(:,1),'Color', [225/255 225/255 225/255],'linewidth', 2)
plot(t, EMG_raw(:,1))
hold on
plot(t, EMG_raw(:,2))

plot(t(1:length(t)-order/2+1),EMG_fil_h_env(order/2:end,1),'linewidth', 2)
plot(t(1:length(t)-order/2+1),EMG_fil_h_env(order/2:end,2),'linewidth', 2)

% %  pwelch(EMG_fil_h_env(20*fs:40*fs,1),[],[],[],fs)
%
BURST_detected = zeros(length(EMG_raw),1);
BURST_predicted = zeros(length(EMG_raw),1);
BURST_detected(EMG_burst_detected) = 50;
BURST_predicted(EMG_burst_predicted) = 50;


%%

plot(t,BURST_detected*5, 'linewidth', 2.5)
plot(t,BURST_predicted*5, 'linewidth', 2.5)
plot(t,window_rec_on*5, 'linewidth', 1.5)
plot(t,STIMULATION_OUTPUT(1:trial_length,1)*5, 'linewidth', 1.1)
plot(t,STIMULATION_OUTPUT(1:trial_length,2)*5, 'linewidth', 1.2)
% ylim([min(EMG_raw(:,1))+1000 max(EMG_raw(:,1))+1000])
legend({'Raw ECR';'Raw FCR';'Envelope ECR';'Envelope FCR';'Tremor burst detected';'Tremor burst predicted OF1';'Recording window';'Stim of ECR';'Stim of FCR'})

%%
% figure,
%
% plot(t,BURST_detected, 'linewidth', 1.2)
% hold on
% plot(t,BURST_predicted, 'linewidth', 1.5)
% plot(t,window_rec_on, 'k', 'linewidth', 1.1)
% plot(t, EMG_fil_h_env(:,1), 'linewidth', 1.5)
% plot(t,EMG_fil_h_env(:,2), 'linewidth', 1.2)
%  legend({'FCR'; 'ECR'; 'Detected ECR BURST'; 'Predicted ECR BURST'})




% tremor_burst_win = round(100/fs);
