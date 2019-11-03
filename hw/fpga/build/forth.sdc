
create_clock -period "16 MHz" -name {clk} {clk}

derive_clock_uncertainty

# reset is async
set_false_path -from [ get_ports {rst_n} ] -to *

# inputs
set_input_delay -clock clk -max -rise 5 [ get_ports { gpio* uart_rxd } ]
set_input_delay -clock clk -max -fall 5 [ get_ports { gpio* uart_rxd } ]
set_input_delay -clock clk -min -rise 1 [ get_ports { gpio* uart_rxd } ]
set_input_delay -clock clk -min -fall 1 [ get_ports { gpio* uart_rxd } ]

# outputs
set_output_delay -clock clk -max -rise 5 [ get_ports { gpio* uart_txd led } ]
set_output_delay -clock clk -max -fall 5 [ get_ports { gpio* uart_txd led } ]
set_output_delay -clock clk -min -rise 1 [ get_ports { gpio* uart_txd led } ]
set_output_delay -clock clk -min -fall 1 [ get_ports { gpio* uart_txd led } ]

# signaltap access
set_input_delay  -clock altera_reserved_tck -max -rise 5 [ get_ports { altera_reserved_tms altera_reserved_tdi } ]
set_input_delay  -clock altera_reserved_tck -max -fall 5 [ get_ports { altera_reserved_tms altera_reserved_tdi } ]
set_input_delay  -clock altera_reserved_tck -min -rise 1 [ get_ports { altera_reserved_tms altera_reserved_tdi } ]
set_input_delay  -clock altera_reserved_tck -min -fall 1 [ get_ports { altera_reserved_tms altera_reserved_tdi } ]

set_output_delay -clock altera_reserved_tck -max -rise 5 [ get_ports { altera_reserved_tdo } ]
set_output_delay -clock altera_reserved_tck -max -fall 5 [ get_ports { altera_reserved_tdo } ]
set_output_delay -clock altera_reserved_tck -min -rise 1 [ get_ports { altera_reserved_tdo } ]
set_output_delay -clock altera_reserved_tck -min -fall 1 [ get_ports { altera_reserved_tdo } ]
