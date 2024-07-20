
class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_scoreboard)

    // Class members
    
    uvm_analysis_imp#(uart_sequence_item ,uart_scoreboard) item_port;

    uart_sequence_item expect_data[$];
    uart_sequence_item slav;  
    uart_sequence_item helper; 
    // Constructor
    function new(string name = "uart_scoreboard" , uvm_component parent);
        super.new(name , parent);
        `uvm_info(get_type_name(),"inside constructor uart_scoreboard class",UVM_LOW)
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),"inside build_phase of uart_scoreboard class",UVM_LOW)
        item_port = new("item_port",this);
    endfunction
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"inside run_phase of uart_scoreboard class",UVM_LOW)
        forever begin
            slav = uart_sequence_item::type_id::create("slav");
            wait(expect_data.size);
            slav = expect_data.pop_front();
            compare(slav);
          end
    endtask 

 int match, mismatch,i;
 
    // Write functions
    
    function void write(uart_sequence_item item_in);
      expect_data.push_back(item_in);
    endfunction:  write
    
   function void compare(uart_sequence_item item_out);
      if(item_out.w_data == item_out.r_data)
      begin
      match = match + 1;
      $display("SCB: expected data: %2h, actual data: %2h", item_out.w_data, item_out.r_data);
      $display("************		Match!		************");
      end
    else begin
      mismatch = mismatch + 1;
      $display("SCB: expected data: %2h, actual data: %2h", item_out.w_data, item_out.r_data);
      $display("************		Mismatch!		************");
    end
  endfunction: compare
  
  
  virtual function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Result: passed=%0d  failed=%0d\n", match, mismatch), UVM_NONE)
  endfunction: report_phase
  
endclass: uart_scoreboard