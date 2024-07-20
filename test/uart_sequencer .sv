class uart_sequencer extends uvm_sequencer#(uart_sequence_item);
  `uvm_component_utils(uart_sequencer)
  
    // Constructor
    function new(string name = "uart_sequencer" , uvm_component  parent);
        super.new(name , parent);
        `uvm_info(get_type_name(),"inside constructor uart_sequencer class",UVM_LOW)
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),"inside build_phase of uart_sequencer class",UVM_LOW)
    endfunction

    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(),"inside connect_phase of uart_sequencer class",UVM_LOW)
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"inside run_phase of uart_sequencer class",UVM_LOW)
    endtask
endclass: uart_sequencer