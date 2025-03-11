function mpc = case15p3()
% data file of 15 bus multi-phase unbalanced distribution network 

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data																						
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22
% item	Bus_I	 Bus_Type	 Sa	Sb	Sc	Bs_a	Bs_b	Bs_c	Area	Vm_a	Vm_b	Vm_c	Va_a	Va_b	Va_c	Base_kV	Zone	Vmax	Vmin	Status_a	Status_b	Status_c
% unit	/	/	MVA	MVA	MVA	MVA	MVA	MVA	/	p.u.	p.u.	p.u.	angle	angle	angle	kV	/	p.u.	p.u.	/	/	/
mpc.bus = [	% ATTENTION: Sa, Sb and Sc are specified in kVA here, converted to MVA at the end of the file																					
	1	3	0	0	0	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	2	1	86.83200 + 1j* 52.05600	80.78400 + 1j* 48.38400	48.81600 + 1j* 29.37600	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	3	1	52.48800 + 1j* 23.32800	90.50400 + 1j* 40.17600	51.84000 + 1j* 23.11200	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	4	1	89.20800 + 1j* 59.61600	78.40800 + 1j* 52.27200	92.01600 + 1j* 61.34400	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	5	1	67.17600 + 1j* 29.80800	71.71200 + 1j* 31.96800	55.72800 + 1j* 24.84000	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	6	1	73.00800 + 1j* 32.40000	53.13600 + 1j* 23.76000	68.47200 + 1j* 30.45600	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	7	1	50.54400 + 1j* 28.08000	81.43200 + 1j* 45.36000	62.64000 + 1j* 34.99200	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	8	1	360.9360 + 1j* 171.9360	241.9200 + 1j* 115.3440	304.7700 + 1j* 145.1520	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	9	1	73.00800 + 1j* 32.40000	53.13600 + 1j* 23.76000	68.47200 + 1j* 30.45600	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	10	1	50.54400 + 1j* 28.08000	81.43200 + 1j* 45.36000	62.64000 + 1j* 34.99200	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	11	1	360.9360 + 1j* 171.9360	241.9200 + 1j* 115.3440	304.7700 + 1j* 145.1520	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	12	1	266.3280 + 1j* 127.0080	321.6000 + 1j* 153.1440	319.4400 + 1j* 152.2800	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	13	1	32.18400 + 1j* 18.79200	48.16800 + 1j* 28.08000	49.68000 + 1j* 28.94400	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	14	1	39.09600 + 1j* 16.41600	40.60800 + 1j* 17.06400	50.32800 + 1j* 20.95200	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
	15	1	46.44000 + 1j* 15.55200	40.39200 + 1j* 13.60800	43.20000 + 1j* 14.47200	0	0	0	1	1	1	1	0	-120	120	20	1	1.1	0.9	1	1	1
];																						

																	
%% branch data																	
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17
% item	FBus	TBus	Zaa	Zbb	Zcc	Zab	Zbc	Zca	Bc_a	Bc_b	Bc_c	StatusBranch_a	StatusBranch_b	StatusBranch_c	Imax_a	Imax_b	Imax_c
% unit	/	/	p.u.	p.u.	p.u.	p.u.	p.u.	p.u.	p.u.	p.u.	p.u.	/	/	/	p.u.	p.u.	p.u.
mpc.branch = [																	
	1	2	0.3460 + 1j* 0.1765	0.3452 + 1j* 0.1758	0.3445 + 1j* 0.1754	0.0033 + 1j* 0.0015	0.0041 + 1j* 0.0019	0.0048 + 1j* 0.0026	0	0	0	1	1	1	0.032	0.032	0.032
	2	3	1.8511 + 1j* 0.9428	1.8459 + 1j* 0.9402	1.8422 + 1j* 0.9383	0.0181 + 1j* 0.0093	0.0218 + 1j* 0.0111	0.0270 + 1j* 0.0137	0	0	0	1	1	1	0.032	0.032	0.032
	3	4	1.3742 + 1j* 0.6997	1.3705 + 1j* 0.6978	1.3675 + 1j* 0.6963	0.0133 + 1j* 0.0067	0.0159 + 1j* 0.0081	0.0200 + 1j* 0.0100	0	0	0	1	1	1	0.032	0.032	0.032
	4	5	1.4312 + 1j* 0.7289	1.4267 + 1j* 0.7267	1.4241 + 1j* 0.7252	0.0141 + 1j* 0.0070	0.0166 + 1j* 0.0085	0.0211 + 1j* 0.0107	0	0	0	1	1	1	0.032	0.032	0.032
	5	6	3.0754 + 1j* 2.6551	3.0666 + 1j* 2.6470	3.0603 + 1j* 2.6418	0.0300 + 1j* 0.0259	0.0363 + 1j* 0.0311	0.0451 + 1j* 0.0392	0	0	0	1	1	1	0.012	0.012	0.012
	6	7	0.7030 + 1j* 2.3236	0.7008 + 1j* 2.3169	0.6993 + 1j* 2.3121	0.0067 + 1j* 0.0226	0.0081 + 1j* 0.0274	0.0104 + 1j* 0.0340	0	0	0	1	1	1	0.012	0.012	0.012
	7	8	2.6714 + 1j* 0.8828	2.6636 + 1j* 0.8802	2.6585 + 1j* 0.8784	0.0263 + 1j* 0.0085	0.0315 + 1j* 0.0104	0.0392 + 1j* 0.0130	0	0	0	1	1	1	0.012	0.012	0.012
	8	9	3.8680 + 1j* 2.7787	3.8565 + 1j* 2.7706	3.8491 + 1j* 2.7650	0.0381 + 1j* 0.0274	0.0455 + 1j* 0.0326	0.0570 + 1j* 0.0407	0	0	0	1	1	1	0.012	0.012	0.012
	9	10	3.9205 + 1j* 2.7787	3.9091 + 1j* 2.7706	3.9013 + 1j* 2.7650	0.0385 + 1j* 0.0274	0.0463 + 1j* 0.0326	0.0577 + 1j* 0.0407	0	0	0	1	1	1	0.012	0.012	0.012
	10	11	0.7382 + 1j* 0.2438	0.7359 + 1j* 0.2431	0.7345 + 1j* 0.2427	0.0070 + 1j* 0.0022	0.0085 + 1j* 0.0026	0.0107 + 1j* 0.0033	0	0	0	1	1	1	0.012	0.012	0.012
	11	12	1.4060 + 1j* 0.4647	1.4016 + 1j* 0.4632	1.3990 + 1j* 0.4625	0.0137 + 1j* 0.0044	0.0163 + 1j* 0.0052	0.0207 + 1j* 0.0067	0	0	0	1	1	1	0.012	0.012	0.012
	12	5	5.5130 + 1j* 4.3375	5.4967 + 1j* 4.3246	5.4856 + 1j* 4.3161	0.0540 + 1j* 0.0426	0.0651 + 1j* 0.0511	0.0814 + 1j* 0.0640	0	0	0	1	1	1	0.012	0.012	0.012
	4	9	2.0339 + 1j* 2.6770	2.0276 + 1j* 2.6692	2.0239 + 1j* 2.6640	0.0200 + 1j* 0.0263	0.0237 + 1j* 0.0315	0.0300 + 1j* 0.0392	0	0	0	1	1	1	0.012	0.012	0.012
	13	14	2.2193 + 1j* 1.9751	2.2126 + 1j* 1.9695	2.2085 + 1j* 1.9654	0.0218 + 1j* 0.0192	0.0259 + 1j* 0.0233	0.0326 + 1j* 0.0289	0	0	0	1	1	1	0.012	0.012	0.012
	14	15	2.7802 + 1j* 2.0465	2.7717 + 1j* 2.0406	2.7665 + 1j* 2.0365	0.0274 + 1j* 0.0200	0.0326 + 1j* 0.0240	0.0411 + 1j* 0.0300	0	0	0	1	1	1	0.012	0.012	0.012
	15	9	4.8407 + 1j* 6.4632	4.8263 + 1j* 6.4439	4.8167 + 1j* 6.4313	0.0474 + 1j* 0.0636	0.0570 + 1j* 0.0762	0.0714 + 1j* 0.0955	0	0	0	1	1	1	0.012	0.012	0.012
	1	13	2.7487 + 1j* 2.1556	2.7406 + 1j* 2.1490	2.7354 + 1j* 2.1449	0.0270 + 1j* 0.0211	0.0322 + 1j* 0.0252	0.0403 + 1j* 0.0318	0	0	0	1	1	1	0.012	0.012	0.012
];																	
																

