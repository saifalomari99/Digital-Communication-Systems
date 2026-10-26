
% Software Lab 2.1 - Part 1.1
clear; clc; close all;

% Parameters
N = 100;          % Total number of symbols
sps = 1000;        % Samples per symbol

% Generate independent random symbols (+1 or -1)
bc = 2*randi([0 1], 1, N) - 1;
bs = 2*randi([0 1], 1, N) - 1;

% Generate baseband signals
uc = repelem(bc, sps);
us = repelem(bs, sps);

% Time vector
t = (0:N*sps-1)/sps;




% Part 1.2: Upconversion with cosine carrier

fc = 20;                      % Carrier frequency
carrier = cos(2*pi*fc*t);     % cos(40*pi*t)

% Multiply the baseband signal by the carrier
up1 = uc .* carrier;





% Part 1.3: QPSK Modulation

% Generate sine carrier
sine_carrier = sin(2*pi*fc*t);

% Combine in-phase and quadrature components
up = uc .* carrier - us .* sine_carrier;

% Plot the first 4 symbols
figure;
plot(t, up, 'b', 'LineWidth', 1.2);
title('Part 1.3: QPSK Passband Signal u_p(t)');
xlabel('Time');
ylabel('Amplitude');
xlim([0 4]);
ylim([-1.6 1.6]);
grid on;
