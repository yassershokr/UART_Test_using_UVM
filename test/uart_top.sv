import uvm_pkg::*;
import uart_package::*;

module top;
  bit clk;
  bit Reset;
  
  always #5 clk = ~clk;
  
  uart_interface tif(clk,Reset);
  
UART #(
  .Data_bits(9),
  .Sp_ticks(16),
  .St_ticks(8),
  .Dt_ticks(16),
  .addr_width(5),
  .divsr_width(10),
  .Read(2'b01),
  .Write(2'b10),
  .Read_and_Write(2'b11)
) dut (
  .clk(tif.clk),
  .Reset(tif.Reset),
  .rd_uart(tif.rd_uart),
  .wr_uart(tif.wr_uart),
  .rx(tif.tx),
  .w_data(tif.w_data),
  .divsr(tif.divsr),
  .rx_empty(tif.rx_empty),
  .tx_full(tif.tx_full),
  .tx(tif.tx),
  .r_data(tif.r_data), 
  .incorrect_send(tif.incorrect_send) 
);
  initial begin
    Reset = 1;
    @(posedge clk);
    Reset = 0;
  end
  
  initial begin
    uvm_config_db#(virtual uart_interface)::set(null, "", "vif", tif);
    $dumpfile("dump.vcd"); 
    $dumpvars(0, dut);
    run_test("uart_test");
  end
endmodule
