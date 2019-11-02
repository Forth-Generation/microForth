COMMON = ../../common/run

TEST_SRC  = test.pg2

#----------------------------------------------------------------------
# help
#----------------------------------------------------------------------

help :
	@echo ""
	@echo "make <target>"
	@echo ""
	@echo "  gui        Run the Modelsim GUI"
	@echo "  compile    Compile the simulation for batch execution"
	@echo "  run        Compile and run the simulation in batch mode"
	@echo "  links      Create shortcut links"
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
	  echo "Creating dofile links"          ;\
	  ln -sf ${COMMON}/compile_se.do     c  ;\
	  ln -sf ${COMMON}/run_se.do         r  ;\
	  ln -sf ${COMMON}/all.do            a  ;\
	  ln -sf wave.do                     w  ;\
	else \
	  echo "Copying common compile dofiles" ;\
	  cp ${COMMON}/compile_se.do         c  ;\
	  cp ${COMMON}/run_se.do             r  ;\
	  cp ${COMMON}/all.do                a  ;\
	fi

phy :
	ln -sf ${COMMON}/compile_altera_phy.do ca
	ln -sf ${COMMON}/compile_phy.do        c
	ln -sf ${COMMON}/run_phy.do            r
	ln -sf wave.do                         w

ase :
	ln -sf ${COMMON}/compile_ase.do c
	ln -sf ${COMMON}/run_ase.do     r
	ln -sf wave.do                  w

#----------------------------------------------------------------------
# clean
#----------------------------------------------------------------------

clean :
	rm -rf top.cr.mti transcript work vsim_stacktrace* obj_dir

veryclean distclean : clean
	rm -f ca a c r w vsim.wlf

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
# misc
#----------------------------------------------------------------------



