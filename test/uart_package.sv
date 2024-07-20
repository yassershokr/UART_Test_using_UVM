package uart_package;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  
  
    `include "uart_sequence_item.sv"
    `include "uart_sequence.sv"
    `include "uart_sequencer .sv"
    `include "uart_driver.sv"
    `include "uart_monitor.sv"
    `include "uart_coverage_collector.sv"
    `include "uart_scoreboard.sv"
    `include "uart_agent.sv"
    `include "uart_environment.sv"
    `include "uart_test.sv"
endpackage: uart_package
