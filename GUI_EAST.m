%%% GUI for controlling EAST
function varargout = GUI_EAST(varargin)
% GUI_EAST MATLAB code for GUI_EAST.fig
%      GUI_EAST, by itself, creates a new GUI_EAST or raises the existing
%      singleton*.
%
%      H = GUI_EAST returns the handle to a new GUI_EAST or the handle to
%      the existing singleton*.
%
%      GUI_EAST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EAST.M with the given input arguments.
%
%      GUI_EAST('Property','Value',...) creates a new GUI_EAST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_EAST_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_EAST_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_EAST

% Last Modified by GUIDE v2.5 01-Sep-2020 16:58:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_EAST_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_EAST_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_EAST is made visible.
function GUI_EAST_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_EAST (see VARARGIN)

% Choose default command line output for GUI_EAST
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_EAST wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_EAST_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%% START STIMULATION %%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in button_start_stim.
function button_start_stim_Callback(hObject, eventdata, handles)
% hObject    handle to button_start_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global port
global inputs
inputs = fcn_get_parameters_v02(handles);
% command_sent = fcn_start_stim_command(handles.hw1_port, inputs);
command_sent = fcn_start_stim_command(handles);


% --- Executes on button press in button_stop_stim.
function button_stop_stim_Callback(hObject, eventdata, handles)
% hObject    handle to button_stop_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global port
global inputs
inputs = fcn_get_parameters_v02(handles);
inputs.stop = 1;
command_sent = fcn_stop_stim_command();

function input_pulse_width_Callback(hObject, eventdata, handles)
% hObject    handle to input_pulse_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_pulse_width as text
%        str2double(get(hObject,'String')) returns contents of input_pulse_width as a double

density = str2double(get(hObject, 'String'));
if isnan(density)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new input_pulse_width value
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function input_pulse_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_pulse_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_freq_stim_Callback(hObject, eventdata, handles)
% hObject    handle to input_freq_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_freq_stim as text
%        str2double(get(hObject,'String')) returns contents of input_freq_stim as a double


% --- Executes during object creation, after setting all properties.
function input_freq_stim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_freq_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_1_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_1 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_1 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function input_stim_channel_2_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_2 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_2 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_3_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_3 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_3 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_4_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_4 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_4 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_5_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_5 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_5 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_6_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_6 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_6 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_7_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_7 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_7 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_stim_channel_8_Callback(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_stim_channel_8 as text
%        str2double(get(hObject,'String')) returns contents of input_stim_channel_8 as a double


% --- Executes during object creation, after setting all properties.
function input_stim_channel_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_stim_channel_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_connect_hw.
function button_connect_hw_Callback(hObject, eventdata, handles)
% hObject    handle to button_connect_hw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.hw1_connected handles.hw1_port ]= fcn_connect_hardware();
if(handles.hw1_connected == 1)
    set(hObject,'BackgroundColor', [(9/255) (249/255) (17/255)]);
    set(handles.button_disconnect_hw,'BackgroundColor',[0.941 0.941 0.941],'enable','on'); % Green Color
else
    set(hObject,'BackgroundColor', [0.941 0.941 0.941]);
    set(handles.button_disconnect_hw,'BackgroundColor',[(240/255) (10/255) (20/255)],'enable','on'); % Red Color
end

guidata(handles.figure1, handles);


% --- Executes on button press in button_disconnect_hw.
function button_disconnect_hw_Callback(hObject, eventdata, handles)
% hObject    handle to button_disconnect_hw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.hw1_connected = fcn_disconnect_hardware();
if(~handles.hw1_connected)
    set(hObject,'BackgroundColor', [(240/255) (10/255) (20/255)]);
    set(handles.button_connect_hw,'BackgroundColor',[0.941 0.941 0.941],'enable','on'); % Grey Color
end


% --- Executes on button press in button_start_emg.
function button_start_emg_Callback(hObject, eventdata, handles)
% hObject    handle to button_start_emg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global port
global inputs

inputs = fcn_get_parameters_v02(handles);
% command_sent = fcn_start_stim_command(handles.hw1_port, inputs);
command_sent = fcn_start_EMG_command(handles);


% --- Executes on button press in button_stop_emg.
function button_stop_emg_Callback(hObject, eventdata, handles)
% hObject    handle to button_stop_emg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global port
command_sent = fcn_stop_stim_command();



function input_file_name_EMG_Callback(hObject, eventdata, handles)
% hObject    handle to input_file_name_EMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_file_name_EMG as text
%        str2double(get(hObject,'String')) returns contents of input_file_name_EMG as a double


% --- Executes during object creation, after setting all properties.
function input_file_name_EMG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_file_name_EMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_save_EMG.
function button_save_EMG_Callback(hObject, eventdata, handles)
% hObject    handle to button_save_EMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_save_EMG



function input_emg_recording_time_Callback(hObject, eventdata, handles)
% hObject    handle to input_emg_recording_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_emg_recording_time as text
%        str2double(get(hObject,'String')) returns contents of input_emg_recording_time as a double