% ATTENTION: the power of DERs are specified in kW/kVar here, converted to MW/MVar at the end of the file
% synchronous generators																													
mpc.gen = [																													
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26			
% item	GenBus	Pgen	Qgen	Qgen_max	Qgen_min	Vgen	mBase	genStatus	Pgen_max	Pgen_min	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	GenRamp	connectionType	genStatus1	genStatus2	genStatus3	Sgen_max	Pfmax	gen_cost2	gen_cost1	gen_cost0			
% unit	/	MW	Mvar	Mvar	Mvar	p.u.	kV	/	MW	MW	MW	MW	Mvar	Mvar	Mvar	Mvar	MW/15min	/	/	/	/	MVA	/	$/WM^2h	$/WMh	$/h			
	5	0	0	750.0000 	-750.0000 	1	25	1	600	0	600	0	-450.0000 	450.0000 	-750.0000 	750.0000 	120	1	1	1	1	750.0000 	0.8	0	0	0			
	8	0	0	625.0000 	-625.0000 	1	25	1	500	0	500	0	-375.0000 	375.0000 	-625.0000 	625.0000 	100	1	1	1	1	625.0000 	0.8	0	0	0			
	9	0	0	375.0000 	-375.0000 	1	25	1	300	0	300	0	-225.0000 	225.0000 	-375.0000 	375.0000 	60	1	1	1	1	375.0000 	0.8	0	0	0			
	10	0	0	500.0000 	-500.0000 	1	25	1	400	0	400	0	-300.0000 	300.0000 	-500.0000 	500.0000 	80	1	0	1	0	500.0000 	0.8	0	0	0			
];																																																									
																													
																													
% energy storage system																													
mpc.ESS = [																													
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29
% item	GenBus	Pgen	Qgen	Qgen_max	Qgen_min	Vgen	mBase	genStatus	Pgen_max	Pgen_min	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	GenRamp	connectionType	genStatus1	genStatus2	genStatus3	Sgen_max	Pfmax	ESScap	SOC_init	SOC_max	SOC_min	ESScharge_cost	ESSdischarge_cost
% unit	/	MW	Mvar	Mvar	Mvar	p.u.	kV	/	MW	MW	MW	MW	Mvar	Mvar	Mvar	Mvar	MW/15min	/	/	/	/	MVA	/	MWH	p.u.	p.u.	p.u.	$/WMh	$/WMh
	5	0	0	625.0000 	-625.0000 	1	25	1	500	-500	500	-500.0000 	-375.0000 	375.0000 	-375.0000 	375.0000 	0	0	1	1	1	625.0000 	0.8	1500	0.5	0.9	0.2	0	0
	12	0	0	875.0000 	-875.0000 	1	25	1	700	-700	700	-700.0000 	-525.0000 	525.0000 	-525.0000 	525.0000 	0	0	1	1	1	875.0000 	0.8	2100	0.5	0.9	0.2	0	0
	10	0	0	1000.0000 	-1000.0000 	1	25	1	800	-800	800	-800.0000 	-600.0000 	600.0000 	-600.0000 	600.0000 	0	0	1	1	1	1000.0000 	0.8	3200	0.45	0.9	0.2	0	0
];																													
																													
																													
% wind turbine																													
mpc.WT = [																													
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26			
% item	GenBus	Pgen	Qgen	Qgen_max	Qgen_min	Vgen	mBase	genStatus	Pgen_max	Pgen_min	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	GenRamp	connectionType	genStatus1	genStatus2	genStatus3	Sgen_max	Pfmax	Pfmin	DREmainten_cost	DREcurtail_cost			
% unit	/	MW	Mvar	Mvar	Mvar	p.u.	kV	/	MW	MW	MW	MW	Mvar	Mvar	Mvar	Mvar	MW/15min	/	/	/	/	MVA	/	/	$/WMh	$/WMh			
	7	0	0	333.3333333	-666.6666667	1	25	1	1000	0	1000	313.6929 	-750.0000 	583.3333 	-1209.9987 	1043.3320 	0	0	1	1	1	1250.0000 	0.8	0.5	0	0			
];																													
																													
																													
% photovoltatics																													
mpc.PV = [																													
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26			
% item	GenBus	Pgen	Qgen	Qgen_max	Qgen_min	Vgen	mBase	genStatus	Pgen_max	Pgen_min	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	GenRamp	connectionType	genStatus1	genStatus2	genStatus3	Sgen_max	Pfmax	Pfmin	DREmainten_cost	DREcurtail_cost			
% unit	/	MW	Mvar	Mvar	Mvar	p.u.	kV	/	MW	MW	MW	MW	Mvar	Mvar	Mvar	Mvar	MW/15min	/	/	/	/	MVA	/	/	$/WMh	$/WMh			
	3	0	0	487.1393 	-487.1393 	1	25	1	450	0	450	281.2500 	-337.5000 	337.5000 	-487.1393 	487.1393 	0	0	1	0	0	562.5000 	0.8	0.5	0	0			
	6	0	0	541.2659 	-541.2659 	1	25	1	500	0	500	312.5000 	-375.0000 	375.0000 	-541.2659 	541.2659 	0	0	0	0	1	625.0000 	0.8	0.5	0	0			
	8	0	0	595.3925 	-595.3925 	1	25	1	550	0	550	343.7500 	-412.5000 	412.5000 	-595.3925 	595.3925 	0	0	0	1	0	687.5000 	0.8	0.5	0	0			
	9	0	0	606.2178 	-606.2178 	1	25	1	560	0	560	350.0000 	-420.0000 	420.0000 	-606.2178 	606.2178 	0	0	0	1	0	700.0000 	0.8	0.5	0	0			
	11	0	0	584.5671 	-584.5671 	1	25	1	540	0	540	337.5000 	-405.0000 	405.0000 	-584.5671 	584.5671 	0	0	1	0	0	675.0000 	0.8	0.5	0	0			
];																													
																													
