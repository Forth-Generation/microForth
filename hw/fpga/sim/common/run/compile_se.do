vlib work

vlog \
  +libext+.v \
  +libext+.sv \
  -work work \
  -novopt \
  -noincr \
  \
  ../tb/tb.v \
  +incdir+../../../src \
  +incdir+../../../inc \
  +incdir+../tb \
  -y ../../../src \
  -y ../../../src/uart_tx \
  -y ../../../src/uart_rx \
  -y ../tb \
  +define+SIMULATION=1


