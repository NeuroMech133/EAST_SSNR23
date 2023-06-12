% Simulating tremor EMG

fsamp = 2000; % Hz
time = 1; % sec
tremor_freq = 4; % Hz

ECR = zeros(fsamp*time,1);
FCR = zeros(fsamp*time,1);

j = fsamp/(tremor_freq*2);

noise_emg = [];
for k = 1:floor(j/4)
    noise_emg = [noise_emg, 2.5, 3.4, -2.5, -3.4];
end
noise_emg = [0,noise_emg,0];

tremor_emg = [];
for k = 1:floor(j/4)
    tremor_emg = [tremor_emg, k+0.5, (k+0.5)*(-1)];
end
tremor_emg = [tremor_emg,flip(tremor_emg)];
tremor_emg = [0,tremor_emg,0];

for i = 1:tremor_freq*2
    if rem(i,2) == 0
        ECR(((i-1)*j+1):(i*j)) = noise_emg;
        FCR(((i-1)*j+1):(i*j)) = tremor_emg;
    else
        ECR(((i-1)*j+1):(i*j)) = tremor_emg;
        FCR(((i-1)*j+1):(i*j)) = noise_emg;
    end
end
EMG = [ECR';FCR'];
clearvars -except EMG