% HVAC																													
mpc.HVAC = [																													
% idx	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22							
% item	GenBus	Pgen	Qgen	Qgen_max	Qgen_min	Vgen	mBase	genStatus	Pgen_max	Pgen_min	Tinit	Tmax	Tmin	Alpha	Beta	Pf_const	GenRamp	connectionType	genStatus1	genStatus2	genStatus3	DRcost							
% unit	/	MW	Mvar	Mvar	Mvar	p.u.	kV	/	MW	MW	K	K	K	/	K/MW*15min	/	MW/15min	/	/	/	/	$/WMh							
	4	0	0	131.4736421	0	1	25	1	400	0	20	28	22	0.1	10	0.95	0	0	1	1	1	0							
	6	0	0	147.9078473	0	1	25	1	450	0	20	28	22	0.1	8.888888889	0.95	0	0	1	1	1	0							
	8	0	0	131.4736421	0	1	25	1	400	0	20	28	22	0.08	10	0.95	0	0	1	1	1	0							
	14	0	0	115.0394368	0	1	25	1	350	0	20	28	22	0.08	11.42857143	0.95	0	0	1	1	1	0							
];																																																							
																										
																																																																																		


define_idx;
% convert the unit from kVA to MVA
mpc.bus(:,[Sa,Sb,Sc]) = mpc.bus(:,[Sa,Sb,Sc]) / 1e3; % kVA -> MVA

Pgen_idx = [Pgen,Qgen,Qgen_max,Qgen_min,Pgen_max,Pgen_min,...
	Pc1,Pc2,Qc1min,Qc1max,Qc2min,Qc2max,GenRamp,Sgen_max];
mpc.gen(:,Pgen_idx) = mpc.gen(:,Pgen_idx) / 1e3; % kVA -> MVA
mpc.WT(:,Pgen_idx) = mpc.WT(:,Pgen_idx) / 1e3; % kVA -> MVA
mpc.PV(:,Pgen_idx) = mpc.PV(:,Pgen_idx) / 1e3; % kVA -> MVA

Pess_idx = [Pgen,Qgen,Qgen_max,Qgen_min,Pgen_max,Pgen_min,...
	Pc1,Pc2,Qc1min,Qc1max,Qc2min,Qc2max,GenRamp,Sgen_max,ESScap];
mpc.ESS(:,Pess_idx) = mpc.ESS(:,Pess_idx) / 1e3; % kVA -> MVA

Phvac_idx = [Qgen_max,Qgen_min,Pgen_max,Pgen_min];
mpc.HVAC(:,Phvac_idx) = mpc.HVAC(:,Phvac_idx) / 1e3; % kVA -> MVA



