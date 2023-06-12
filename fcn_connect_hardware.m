%%% Function to open the serial port.


function [hardware_connected serial_port] = fcn_connect_hardware()

%Default parameters to set the port buffer
NumCyc = 10;     % Number of plot cycle
PlotTime = 1;    % Plot time in s
Fsamp = 1000;
NumChan = 16;
offset = 60000;

global port
global inputs
% COM buffer size
NumChTot = 16;
BufSize = Fsamp*PlotTime*2*NumChTot;
NumSamples = Fsamp*PlotTime;

% !!! Set the correct COM number !!!
SerialCOM = 'COM5'; % !!! ATTENTION: Set the proper COM !!!

port = serial(SerialCOM,'baudrate', 921600);

% Serial port settings
set(port, 'timeout', 12);
set(port, 'InputBufferSize', BufSize)
% fopen(port)


serial_port = port;
 try (fopen(port))
    hardware_connected = 1;
    inputs.stop = 0;
catch exception
    disp('NOT ABLE TO CONNECT TO NT')
    hardware_connected = 0;

end