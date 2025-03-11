function results = mpACpf(mpc,tol,max_iter,Sbus0)
% calculate the accurate AC power flow of a multi-phase unbalanced distribution network with Newton method
% author: Siyuan Wang
% Date : 2020-07-04
%
% DEMOS:
% results = mpACpf(mpc,tol,max_iter,Sbus0);
% results = mpACpf(mpc,Sbus0);
% results = mpACpf(mpc);

% clc;clear;close all
% mpc = case33p3();
% tol = 1e-8;
% max_iter = 100;
	if nargin == 1
		tol = 1e-8;
		max_iter = 100;
	elseif nargin == 2
		Sbus0 = tol;
		tol = 1e-8;
		max_iter = 100;
	end
	
	define_idx;

	[bus2wye,bus2delt] = busIdxMat(mpc);

	branch = mpc.branch;
	bus = mpc.bus;
	baseMVA = mpc.baseMVA;

	branch_num = size(branch,1);
	bus_num = size(bus,1);
	phase_num = sum(sum(bus(:,[Status_a,Status_b,Status_c])));
	line_num = sum(sum(branch(:,[StatusBranch_a,StatusBranch_b,StatusBranch_c])));

	Ybus = makeYbusp3(mpc);

	pq_bus = find(bus(:,Bus_Type) == 1);
	pv_bus = find(bus(:,Bus_Type) == 2);

	% get index of pq pv type buses
	pq = -ones(length(pq_bus)*3,1);
	pv = -ones(length(pv_bus)*3,1);
	for k = pq_bus'
		pq(3*k-2:3*k) = bus2wye(k,:).';
	end
	pq(pq==-1) = [];
	for k = pv_bus'
		pv(3*k-2:3*k) = bus2wye(k,:).';
	end
	pv(pv==-1) = [];

	num_pv = length(pv);
	num_pq = length(pq);

	idx1 = 1;			idx2 = num_pv;      
	idx3 = idx2 + 1;	idx4 = idx2 + num_pq; 
	idx5 = idx4 + 1;	idx6 = idx4 + num_pq; 

	% power injection
	if (nargin == 2) || (nargin == 4)
		Sbus = Sbus0;
	else % use complex power injection in the input data file by default
		Sbus = makeSbusp3(mpc);
	end

	% voltage initialize
	V0 = ones(phase_num,1);
	for k = 1:bus_num
		idx = bus2wye(k,:);
		for p = 1:3
			if idx(p) > 0
				V0(idx(p)) = V0(idx(p)) * exp(-1j*2*pi/3*(p-1));
			end
		end
	end

	V = V0;
	Va = angle(V);
	Vm = abs(V);
	iter = 1;
	err =  Sbus - V .* conj(Ybus * V);
	gap = [real(err([pv;pq]));imag(err(pq))];
	max_gap = max(abs(gap));

	gap_list = max_gap;
	while (max_gap > tol) && (iter < max_iter)
		J = MakeJacobian(Ybus, V, pv, pq);
		dx = J \ gap;

		if num_pv > 0
			Va(pv) = Va(pv) + dx(idx1:idx2);
		end
		if num_pq > 0
			Va(pq) = Va(pq) + dx(idx3:idx4);
			Vm(pq) = Vm(pq) + dx(idx5:idx6);
		end
		V = Vm .* exp(1j * Va);
		err =  Sbus - V .* conj(Ybus * V);
		gap = [real(err([pv;pq]));imag(err(pq))];
		max_gap = max(abs(gap));
		gap_list = [gap_list ;max_gap];
		iter = iter + 1;
	end

	if iter == max_iter
		warning('Power Flow exceds the max_iter but not converge !')
	end

	% calculate results
	% bus voltage
	results = mpc;
	results.Ybus = Ybus;
	for k = 1:bus_num
		idx0 = bus2wye(k,:);
		idx = idx0(idx0>0);
		Vm_bus = zeros(1,3);
		Vm_bus(idx0>0) = Vm(idx);
		results.bus(k,[Vm_a,Vm_b,Vm_c]) = Vm_bus;
		Va_bus = zeros(1,3);
		Va_bus(idx0>0) = Va(idx);
		results.bus(k,[Va_a,Va_b,Va_c]) = Va_bus/pi*180;
	end
	% branch pwoer flow and branch current
	results.branch = [results.branch,zeros(branch_num,6)];
	for k = 1:branch_num
		z = [branch(k,Zaa),branch(k,Zab),branch(k,Zca)
			 branch(k,Zab),branch(k,Zbb),branch(k,Zbc)
			 branch(k,Zca),branch(k,Zbc),branch(k,Zcc)];
		% check branch status
		branch_status = branch(k,[StatusBranch_a,StatusBranch_b,StatusBranch_c]);
		for p = 3:-1:1
			if  branch_status(p) ~= 1
				z(p,:) = [];
				z(:,p) = [];
			end
		end
		n = size(z,1);

		fbus_idx = bus2wye(branch(k,FBus),:);
		tbus_idx = bus2wye(branch(k,TBus),:);
		fbus_idx = fbus_idx(branch_status==1);
		tbus_idx = tbus_idx(branch_status==1);

		Vf = V(fbus_idx);
		Vt = V(tbus_idx);

		Bc_ij = branch(k,[Bc_a,Bc_b,Bc_c]);
		Bc_ij = Bc_ij(branch_status==1);
		Ysh_ij = diag(Bc_ij) * 1j/2 / baseMVA;

		branch_current = Ysh_ij*Vf + z\(Vf - Vt);
		branch_power = diag(Vf) * conj(branch_current) *baseMVA;

		current = zeros(1,3);
		current(branch_status==1) = branch_current;
		power_flow = zeros(1,3);
		power_flow(branch_status==1) = branch_power;

		results.branch(k,[I_a,I_b,I_c]) = current;
		results.branch(k,[PF_a,PF_b,PF_c]) = power_flow;
	end
end



% calculate Jacobian Matrix
function J = MakeJacobian(Ybus, V, pv, pq)
	Ibus = Ybus * V;
	dSbus_dth = 1j * diag(V) * conj(diag(Ibus) - Ybus * diag(V));
	dSbus_dV = diag(V) * conj(Ybus * diag(V./abs(V))) +...
				conj(diag(Ibus)) * diag(V./abs(V));

	j11 = real(dSbus_dth([pv; pq], [pv; pq]));
	j12 = real(dSbus_dV([pv; pq], pq));
	j21 = imag(dSbus_dth(pq, [pv; pq]));
	j22 = imag(dSbus_dV(pq, pq));

	J = [j11,j12;j21,j22;];
end


