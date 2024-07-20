class uart_environment extends uvm_env;
  `uvm_component_utils(uart_environment)
    
  uart_agent uart_agt;
  uart_scoreboard uart_scb;

  
  function new(string name = "uart_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uart_agt = uart_agent::type_id::create("uart_agt", this);
    uart_scb = uart_scoreboard::type_id::create("uart_scb", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    uart_agt.uart_moni.item_port.connect(uart_scb.item_port);
  endfunction
  
endclass
