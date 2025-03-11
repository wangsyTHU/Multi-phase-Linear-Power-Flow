function coef = mplpf(mpc,Sbus0)
% calculate the approximate linear power flow of a multi-phase unbalanced distribution network
% author: Siyuan Wang
% Date : 2020-07-04
%
% REFERENCES:
% A. Bernstein and E. Dall'Anese, "Linear power-flow models in multiphase distribution networks,"
% in 2017 IEEE PES Innovative Smart Grid Technologies Conference Europe (ISGT-Europe), Sep. 2017
% doi: 10.1109/ISGTEurope.2017.8260205.
%
% DEMOS:
% coef = mplpf(mpc,Sbus0);
% coef = mplpf(mpc);
%
% OUTPUT: linear format coefficient matrics
%  V = M_wye * x_wye + M_delt * x_delt + coe_a
% |V|= K_wye * x_wye + K_delt * x_delt + coe_b
% s0 = G_wye * x_wye + G_delt * x_delt + coe_c
%  I = J_wye * x_wye + J_delt * x_delt + coe_d

% clc;clear;close all
% mpc = case33p3();

	show_test_result = 0; % whether to plot the comparision result between AC and DC power flow

	define_idx;
	[bus2wye,  bus2delt] = busIdxMat(mpc);
	% calcualte the accurate AC power flow result at a given operation point Sbus
	if nargin == 2
		Sbus = Sbus0;
	elseif nargin == 1
		Sbus = makeSbusp3(mpc);
		disp('Use the default injection complex power as base value of Sbus0')
	end
	results = mpACpf(mpc,Sbus);

	branch = results.branch;
	bus = results.bus;
	baseMVA = results.baseMVA;
	Ybus = results.Ybus;

	bus_status = bus(:,[Status_a,Status_b,Status_c]);
	branch_status = branch(:,[StatusBranch_a,StatusBranch_b,StatusBranch_c]);

	branch_num = size(branch,1);
	bus_num = size(bus,1);
	phase_num = sum(sum(bus_status));
	line_num = sum(sum(branch_status));
	delt_num = 0;
	for k = 2:bus_num
		busk_status = bus(k,[Status_a,Status_b,Status_c]);
		switch sum(busk_status)
			case 3
				delt_num = delt_num + 3;
			case 2
				delt_num = delt_num + 1;
		end
	end

	Vbus_sp = bus(:,[Vm_a,Vm_b,Vm_c]).* exp(1j*pi/180*bus(:,[Va_a,Va_b,Va_c]));
	Vbus_sp = Vbus_sp.';
	Vbus_sp = Vbus_sp(bus_status.'==1);
	Vbus_sp = Vbus_sp(4:end);

	Vbus0 = [1;exp(-1j*pi*2/3);exp(1j*pi*2/3)];
	Ybus00 = Ybus(1:3,1:3);
	Ybus0L = Ybus(1:3,4:end);
	YbusL0 = Ybus(4:end,1:3);
	YbusLL = Ybus(4:end,4:end);
	% zero-load voltage
	Vbus_0load = -YbusLL \ YbusL0 * Vbus0;

	% construct matrix H (the transfer matrix between wye and delta)
	MatH = sparse(delt_num,size(YbusLL,1));
	delt_idx = 1;
	for k = 2:bus_num
		phase_idx = bus2wye(k,:) - 3;
		busk_status = bus_status(k,:);
		Hwise = [1 -1 0; 0 1 -1; -1 0 1];
		switch sum(busk_status)
			case 3
				MatH(delt_idx:delt_idx+2,phase_idx) = Hwise;
				delt_idx = delt_idx + 3;
			case 2
				phase_idx(phase_idx<0) = [];
				if busk_status(1) == 0
					MatH(delt_idx,phase_idx) = [1,-1];
				elseif busk_status(2) == 0
					MatH(delt_idx,phase_idx) = [-1,1];
				elseif busk_status(3) == 0
					MatH(delt_idx,phase_idx) = [1,-1];
				end
				delt_idx = delt_idx + 1;
		end
	end

	% calculate the linear coefficient matrix

	% x_wye = [P_wye;Q_wye];
	% x_delt = [P_delt;Q_delt];

	% V = M_wye * x_wye + M_delt * x_delt + coe_a
	coe_a = Vbus_0load;
	M_wye = YbusLL \ inv(diag(conj(Vbus_sp)));
	M_wye = [M_wye,-1j*M_wye];
	M_delt = YbusLL \ MatH.' * inv(diag(MatH*conj(Vbus_sp)));
	M_delt = [M_delt,-1j*M_delt];

	% |V|= K_wye * x_wye + K_delt * x_delt + coe_b
	W = diag(Vbus_0load);
	K_wye = abs(W) * real(W\M_wye);
	K_delt = abs(W) * real(W\M_delt);
	coe_b = abs(Vbus_0load);

	% s0 = G_wye * x_wye + G_delt * x_delt + coe_c 
	% s0 : ouput power at substation
	G_wye = diag(Vbus0)*conj(Ybus0L*M_wye);
	G_delt = diag(Vbus0)*conj(Ybus0L*M_delt);
	coe_c = diag(Vbus0)*conj(Ybus00*Vbus0+Ybus0L*coe_a);

	% I  = J_wye * x_wye + J_delt * x_delt + coe_d
	J_wye = zeros(line_num,size(M_wye,2));
	J_delt = zeros(line_num,size(M_delt,2));
	coe_d = zeros(line_num,1);
	line_idx = 1;
	for k = 1:branch_num
		branchk_status = branch_status(k,:);
		n = sum(branchk_status);
		z = [branch(k,Zaa),branch(k,Zab),branch(k,Zca)
			 branch(k,Zab),branch(k,Zbb),branch(k,Zbc)
			 branch(k,Zca),branch(k,Zbc),branch(k,Zcc)];
		for p = 3:-1:1
			if  branchk_status(p) ~= 1
				z(p,:) = [];
				z(:,p) = [];
			end
		end

		fbus = branch(k,FBus);
		if fbus ~= 1
			MatEi = sparse(n,phase_num-3);
			fidx = bus2wye(fbus,:) - 3;
			fidx = fidx(branchk_status>0);
			MatEi(:,fidx) = eye(n);
		end

		tbus = branch(k,TBus);
		if tbus ~= 1
			MatEj = sparse(n,phase_num-3);
			tidx = bus2wye(tbus,:) - 3;
			tidx = tidx(branchk_status>0);
			MatEj(:,tidx) = eye(n);
		end

		if (fbus == 1)||(tbus == 1)
			MatSign = 1;
			if tbus == 1 % fbus is the default root bus, otherwise transfer the postion
				tbus = fbus;
				MatEj = MatEi;
				MatSign = -1;
			end
			J_wye(line_idx:line_idx+n-1,:) = -z\MatEj*M_wye*MatSign;
			J_delt(line_idx:line_idx+n-1,:) = -z\MatEj*M_delt*MatSign;
			coe_d(line_idx:line_idx+n-1) = (z\Vbus0 - z\MatEj*Vbus_0load)*MatSign;
		else
			tempMat = z\MatEi - z\MatEj;
			J_wye(line_idx:line_idx+n-1,:) = tempMat * M_wye;
			J_delt(line_idx:line_idx+n-1,:) = tempMat * M_delt;
			coe_d(line_idx:line_idx+n-1) = tempMat * Vbus_0load;
		end

		line_idx = line_idx + n;
	end

	% collect coef results
	coef.M_wye  = M_wye ;
	coef.K_wye  = K_wye ;
	coef.G_wye  = -sum(G_wye,1) ; % ouput power at substation
	coef.J_wye  = J_wye ;
	coef.M_delt = M_delt;
	coef.K_delt = K_delt;
	coef.G_delt = -sum(G_delt,1);
	coef.J_delt = J_delt;
	coef.coe_a  = coe_a ;
	coef.coe_b  = coe_b ;
	coef.coe_c  = -sum(coe_c,1) ;
	coef.coe_d  = coe_d ;

	% test the calculation results
	if show_test_result
		% generate another random Sbus
		Sbus1 = abs(Sbus).*rand(size(Sbus))*2 .* exp(1j*2*pi*rand(size(Sbus)));

		x_wye = [real(Sbus1(4:end));imag(Sbus1(4:end))];
		x_delt = zeros(delt_num*2,1);

		V_linear = M_wye * x_wye + M_delt * x_delt + coe_a;
		Vmag_linear = K_wye * x_wye + K_delt * x_delt + coe_b;
		s0_linear = G_wye * x_wye + G_delt * x_delt + coe_c;
		I_linear  = J_wye * x_wye + J_delt * x_delt + coe_d;

		res = mpACpf(mpc,Sbus1);

		% compare the results of |V|
		figure(1)
		subplot(3,1,1)
		title('comparision of |V|')
		hold on
		plot([1;Vmag_linear(1:3:end)])
		plot(res.bus(:,Vm_a))
		legend('linear power flow','AC power flow')

		subplot(3,1,2)
		hold on
		plot([1;Vmag_linear(2:3:end)])
		plot(res.bus(:,Vm_b))
		legend('linear power flow','AC power flow')

		subplot(3,1,3)
		hold on
		plot([1;Vmag_linear(3:3:end)])
		plot(res.bus(:,Vm_c))
		legend('linear power flow','AC power flow')

		% compare the results of angle(V)
		Va_linear = angle(V_linear)/pi*180;
		figure(2)
		subplot(3,1,1)
		title('comparision of angle(V)')
		hold on
		plot([0;Va_linear(1:3:end)])
		plot(res.bus(:,Va_a))
		legend('linear power flow','AC power flow')

		subplot(3,1,2)
		hold on
		plot([-120;Va_linear(2:3:end)])
		plot(res.bus(:,Va_b))
		legend('linear power flow','AC power flow')

		subplot(3,1,3)
		hold on
		plot([120;Va_linear(3:3:end)])
		plot(res.bus(:,Va_c))
		legend('linear power flow','AC power flow')

		% compare the results of |Iij|
		n = floor(length(I_linear)/3);
		figure(3)
		subplot(3,1,1)
		title('comparision of |I_{ij}|')
		hold on
		plot(abs(I_linear(1:3:end)))
		plot(abs(res.branch(1:n,I_a)))
		legend('linear power flow','AC power flow')
		
		subplot(3,1,2)
		hold on
		plot(abs(I_linear(2:3:end)))
		plot(abs(res.branch(1:n,I_b)))
		legend('linear power flow','AC power flow')

		subplot(3,1,3)
		hold on
		plot(abs(I_linear(3:3:end)))
		plot(abs(res.branch(1:n,I_c)))
		legend('linear power flow','AC power flow')

		% compare the results of s0 and branch_s01
		branch_s01 = zeros(1,3);
		for k = 1:branch_num
			fbus = branch(k,FBus);
			tbus = branch(k,TBus);
			if fbus == 1
				branch_s01 = branch_s01 + res.branch(k,[PF_a,PF_b,PF_c])/baseMVA;
			elseif tbus == 1
				branch_s01 = branch_s01 - res.branch(k,[PF_a,PF_b,PF_c])/baseMVA;
			end
		end
		figure(4)
		title('comparision of s0')
		hold on
		plot(abs(s0_linear))
		plot(abs(branch_s01))
		legend('linear power flow','AC power flow')
	end
end

