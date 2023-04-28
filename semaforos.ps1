ghdl clean
ghdl -a semaforos_states.vhd counter.vhd counter_semaforos.vhd semaforos.vhd semaforos_tb.vhd
ghdl -m semaforos_tb
ghdl -r semaforos_tb --vcd=semaforos_tb.vcd --stop-time=120us