% --- Executes during object creation, after setting all properties.
function input_emg_recording_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_emg_recording_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_emg_ch2.
function button_emg_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to button_emg_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_emg_ch2


% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13


% --- Executes on button press in button_emg_ch16.
function button_emg_ch16_Callback(hObject, eventdata, handles)
% hObject    handle to button_emg_ch16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_emg_ch16


% --- Executes on button press in button_emg_ch8.
function button_emg_ch8_Callback(hObject, eventdata, handles)
% hObject    handle to button_emg_ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_emg_ch8


% --- Executes on button press in button_emg_ch4.
function button_emg_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to button_emg_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_emg_ch4


% --- Executes on button press in button_trial_1.
function button_trial_1_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_1


% --- Executes on button press in button_trial_2.
function button_trial_2_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_2


% --- Executes on button press in button_trial_3.
function button_trial_3_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_3


% --- Executes on button press in button_trial_4.
function button_trial_4_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_4


% --- Executes on button press in button_trial_5.
function button_trial_5_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_5


% --- Executes on button press in button_trial_6.
function button_trial_6_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_6


% --- Executes on button press in button_trial_7.
function button_trial_7_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_7


% --- Executes on button press in button_trial_8.
function button_trial_8_Callback(hObject, eventdata, handles)
% hObject    handle to button_trial_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_trial_8



function input_time_window_stim_on_Callback(hObject, eventdata, handles)
% hObject    handle to input_time_window_stim_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_time_window_stim_on as text
%        str2double(get(hObject,'String')) returns contents of input_time_window_stim_on as a double


% --- Executes during object creation, after setting all properties.
function input_time_window_stim_on_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_time_window_stim_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_time_window_stim_off_Callback(hObject, eventdata, handles)
% hObject    handle to input_time_window_stim_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_time_window_stim_off as text
%        str2double(get(hObject,'String')) returns contents of input_time_window_stim_off as a double


% --- Executes during object creation, after setting all properties.
function input_time_window_stim_off_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_time_window_stim_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_time_window_read_Callback(hObject, eventdata, handles)
% hObject    handle to input_time_window_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_time_window_read as text
%        str2double(get(hObject,'String')) returns contents of input_time_window_read as a double


% --- Executes during object creation, after setting all properties.
function input_time_window_read_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_time_window_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_time_window_stim_Callback(hObject, eventdata, handles)
% hObject    handle to input_time_window_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_time_window_stim as text
%        str2double(get(hObject,'String')) returns contents of input_time_window_stim as a double


% --- Executes during object creation, after setting all properties.
function input_time_window_stim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_time_window_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_tremor_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to input_tremor_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_tremor_threshold as text
%        str2double(get(hObject,'String')) returns contents of input_tremor_threshold as a double


% --- Executes during object creation, after setting all properties.
function input_tremor_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_tremor_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_tremor_detection_muscle_Callback(hObject, eventdata, handles)
% hObject    handle to input_tremor_detection_muscle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_tremor_detection_muscle as text
%        str2double(get(hObject,'String')) returns contents of input_tremor_detection_muscle as a double


% --- Executes during object creation, after setting all properties.
function input_tremor_detection_muscle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_tremor_detection_muscle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_n_pulses_Callback(hObject, eventdata, handles)
% hObject    handle to input_n_pulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_n_pulses as text
%        str2double(get(hObject,'String')) returns contents of input_n_pulses as a double

volume = str2double(get(hObject, 'String'));
if isnan(volume)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new input_n_pulses value
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function input_n_pulses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_n_pulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_number_trials_Callback(hObject, eventdata, handles)
% hObject    handle to input_number_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_number_trials as text
%        str2double(get(hObject,'String')) returns contents of input_number_trials as a double


% --- Executes during object creation, after setting all properties.
function input_number_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_number_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_threshold_gain_muscle_1_Callback(hObject, eventdata, handles)
% hObject    handle to input_threshold_gain_muscle_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_threshold_gain_muscle_1 as text
%        str2double(get(hObject,'String')) returns contents of input_threshold_gain_muscle_1 as a double


% --- Executes during object creation, after setting all properties.
function input_threshold_gain_muscle_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_threshold_gain_muscle_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_threshold_gain_muscle_2_Callback(hObject, eventdata, handles)
% hObject    handle to input_threshold_gain_muscle_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_threshold_gain_muscle_2 as text
%        str2double(get(hObject,'String')) returns contents of input_threshold_gain_muscle_2 as a double


% --- Executes during object creation, after setting all properties.
function input_threshold_gain_muscle_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_threshold_gain_muscle_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_time_rms_Callback(hObject, eventdata, handles)
% hObject    handle to input_time_rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_time_rms as text
%        str2double(get(hObject,'String')) returns contents of input_time_rms as a double


% --- Executes during object creation, after setting all properties.
function input_time_rms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_time_rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
