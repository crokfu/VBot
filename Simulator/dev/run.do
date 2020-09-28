
#vdel -all -lib work
cd c:/vlog/img_sim/dev

vlib work
vlog image_read.v image_write.v imager.v parameter.v tb_simulation.v
vsim -voptargs=+acc work.tb_simulation
add wave *

run 7ms
