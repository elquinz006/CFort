struct T1DCTRL_t
{
	// task control
	double st_time;	//Simulation time
	double st_dt;	//DT
	int mode;	//TASS1D mode
	// 0 : initialization
	// 1 : run
	// 2 : run from snap
	// 3 : make normal snap
	// 4 : make backtrack snap
	// 5 : reset from ic snap
	// 6 : reset from bt snap
	// int caseid;	// input file id
	int wopt;	//if greater than 0, write TASS output to files
	int snapid;	//reset, snap id
	int flag_sg;	//If greater than 0, SG by TASS3D
	int flag_pzr;	//If greater than 0, PZR by TASS3D
	int flag_artos;	//If greater than 0, core by ARTOS
	int CPUs;	//Number of CPUs
	int FWBC[5];	//Number of FW BCs
	int MSBC[5];	//Number of MS BCs
	//int   artos_geom[3];
};
