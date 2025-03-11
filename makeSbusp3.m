function Sbus = makeSbusp3(mpc)
% generate the default complex power injection Sbus from the input data file
	define_idx;

	bus = mpc.bus;
	baseMVA = mpc.baseMVA;

	bus_status = bus(:,[Status_a,Status_b,Status_c]);
	bus_num = size(bus,1);
	phase_num = sum(sum(bus_status));
	Sbus = zeros(phase_num,1);
	phase_idx = 1;
	for k = 1:bus_num
		if(bus(k,Status_a)==1)
			Sbus(phase_idx) = Sbus(phase_idx) - bus(k,Sa)/baseMVA;
			phase_idx = phase_idx + 1;
		end
		if(bus(k,Status_b)==1)
			Sbus(phase_idx) = Sbus(phase_idx) - bus(k,Sb)/baseMVA;
			phase_idx = phase_idx + 1;
		end
		if(bus(k,Status_c)==1)
			Sbus(phase_idx) = Sbus(phase_idx) - bus(k,Sc)/baseMVA;
			phase_idx = phase_idx + 1;
		end
	end

	% add the contribution of generators
	if isfield(mpc,'gen')
		gen = mpc.gen;
		Sbus = addGen2Sbus(mpc,gen,Sbus);
	end

	if isfield(mpc,'ESS')
		ESS = mpc.ESS;
		Sbus = addGen2Sbus(mpc,ESS,Sbus);
	end

	if isfield(mpc,'WT')
		WT = mpc.WT;
		Sbus = addGen2Sbus(mpc,WT,Sbus);
	end

	if isfield(mpc,'PV')
		PV = mpc.PV;
		Sbus = addGen2Sbus(mpc,PV,Sbus);
	end
end

% add the contribution of generators to Sbus
function Sbus = addGen2Sbus(mpc,gen,Sbus_in)
	define_idx;
	[bus2wye,bus2delt] = busIdxMat(mpc);
	Sbus = Sbus_in;
	baseMVA = mpc.baseMVA;

	gen_num = size(gen,1);
	for k = 1:gen_num
		phase_idx = bus2wye(gen(k,GenBus),:);
		gen_status = gen(k,[genStatus1,genStatus2,genStatus3]);
		phase_n = sum(gen_status);
		Sgen = gen(k,Pgen_max) + 1j*gen(k,Qc1max);

		if gen(k,connectionType) == 0 % wye
			for p = 1:3
				if gen_status(p) == 1
					Sbus(phase_idx(p)) = Sbus(phase_idx(p)) + Sgen/phase_n/baseMVA;
				end
			end
		else % delta
			for p = 1:3
				if gen_status(p) == 1
					switch p
					case 1 % ab
						Sbus(phase_idx(1)) = Sbus(phase_idx(1)) + Sgen/phase_n/baseMVA;
						Sbus(phase_idx(2)) = Sbus(phase_idx(2)) - Sgen/phase_n/baseMVA;
					case 2 % bc
						Sbus(phase_idx(2)) = Sbus(phase_idx(2)) + Sgen/phase_n/baseMVA;
						Sbus(phase_idx(3)) = Sbus(phase_idx(3)) - Sgen/phase_n/baseMVA;
					case 3 % ca
						Sbus(phase_idx(3)) = Sbus(phase_idx(3)) + Sgen/phase_n/baseMVA;
						Sbus(phase_idx(1)) = Sbus(phase_idx(1)) - Sgen/phase_n/baseMVA;
					end
				end
			end
		end
	end
end
