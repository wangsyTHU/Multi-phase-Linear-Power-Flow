% define the index of the data file of the multi-phase unbalanced distribution network
% author: Siyuan Wang
% Date : 2020-07-04

[Bus_I, Bus_Type, Sa,Sb,Sc,Bs_a,Bs_b,Bs_c,Area,Vm_a,Vm_b,Vm_c,Va_a,Va_b,Va_c,Base_kV,...
	Zone,Vmax,Vmin,Status_a,Status_b,Status_c] = idx_busp3;

[FBus,TBus,Zaa,Zbb,Zcc,Zab,Zbc,Zca,Bc_a,Bc_b,Bc_c,StatusBranch_a,StatusBranch_b,...
	StatusBranch_c,Imax_a,Imax_b,Imax_c,I_a,I_b,I_c,PF_a,PF_b,PF_c] = idx_branchp3;

[GenBus,Pgen,Qgen,Qgen_max,Qgen_min,Vgen,mBase,genStatus,Pgen_max,Pgen_min,...
	Pc1,Pc2,Qc1min,Qc1max,Qc2min,Qc2max,GenRamp,connectionType,genStatus1,genStatus2,...
	genStatus3,Sgen_max,Pfmax,Pfmin,gen_cost2,gen_cost1,gen_cost0,ESScap,SOC_init,SOC_max,...
	SOC_min,ESScharge_cost,ESSdischarge_cost,DREmainten_cost,DREcurtail_cost,...
	Tinit,Tmax,Tmin,Alpha,Beta,Pf_const,DRcost] = idx_genp3;

function [Bus_I, Bus_Type, Sa,Sb,Sc,Bs_a,Bs_b,Bs_c,Area,Vm_a,Vm_b,Vm_c,Va_a,Va_b,Va_c,Base_kV,...
	Zone,Vmax,Vmin,Status_a,Status_b,Status_c] = idx_busp3
	Bus_I = 1;
	Bus_Type =2; 
	Sa = 3;
	Sb = 4;
	Sc = 5;
	Bs_a = 6;
	Bs_b = 7;
	Bs_c = 8;
	Area = 9;
	Vm_a = 10;
	Vm_b = 11;
	Vm_c = 12;
	Va_a = 13;
	Va_b = 14;
	Va_c = 15;
	Base_kV = 16;
	Zone = 17;
	Vmax = 18;
	Vmin = 19;
	Status_a = 20; 
	Status_b = 21;
	Status_c = 22;
end


function [FBus,TBus,Zaa,Zbb,Zcc,Zab,Zbc,Zca,Bc_a,Bc_b,Bc_c,StatusBranch_a,StatusBranch_b,...
	StatusBranch_c,Imax_a,Imax_b,Imax_c,I_a,I_b,I_c,PF_a,PF_b,PF_c] = idx_branchp3
	FBus = 1;
	TBus = 2;
	Zaa = 3;
	Zbb = 4;
	Zcc = 5;
	Zab = 6;
	Zbc = 7;
	Zca = 8;
	Bc_a = 9;
	Bc_b = 10;
	Bc_c = 11;
	StatusBranch_a = 12;
	StatusBranch_b = 13;
	StatusBranch_c = 14;
	Imax_a = 15;
	Imax_b = 16;
	Imax_c = 17;
	I_a = 18;
	I_b = 19;
	I_c = 20;
	PF_a = 21;
	PF_b = 22;
	PF_c = 23;
end



function [GenBus,Pgen,Qgen,Qgen_max,Qgen_min,Vgen,mBase,genStatus,Pgen_max,Pgen_min,...
	Pc1,Pc2,Qc1min,Qc1max,Qc2min,Qc2max,GenRamp,connectionType,genStatus1,genStatus2,...
	genStatus3,Sgen_max,Pfmax,Pfmin,gen_cost2,gen_cost1,gen_cost0,ESScap,SOC_init,SOC_max,...
	SOC_min,ESScharge_cost,ESSdischarge_cost,DREmainten_cost,DREcurtail_cost,...
	Tinit,Tmax,Tmin,Alpha,Beta,Pf_const,DRcost] = idx_genp3
	GenBus = 1;
	Pgen = 2;
	Qgen  = 3;
	Qgen_max = 4;
	Qgen_min = 5;
	Vgen = 6;
	mBase = 7;
	genStatus = 8;
	Pgen_max = 9;
	Pgen_min = 10;
	Pc1	 = 11;
	Pc2 = 12;
	Qc1min = 13;
	Qc1max = 14;
	Qc2min = 15;
	Qc2max = 16;
	GenRamp = 17;
	connectionType = 18;
	genStatus1 = 19;
	genStatus2 = 20;
	genStatus3 = 21;
	Sgen_max = 22;
	Pfmax = 23;
	Pfmin = 24;

	gen_cost2 = 24;
	gen_cost1 = 25;
	gen_cost0 = 26;

	ESScap = 24;
	SOC_init = 25;
	SOC_max = 26;
	SOC_min = 27;
	ESScharge_cost = 28;
	ESSdischarge_cost = 29;

	DREmainten_cost = 25;
	DREcurtail_cost = 26;

	Tinit = 11;
	Tmax = 12;
	Tmin = 13;
	Alpha = 14;
	Beta = 15;
	Pf_const = 16;
	DRcost = 22;
end
