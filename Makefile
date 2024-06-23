
build:
	vlib work
	vmap work work
	vlog fsm.v time_counter.v fsm_traffic_light.v tb_fsm_traffic_light.v
run:
	vsim -debugDB -l test.log -voptargs=+acc -assertdebug -c tb_fsm_traffic_light -do "log -r /*; run -all;"
wave:
	vsim -i -view vsim.wlf -do "add wave vsim: /tb_fsm_traffic_light/*; radix -decimal" &
help:
	@echo "hello work. This is my first script"
