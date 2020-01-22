quietly vlib work

vlog \
  -work work \
  +libext+.v \
  +libext+.sv \
  -work work \
  -novopt \
  -noincr \
  ../tb/tb.v \
  \
  +incdir+../../../src \
  +incdir+../../../inc \
  +incdir+../tb \
  -y ../../../src \
  -y ../../../cores \
  -y ../../../src/uart_tx \
  -y ../../../src/uart_rx \
  -y ../tb \
  +define+SIMULATION=1


