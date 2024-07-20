class uart_driver extends uvm_driver#(uart_sequence_item);
  uart_sequence_item req;
  virtual uart_interface vif;
  `uvm_component_utils(uart_driver)
  
  function new(string name = "uart_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual uart_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Driver: ", "No vif is found!")
  endfunction
  
  
virtual task run_phase(uvm_phase phase);
  forever begin
    req = uart_sequence_item::type_id::create("req");
    seq_item_port.get_next_item(req);
    @(posedge vif.clk);
    // Handling write operations
      vif.w_data <= req.w_data; // Set data to write
      vif.divsr <= req.divsr;
      @(posedge vif.clk);
      vif.wr_uart <= 1; // Enable write operation
      @(posedge vif.clk);
      vif.wr_uart <= 0; // Disable write operation
      @(posedge vif.clk);
      vif.rd_uart <= 1; // Enable read operationl
      @(posedge vif.clk);
      vif.rd_uart <= 0; // Disnable read operationl
      @(posedge vif.clk);
      
    seq_item_port.item_done();
  end
endtask
endclass
