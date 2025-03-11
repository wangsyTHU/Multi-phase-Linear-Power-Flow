function  [bus2wye,bus2delt] = busIdxMat(mpc)
% generate the transfer matrics from bus_idx to wye_phase_idx and delt_phase_idx
% the empty phase is filled with -1
% the index starts from the root bus
	define_idx;

	bus = mpc.bus;
	bus_num = size(bus,1);

	bus_status = bus(:,[Status_a,Status_b,Status_c]);
	bus2wye = -ones(bus_num,3);
	bus2delt = -ones(bus_num,3);

	wye_idx = 0;
	for k = 1:bus_num
		busk_status = bus_status(k,:);
		n = sum(busk_status);
		bus2wye(k,busk_status==1) = (wye_idx+1):(wye_idx+n);
		wye_idx = max(max(bus2wye(1:k,:)));
	end

	delt_idx = 0;
	for k = 1:bus_num
		busk_status = bus_status(k,:);
		switch sum(busk_status)
		case 3
			bus2delt(k,:) = (delt_idx+1):(delt_idx+3);
		case 2
			if sum(busk_status([1,2])) == 2 % ab
				bus2delt(k,1) = delt_idx+1;
			elseif sum(busk_status([2,3])) == 2 % bc
				bus2delt(k,2) = delt_idx+1;
			elseif sum(busk_status([1,3])) == 2 % ca
				bus2delt(k,3) = delt_idx+1;
			end
		end
		delt_idx = max(max(bus2delt(1:k,:)));
	end
end

