class uart_sequence extends uvm_sequence#(uart_sequence_item);
  `uvm_object_utils(uart_sequence)
  uart_sequence_item req;

  
  function new(string name = "uart_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)begin
      req = uart_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize())
        else `uvm_fatal(get_type_name(), "Randomization Failed!")
      finish_item(req);
      #109000000;
    end
  endtask
  
endclass