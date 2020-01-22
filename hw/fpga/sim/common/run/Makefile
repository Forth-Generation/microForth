COMMON = ../../common/run

TEST_SRC  = test.pg2

#----------------------------------------------------------------------
# help
#----------------------------------------------------------------------

help :
	@echo ""
	@echo "make <target>"
	@echo ""
	@echo "  run"
	@echo "  ---------"
	@echo "  gui        Run the Modelsim GUI"
	@echo "  verilator  Run verilator simulation"
	@echo "  wave       Run waveform viewer"
	@echo "  compile    Compile the simulation for batch execution"
	@echo "  run        Compile and run the simulation in batch mode"
	@echo ""
	@echo "  setup"
	@echo "  ---------"
	@echo "  se         Create shortcut links for Modelsim se"
	@echo "  ase        Create shortcut links for Modelsim ase"
	@echo ""
	@echo "  cleanup"
	@echo "  ---------"
	@echo "  clean      Remove intermediate files"
	@echo "  veryclean  Remove all uncontrolled files"
	@echo ""

#----------------------------------------------------------------------
# run the gui
#----------------------------------------------------------------------

gui :
	vsim top.mpf
#	/home/modelsim/current/modeltech/linux/vsim top.mpf

#----------------------------------------------------------------------
# setup up for various flavors of modelsim
# links don't work on windoze, so just copy
#----------------------------------------------------------------------

links se :
	@if [ `uname` == Linux ] ;\
	then \
	  echo "Creating dofile links for Modelsim se";\
	  ln -sf ${COMMON}/compile_se.do     c  ;\
	  ln -sf ${COMMON}/compile_altera.do ca ;\
	  ln -sf ${COMMON}/run_se.do         r  ;\
	  ln -sf ${COMMON}/all.do            a  ;\
	  ln -sf wave.do                     w  ;\
	else \
	  echo "Copying common compile dofiles" ;\
	  cp ${COMMON}/compile_se.do         c  ;\
	  cp ${COMMON}/run_se.do             r  ;\
	  cp ${COMMON}/all.do                a  ;\
	fi

ase :
	@echo "Creating dofile links for Modelsim ase";\
	ln -sf ${COMMON}/compile_se.do     c  ;\
	ln -sf ${COMMON}/compile_altera.do ca ;\
	ln -sf ${COMMON}/run_se.do         r  ;\
	ln -sf ${COMMON}/all.do            a  ;\
	ln -sf wave.do                     w

#----------------------------------------------------------------------
# clean
#----------------------------------------------------------------------

clean :
	rm -rf top.cr.mti transcript work vsim_stacktrace* obj_dir

veryclean distclean : clean
	rm -f ca a c r w vsim.wlf wave.vcd

#----------------------------------------------------------------------
# create sim work dir and compile altera libs
#----------------------------------------------------------------------

compile_altera work :
	pwd
	. ./compile_altera.do

#----------------------------------------------------------------------
# compile simulation
#----------------------------------------------------------------------

compile : work
	. ./compile_batch

#----------------------------------------------------------------------
# run simulation
#----------------------------------------------------------------------

run :
	. ./run_batch

#----------------------------------------------------------------------
# waveform viewer
#----------------------------------------------------------------------

wave:
	gtkwave wave.vcd sigs.sav

#----------------------------------------------------------------------
# verilator
#----------------------------------------------------------------------

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

