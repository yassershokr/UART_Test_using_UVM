class uart_agent extends uvm_agent;
 `uvm_component_utils(uart_agent)
  
  uart_sequencer uart_seqr;
  uart_driver uart_driv;
  uart_monitor uart_moni;

  
  function new(string name = "uart_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      uart_seqr = uart_sequencer::type_id::create("uart_seqr", this);
      uart_driv = uart_driver::type_id::create("uart_driv", this);
    end
    uart_moni = uart_monitor::type_id::create("uart_moni", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      uart_driv.seq_item_port.connect(uart_seqr.seq_item_export);
  endfunction
  
endclass
