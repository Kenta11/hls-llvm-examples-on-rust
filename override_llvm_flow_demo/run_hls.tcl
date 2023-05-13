# (C) Copyright 2016-2022 Xilinx, Inc.
# All Rights Reserved.
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Open a project and remove any existing data
open_project -reset proj

# Tell the top
set_top example

# Open a solution and remove any existing data
open_solution -reset solution1

# Set the target device
set_part "virtex7"

# Create a virtual clock for the current solution
create_clock -period "300MHz"

# Start rust code synthesis
send_msg_by_id INFO @200-1505@%s%s default  vivado
send_msg_by_id INFO @200-435@%s%s 'open_solution -flow_target vivado' config_interface -m_axi_latency=0
config_interface -m_axi_latency=0
set_part virtex7
# create_platform virtex7 -board # -board に与える引数が分からないので実行しない（問題になるかも？）
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/common/xilinx.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/interface/plb46.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/interface/axi4.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/interface/nativeAXI4.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/interface/saxilite.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/scripts/xilinxcoregen.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/interface/XilEDKCoreGen.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/ip/xfir.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/ip/util.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/ip/xfft.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/ip/dds_compiler.gen
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/DSP48/dsp48.gen
ap_part_info -name xc7v585t-ffg1761-2 -data info
# config_compile -quiet -complex-mul-dsp=0 # "hidden command" のため実行できない（問題になるかも？）
create_clock -period 300MHz
ap_set_clock -name default -period 3.333 -unit ns -default=false
# csynth_design # これは C/C++ の高位合成のためのコマンドなので実行しない（問題になるかも？）
# elaborate -effort=medium -skip_syncheck=0 -keep_printf=0 -skip_cdt=0 -skip_transform=0 -ng=0 -g=0 -opt_fp=0 -from_csynth_design=1 # Vitis HLS の CLI からは実行できないコマンド
ap_part_info -name xc7v585t-ffg1761-2 -data info 
# exec -ignorestderr /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/../../hls-llvm-project/hls-build/bin/clang hls_example.cpp -foptimization-record-file=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.cpp.clang.diag.yml -mllvm -pass-remarks-missed=reflow|pasta|unroll -mllvm -pass-remarks=reflow|pasta|unroll|inline -fno-limit-debug-info -gcc-toolchain /opt/Xilinx/2022.2/Vitis_HLS/2022.2/tps/lnx64/gcc-8.3.0 -fhls -fno-exceptions -E -fno-math-errno -c -emit-llvm -mllvm -disable-llvm-optzns -Werror=implicit-function-declaration -Werror=implicit-hls-streams -Werror=return-type -Wpragmas -Wunused-parameter -Wdump-hls-pragmas -Wno-error=dump-hls-pragmas -fno-threadsafe-statics -fno-use-cxa-atexit -std=gnu++14 -target fpga64-xilinx-linux-gnu -fno-threadsafe-statics -fno-use-cxa-atexit -D__VITIS_HLS__ -DAESL_SYN -D__SYNTHESIS__ -D__HLS_SYN__ -I /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/autopilot -I /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/autopilot/ap_sysc -include etc/autopilot_ssdm_op.h -D__DSP48E1__ -I /usr/include/x86_64-linux-gnu -o /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp -hls-platform-db-name=/opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/common/platform.db -hls-platform-name=virtex7_medium -device-resource-info=BRAM_1590.000000_DSP_1260.000000_FF_728400.000000_LUT_364200.000000_SLICE_91050.000000_URAM_0.000000 -device-name-info=xc7v585tffg1761-2 > /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.cpp.clang.out.log 2> /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.cpp.clang.err.log # C/C++ ソースコードをプリプロセッサにかけている． Rust ソースコードはプリプロセッサにかけないので実行しない（問題になるかも？）
set_directive_top example -name=example 
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/tps/tcl/tcllib1.11.1/yaml/huddle.tcl 
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/tps/tcl/tcllib1.11.1/yaml/json2huddle.tcl 
# exec -ignorestderr /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/../../hls-llvm-project/hls-build/bin/clang -foptimization-record-file=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/clang.diag.yml -mllvm -pass-remarks-missed=reflow|pasta|unroll -mllvm -pass-remarks=reflow|pasta|unroll|inline -fsyntax-only -fhls -target fpga64-xilinx-linux-gnu /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp -hls-platform-db-name=/opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/common/platform.db -hls-platform-name=virtex7_medium -device-resource-info=BRAM_1590.000000_DSP_1260.000000_FF_728400.000000_LUT_364200.000000_SLICE_91050.000000_URAM_0.000000 -device-name-info=xc7v585tffg1761-2 > /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/clang.out.log 2> /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/clang.err.log # C/C++ ソースコードを解析し，optimization reports を作成する．Rust ソースコードではやり方が分からないので実行しない（問題になるかも？）
# clang_tidy xilinx-systemc-detector -desc systemc-detector /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp std=gnu++14 -target fpga  -directive=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/.systemc_flag # C/C++ ソースコードを clang-tidy で解析する．Vitis HLS に同梱されている clang-tidy のため，解析の目的と内容は不明．Rust ソースコードでは解析できないので実行しない（問題になるかも？）
# clang_tidy xilinx-directive2pragma -desc directive2pragma /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp std=gnu++14 -target fpga  -directive=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/all.directive.json # C/C++ ソースコードを clang-tidy で解析する．Vitis HLS に同梱されている clang-tidy のため，解析の目的と内容は不明．Rust ソースコードでは解析できないので実行しない（問題になるかも？）
# clang_tidy xilinx-remove-assert -desc remove-assert /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp std=gnu++14 -target fpga  # C/C++ ソースコードを clang-tidy で解析する．Vitis HLS に同梱されている clang-tidy のため，解析の目的と内容は不明．Rust ソースコードでは解析できないので実行しない（問題になるかも？）
# clang_tidy -errorcheck -desc loop-label xilinx-label-all-loops,xilinx-aggregate-on-hls-vector,,xilinx-warn-mayneed-no-ctor-attribute /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp std=gnu++14 -target fpga  # C/C++ ソースコードを clang-tidy で解析する．Vitis HLS に同梱されている clang-tidy のため，解析の目的と内容は不明．Rust ソースコードでは解析できないので実行しない（問題になるかも？）
# exec -ignorestderr /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/../../hls-llvm-project/hls-build/bin/clang-tidy -export-fixes=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.clang-tidy.loop-label.diag.yml -header-filter=.* --checks=-*,xilinx-label-all-loops,xilinx-aggregate-on-hls-vector,,xilinx-warn-mayneed-no-ctor-attribute -fix-errors /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp -- -std=gnu++14 -target fpga -fhls -ferror-limit=0 > /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.clang-tidy.loop-label.out.log 2> /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.clang-tidy.loop-label.err.log # C/C++ ソースコードを clang-tidy で解析する．解析の目的と内容は不明．Rust ソースコードでは解析できないので実行しない（問題になるかも？）
source /opt/Xilinx/2022.2/Vitis_HLS/2022.2/tps/tcl/tcllib1.11.1/yaml/yaml.tcl 
# exec -ignorestderr /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/../../hls-llvm-project/hls-build/bin/xilinx-dataflow-lawyer -export-fixes=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.xilinx-dataflow-lawyer.diag.yml /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp -- -std=gnu++14 -target fpga -fhls -ferror-limit=0 -fstrict-dataflow > /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.xilinx-dataflow-lawyer.out.log 2> /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.xilinx-dataflow-lawyer.err.log # C/C++ ソースコードを xilinx-dataflow-lawyer で解析する．解析の目的と内容は不明．Rust ソースコードでは解析できないので実行しない（問題になるかも？）
ap_part_info -name xc7v585t-ffg1761-2 -data info 
# exec -ignorestderr /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/../../hls-llvm-project/hls-build/bin/clang -foptimization-record-file=/home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.clang.diag.yml -mllvm -pass-remarks-missed=reflow|pasta|unroll -mllvm -pass-remarks=reflow|pasta|unroll|inline -fno-limit-debug-info -fhls -flto -fno-exceptions -Wno-error=c++11-narrowing /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp -fno-math-errno -c -emit-llvm -mllvm -disable-llvm-optzns -Werror=implicit-function-declaration -Werror=implicit-hls-streams -Werror=return-type -Wpragmas -Wunused-parameter -Wdump-hls-pragmas -Wno-error=dump-hls-pragmas -fno-threadsafe-statics -fno-use-cxa-atexit -std=gnu++14 -target fpga64-xilinx-linux-gnu -D__VITIS_HLS__ -DAESL_SYN -D__SYNTHESIS__ -D__HLS_SYN__ -I /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/autopilot -I /opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/autopilot/ap_sysc -include etc/autopilot_ssdm_op.h -D__DSP48E1__ -g -o /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.bc -hls-platform-db-name=/opt/Xilinx/2022.2/Vitis_HLS/2022.2/common/technology/xilinx/common/platform.db -hls-platform-name=virtex7_medium -device-resource-info=BRAM_1590.000000_DSP_1260.000000_FF_728400.000000_LUT_364200.000000_SLICE_91050.000000_URAM_0.000000 -device-name-info=xc7v585tffg1761-2 > /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.clang.out.log 2> /home/kenta/Git/Kenta11/hls-llvm-examples/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.pp.0.cpp.clang.err.log C/C++ ソースコードを bc ファイルにコンパイル．Rust ソースコードはコンパイルできないので，代わりに以下のコマンドを実行する
exec -ignorestderr rustc /home/kenta/Git/Kenta11/hls-llvm-examples-on-rust/override_llvm_flow_demo/src/main.rs -o /home/kenta/Git/Kenta11/hls-llvm-examples-on-rust/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.bc --emit llvm-bc
run_link_or_opt -out /home/kenta/Git/Kenta11/hls-llvm-examples-on-rust/override_llvm_flow_demo/proj/solution1/.autopilot/db/a.g.ld.0.bc -args  "/home/kenta/Git/Kenta11/hls-llvm-examples-on-rust/override_llvm_flow_demo/proj/solution1/.autopilot/db/hls_example.g.bc"  
