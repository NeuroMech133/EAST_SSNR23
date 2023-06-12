%%% Function to close the serial port.

function hardware_connected = fcn_disconnect_hardware()

delete(instrfindall)

hardware_connected = 0;

end