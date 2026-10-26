
% Software Lab 2.1 - Part 1.6
% Correcting QPSK Carrier Phase Offset

clear; clc; close all;
rng(1);

% Parameters
N = 100;
sps = 1000;
fc = 20;
theta = pi/4;

% Generate independent random symbols (+1 or -1)
bc = 2*randi([0 1], 1, N) - 1;
bs = 2*randi([0 1], 1, N) - 1;

% Time vector
t = (0:N*sps-1)/sps;
dt = 1/sps;

% Generate original baseband signals
uc = repelem(bc, sps);
us = repelem(bs, sps);

% QPSK modulation
up = uc .* cos(2*pi*fc*t) ...
    - us .* sin(2*pi*fc*t);

% Downconversion with phase offset theta
I_mixed = 2*up .* cos(2*pi*fc*t + theta);
Q_mixed = 2*up .* sin(2*pi*fc*t + theta);

% Low-pass filtering
filter_duration = 0.25;
L = round(filter_duration*sps);
h = ones(1, L) * dt;

vc = filter(h, 1, I_mixed);
vs = filter(h, 1, Q_mixed);

% Correct the known phase offset
uc_reconstructed = 4 * (vc*cos(theta) + vs*sin(theta));
us_reconstructed = 4 * (vc*sin(theta) - vs*cos(theta));

% Plot original and reconstructed signals
figure;

subplot(2,1,1);
stairs(t, uc, 'b', 'LineWidth', 1.2);
hold on;
plot(t, uc_reconstructed, 'r', 'LineWidth', 1.5);
title('Part 1.6: Reconstructed In-Phase Signal');
xlabel('Time');
ylabel('Amplitude');
legend('Original u_c(t)', 'Reconstructed u_c(t)');
xlim([0 10]);
ylim([-1.5 1.5]);
grid on;

subplot(2,1,2);
stairs(t, us, 'b', 'LineWidth', 1.2);
hold on;
plot(t, us_reconstructed, 'r', 'LineWidth', 1.5);
title('Part 1.6: Reconstructed Quadrature Signal');
xlabel('Time');
ylabel('Amplitude');
legend('Original u_s(t)', 'Reconstructed u_s(t)');
xlim([0 10]);
ylim([-1.5 1.5]);
grid on;
