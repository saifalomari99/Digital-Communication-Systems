
% Software Lab 2.1 - Part 1.5
% QPSK Downconversion with theta = pi/4

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

% Generate baseband signals
uc = repelem(bc, sps);
us = repelem(bs, sps);

% QPSK modulation
up = uc .* cos(2*pi*fc*t) ...
    - us .* sin(2*pi*fc*t);

% Downconversion with theta = pi/4
I_mixed = 2*up .* cos(2*pi*fc*t + theta);
Q_mixed = 2*up .* sin(2*pi*fc*t + theta);

% Crude low-pass filter
% h(t) = 1 for 0 <= t <= 0.25
filter_duration = 0.25;
L = round(filter_duration*sps);
h = ones(1, L) * dt;

% Filter the downconverted signals
vc = filter(h, 1, I_mixed);
vs = filter(h, 1, Q_mixed);

% Plot original and recovered signals
figure;

subplot(2,1,1);
stairs(t, uc, 'b', 'LineWidth', 1.2);
hold on;
plot(t, vc, 'r', 'LineWidth', 1.5);
title('Part 1.5: In-Phase Downconversion (theta = pi/4)');
xlabel('Time');
ylabel('Amplitude');
legend('Original u_c(t)', 'Recovered v_c(t)');
xlim([0 10]);
ylim([-1.5 1.5]);
grid on;

subplot(2,1,2);
stairs(t, us, 'b', 'LineWidth', 1.2);
hold on;
plot(t, vs, 'r', 'LineWidth', 1.5);
title('Part 1.5: Quadrature Downconversion (theta = pi/4)');
xlabel('Time');
ylabel('Amplitude');
legend('Original u_s(t)', 'Recovered v_s(t)');
xlim([0 10]);
ylim([-1.5 1.5]);
grid on;
