function [h, hi] = massiveMIMOdl(center_freq)

s = qd_simulation_parameters;
s.center_frequency = center_freq;      
s.show_progress_bars = 0;                      % Disable progress bars

l = qd_layout( s );                            % New QuaDRiGa layout
l.tx_position = [0 0 25]';                     % 25 m BS height
l.no_rx = 10;                                  % 10 MTs
l.randomize_rx_positions(200, 1.5, 1.5, 0);    % Assign random user positions
l.rx_position(1,:) = l.rx_position(1,:) + 220; % Place users east of the BS
% l.set_scenario('3GPP_38.901_UMi_NLOS');        % Use NLOS scenario
l.set_scenario('BERLIN_UMa_NLOS');             % Use NLOS scenario

floor = randi(5,1,l.no_rx) + 3;                 % Set random floor levels
for n = 1:l.no_rx
    floor( n ) =  randi(  floor( n ) );
end
l.rx_position(3,:) = 3*(floor-1) + 1.5;


%% Antenna set-up
% Two different antenna configurations are used at the BS. The antenna array
% uses 64 dual-polarized elements in a 8x8 massive-MIMO array configuration.
% The antennas are assigned to the BS by an array of "qd_arrayant" objects. 
% There is only 1 BS in the layout. The mobile terminal uses a vertically
% polarized omni-directional antenna for both frequencies.
array  = qd_arrayant( '3gpp-3d',  4, 4, s.center_frequency, 1 );

l.rx_array = array;                           % Set 2.5 GHz rx antenna
l.tx_array = qd_arrayant('omni');             % Set omni-tx antenna

%% Generate channel coefficients
% Channel coefficients are generated by calling "l.get_channels". 
% The output is an array of QuaDRiGa channel objects.

channels = l.get_channels;

coeff7 = channels(7,1).coeff;
coeff9 = channels(9,1).coeff;

h = sum(coeff7, 3);
hi = sum(coeff9, 3);

end
