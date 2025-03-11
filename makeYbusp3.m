function Ybus = makeYbusp3(mpc)
% calculate the Ybus of a multi-phase unbalanced distribution network
% author: Siyuan Wang
% Date : 2020-07-04

	define_idx;

	[bus2wye,bus2delt] = busIdxMat(mpc);

	branch = mpc.branch;
	bus = mpc.bus;
	baseMVA = mpc.baseMVA;

	bus_num = size(bus,1);
	branch_num = size(branch,1);
	phase_num = sum(sum(bus(:,[Status_a,Status_b,Status_c])));

	Ybus = sparse(phase_num,phase_num);
	Ysh = sparse(phase_num,phase_num);

	for k = 1:branch_num
		z = [branch(k,Zaa),branch(k,Zab),branch(k,Zca)
			 branch(k,Zab),branch(k,Zbb),branch(k,Zbc)
			 branch(k,Zca),branch(k,Zbc),branch(k,Zcc)];
		
		% check the status of branches
		branch_status = branch(k,[StatusBranch_a,StatusBranch_b,StatusBranch_c]);
		for p = 3:-1:1
			if  branch_status(p) ~= 1
				z(p,:) = [];
				z(:,p) = [];
			end
		end
		n = size(z,1);
		y = z \ eye(n);
		f_idx = bus2wye(branch(k,FBus),:);
		t_idx = bus2wye(branch(k,TBus),:);
		f_idx = f_idx(branch_status==1);
		t_idx = t_idx(branch_status==1);
		m = length(f_idx);
		p = 1:m;
		M = sparse([f_idx,t_idx],[p,p],[ones(1,m),-ones(1,m)],phase_num,m);
		Ybus = Ybus + M*sparse(y)*M.';

		Bc = branch(k,[Bc_a,Bc_b,Bc_c])*1j/2;
		Bc = Bc(branch_status==1);
		Ysh = Ysh + sparse([f_idx,t_idx],[f_idx,t_idx],[Bc,Bc],phase_num,phase_num);
	end

	for k = 1:bus_num
		bus_status = bus(k,[Status_a,Status_b,Status_c]);
		Bs = 1j * bus(k, [Bs_a,Bs_b,Bs_c]) / baseMVA;
		Bs = Bs(bus_status==1);
		busidx = bus2wye(k,:);
		busidx = busidx(bus_status==1);
		Ysh = Ysh + sparse(busidx,busidx,Bs,phase_num,phase_num);
	end

	Ybus = Ybus + Ysh;
end


