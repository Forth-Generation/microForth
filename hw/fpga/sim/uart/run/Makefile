include ../../common/run/Makefile

wave:
	gtkwave wave.vcd sigs.sav

verilator:
	@echo ----------------------------------------
	@echo Building verilator src
	@echo ----------------------------------------
	./vc
	@echo ----------------------------------------
	@echo Compiling verilator
	@echo ----------------------------------------
	make -j -C obj_dir -f Vtb.mk Vtb
	@echo ----------------------------------------
	@echo Running verilator
	@echo ----------------------------------------
	./obj_dir/Vtb -dump
