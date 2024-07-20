class uart_sequence_item extends uvm_sequence_item;
  
  `uvm_object_utils(uart_sequence_item)
  // Assuming parameter values from the UART design for demonstration
  localparam int Data_bits = 9;
  localparam int divsr_width = 10;

  // Control signals for read/write operations
  rand bit rd_uart, wr_uart,rx;

  // Data to be written to the UART and expected data to be read
  rand bit [Data_bits-2:0] w_data; // Adjusted for parameterized data width
  bit [Data_bits-2:0] r_data; // Expected read data

  // Status signals
  bit rx_empty, tx_full, incorrect_send,tx;

  // Baud rate generator configuration
  rand bit [divsr_width-1:0] divsr;

constraint divisor  {  divsr == 10'd650  ;}
  // Constructor
  function new(string name = "uart_sequence_item");
    super.new(name);
    `uvm_info(get_type_name(),"inside constructor of uart_sequence_item  class",UVM_LOW)
  endfunction

endclass
