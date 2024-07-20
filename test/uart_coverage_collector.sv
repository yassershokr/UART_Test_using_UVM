class uart_coverage_collector extends uvm_subscriber #(uart_sequence_item);

  `uvm_component_utils(uart_coverage_collector)
  uvm_analysis_imp #(uart_sequence_item,uart_coverage_collector) coverage_collector_port;
  uart_sequence_item  item;
  uvm_analysis_port #(uart_sequence_item) monitor_port;

  covergroup control_signals;
    option.per_instance = 1;
    option.name = "control_signals";

    read: coverpoint item.rd_uart {
           bins not_read  = {0};
           bins read = {1};
    }
    write: coverpoint item.wr_uart {
           bins not_write  = {0};
           bins write = {1};
    }
    write_data: coverpoint item.w_data {
           bins zeros  = {8'b0};
           bins ones = {8'b1};
           bins random_data = default;
    }
  endgroup: control_signals


    function new(string name ="uart_coverage_collector" , uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"inside constructor Monitor class",UVM_LOW)
        coverage_collector_port= new("coverage_port",this);
        control_signals = new();
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),"inside build phase of uart_coverage_collector class",UVM_LOW)
    endfunction

    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(),"inside connect phase of uart_coverage_collector class",UVM_LOW)
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"inside run phase of uart_coverage_collector class",UVM_LOW)
    endtask

  function void write(uart_sequence_item t);
    item= uart_sequence_item::type_id::create("item");
    $cast(item,t);
    control_signals.sample();
  endfunction: write

  virtual function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE", $sformatf("\n\n\t Functional coverage = %2.2f%%\n",control_signals.get_inst_coverage()), UVM_NONE)
  endfunction: report_phase

endclass: uart_coverage_collector
