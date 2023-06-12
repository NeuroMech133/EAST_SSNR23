%%% Function to update  parameters from GUI.
function [inputs] = fcn_get_parameters_v02(handles)

input = [];
global inputs
%% STIMULATION

%Freqency and pulse width
inputs.pulse_width = str2double(get(handles.input_pulse_width, 'String'));
inputs.freq_stim = str2double(get(handles.input_freq_stim, 'String'));

%Trial sequence
trial_seq = [get(handles.button_trial_1, 'Value'), bitshift(get(handles.button_trial_2, 'Value'),1), bitshift(get(handles.button_trial_3, 'Value'),2)...
                 bitshift(get(handles.button_trial_4, 'Value'),3), bitshift(get(handles.button_trial_5, 'Value'),4),  bitshift(get(handles.button_trial_6, 'Value'),5)...
                 bitshift(get(handles.button_trial_7, 'Value'),6), bitshift(get(handles.button_trial_8, 'Value'),7)];
inputs.trial_sequence  = bitor(bitor(bitor(bitor(bitor(bitor(bitor(trial_seq(1), trial_seq(2)),trial_seq(3)), trial_seq(4)),trial_seq(5)),trial_seq(6)),trial_seq(7)),trial_seq(8));


%Trial parameters
inputs.n_pulses = str2double(get(handles.input_n_pulses, 'String'));
inputs.time_window_stim_on = str2double(get(handles.input_time_window_stim_on, 'String'));
inputs.time_window_stim_off = str2double(get(handles.input_time_window_stim_off, 'String'));
inputs.number_trials = str2double(get(handles.input_number_trials, 'String'));
%new parameters
inputs.time_window_read = str2double(get(handles.input_time_window_read, 'String'));
inputs.time_window_stim = str2double(get(handles.input_time_window_stim, 'String'));
inputs.tremor_threshold = str2double(get(handles.input_tremor_threshold, 'String'));
inputs.tremor_detection_muscle = str2double(get(handles.input_tremor_detection_muscle, 'String'));
inputs.threshold_gain_muscle_1 = uint8(str2double(get(handles.input_threshold_gain_muscle_1, 'String'))*10);
inputs.threshold_gain_muscle_2 = uint8(str2double(get(handles.input_threshold_gain_muscle_2, 'String'))*10);
inputs.time_rms = str2double(get(handles.input_time_rms, 'String'));


%Channels amplitude
inputs.stim_channel(1) = str2double(get(handles.input_stim_channel_1, 'String'));
inputs.stim_channel(2) = str2double(get(handles.input_stim_channel_2, 'String'));
inputs.stim_channel(3) = str2double(get(handles.input_stim_channel_3, 'String'));
inputs.stim_channel(4) = str2double(get(handles.input_stim_channel_4, 'String'));
inputs.stim_channel(5) = str2double(get(handles.input_stim_channel_5, 'String'));
inputs.stim_channel(6) = str2double(get(handles.input_stim_channel_6, 'String'));
%new channels
inputs.stim_channel(7) = str2double(get(handles.input_stim_channel_7, 'String'));
inputs.stim_channel(8) = str2double(get(handles.input_stim_channel_8, 'String'));

%Stimulation waveform
inputs.stim_phase = get(get(handles.button_stim_phase_group,'SelectedObject'), 'String');

%MODE
inputs.mode = get(get(handles.button_mode_group,'SelectedObject'), 'String');


%% EMG PARAMETERS
inputs.emg_fs = get(get(handles.button_fs_group,'SelectedObject'), 'String');
%not included in EAST
%inputs.emg_mode = get(get(handles.button_emg_mode_group,'SelectedObject'), 'String');
% emg_ch AND input.emg_ch NEED MODIFICATION FOR NEW CHANNELS
% emg_ch = [get(handles.button_emg_ch1, 'Value'), bitshift(get(handles.button_emg_ch2, 'Value'),1), bitshift(get(handles.button_emg_ch3, 'Value'),2)...
%                  bitshift(get(handles.button_emg_ch4, 'Value'),3), bitshift(get(handles.button_emg_ch5, 'Value'),4),  bitshift(get(handles.button_emg_ch6, 'Value'),5)...
%                  bitshift(get(handles.button_emg_ch7, 'Value'),6), bitshift(get(handles.button_emg_ch8, 'Value'),7)];
% inputs.emg_ch  = bitor(bitor(bitor(bitor(bitor(bitor(bitor(emg_ch(1), emg_ch(2)),emg_ch(3)), emg_ch(4)),emg_ch(5)),emg_ch(6)),emg_ch(7)),emg_ch(8));
inputs.emg_ch  = get(get(handles.button_emg_ch_group,'SelectedObject'), 'String')
inputs.emg_recording_time = str2double(get(handles.input_emg_recording_time, 'String'));

inputs.emg_save = get(handles.button_save_EMG, 'Value');
inputs.emg_file_name = get(handles.input_file_name_EMG, 'String');

end