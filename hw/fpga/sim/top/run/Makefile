include ../../common/run/Makefile

wave:
	gtkwave wave.vcd

verilator:
	./vc
	make -j -C obj_dir -f Vtb.mk Vtb
	./obj_dir/Vtb -dump
