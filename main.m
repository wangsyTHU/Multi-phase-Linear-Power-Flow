% author: Siyuan Wang
% Date : 2020-07-08
%
% REFERENCES:
% A. Bernstein and E. Dall'Anese, "Linear power-flow models in multiphase distribution networks,"
% in 2017 IEEE PES Innovative Smart Grid Technologies Conference Europe (ISGT-Europe), Sep. 2017
% doi: 10.1109/ISGTEurope.2017.8260205.


clear;clc;close all

mpc = case15p3;
coef = mplpf(mpc);

%   where
%
%   x_wye = [P_wye; Q_wye];
%   x_delt = [P_delt; Q_delt];
%
%    V = coef.M_wye * x_wye + coef.M_delt * x_delt + coef.coe_a
%   |V|= coef.K_wye * x_wye + coef.K_delt * x_delt + coef.coe_b
%   s0 = coef.G_wye * x_wye + coef.G_delt * x_delt + coef.coe_c
%    I = coef.J_wye * x_wye + coef.J_delt * x_delt + coef.coe_d

