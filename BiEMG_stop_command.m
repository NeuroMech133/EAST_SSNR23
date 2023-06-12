%%% Function to send the STOP command to EAST.

function BiEMG_stop_command()

ConfString = [];

ConfString(1) = 25;
ConfString(2) = 0;
ConfString(3) = 0;
ConfString(4) = 33;
ConfString(5) = 17;

% BYTE 6-13. Stimulation amplitude.
for i = 1 : 8
    ConfString(5+i) = 0;
end

ConfString(14) =  0;
ConfString(15) =  0;
ConfString(16) =  0;
ConfString(17) =  0;
ConfString(18) =  0;
ConfString(19) =  0;
ConfString(20) =  0;
ConfString(21) =  0;
ConfString(22) =  0;
ConfString(23) =  0;
ConfString(24) =  0;
ConfString(25) = CRC8(ConfString, 24);

% Send command via serial port
fwrite(port, ConfString, 'uint8')
end