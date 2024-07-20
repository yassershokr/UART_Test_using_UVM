class uart_test extends uvm_test;
  uart_sequence  uart_seq;
  uart_environment uart_env;
  `uvm_component_utils(uart_test)
  
  function new(string name = "uart_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uart_seq = uart_sequence::type_id::create("uart_seq", this);
    uart_env = uart_environment::type_id::create("uart_env", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    uart_seq.start(uart_env.uart_agt.uart_seqr);
    phase.drop_objection(this);
  endtask
  
endclass
