class uart_monitor extends uvm_monitor;  
  `uvm_component_utils(uart_monitor)
  
  uvm_analysis_port#(uart_sequence_item) item_port; 

  
  virtual uart_interface vif;
  uart_sequence_item item_rd;
  function new(string name = "uart_monitor", uvm_component parent);
    super.new(name, parent);
    item_port = new("item_port", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual uart_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface must be set for uart_monitor!");
    end
    item_rd = uart_sequence_item::type_id::create("item_rd", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      fork
        monitor_input();
        monitor_output();
      join
      item_port.write(item_rd);
    end
  endtask
  
  virtual task monitor_output();
    @(posedge vif.clk);
    @(posedge vif.rd_uart);
    item_rd.tx_full = vif.tx_full;
    item_rd.rx_empty = vif.rx_empty;
    item_rd.r_data = vif.r_data;
    $display("MON: Read data: %2h", item_rd.r_data);
  endtask
  
  virtual task monitor_input();
    @(posedge vif.clk);
    item_rd.wr_uart = vif.wr_uart;
    item_rd.w_data = vif.w_data;
    $display("MON: Write data: %2h", item_rd.w_data);
  endtask
  
endclass
