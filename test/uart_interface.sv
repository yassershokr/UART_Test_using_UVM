interface uart_interface(input clk, Reset);
  // Control signals
  bit rd_uart, wr_uart;
  
  // Data signals
  bit [7:0] w_data; // Adjusted for parameterized data width
  bit [7:0] r_data;
  
  // UART signals
  bit rx, tx;
  
  // FIFO control signals
  bit rx_empty, tx_full, incorrect_send;
  
  // Baud rate generator control
  bit [9:0] divsr; // Adjusted for parameterized divisor width
endinterface
