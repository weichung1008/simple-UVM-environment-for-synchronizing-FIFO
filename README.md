# simple-UVM-environment-for-synchronizing-FIFO

There are two parts to the simple UVM example.
One is the test bench, and the other is the design.
- design: sync_fifo.
  - Description: This design is a synchronous FIFO with parameterizable input and output, as well as the depth of the FIFO. It uses read and write pointers to determine whether the FIFO is empty or full.
- testbench
  - design: This design is sync_fifo in this simple example.
  - interface: Connects the design and UVM environment, and transmits signals and data.
  - test: The UVM Test is the top-level UVM Component in the UVM Testbench. In this example, there are different tests, e.g., test_wr_only, test_rd_only, test_wr_rd_sequential, test_rd_wr_concurrent, test_rd_wr_random, test_rd_wr_with_cb, and test_rd_wr_with_DPI.
    - environment: It groups other interrelated verification components. 
      - scoreboard: It is used to check the behavior of a certain DUT.
      - slave_agent: Accepts data transfer requests, control signals, and commands from the Master Agent and executes the corresponding operations.
      - master_agent: Initiates communication and controls commands, and contains the sequencer, driver, and monitor.
        - sequencer: Controls the flow of UVM Sequence Items transactions generated by one or more UVM Sequences.
        - driver: Receives individual UVM Sequence Item transactions from the UVM Sequencer and applies (drives) it on the DUT Interface.
        - monitor:  Samples the DUT interface and captures the information there in transactions that are sent out to the rest of the UVM Testbench for further analysis.
    - sequence: An object that contains a behavior for generating stimulus. There are some kinds of sequences, like wr_seq, rd_seq, rd_wr_concurrent_seq, and rd_wr_random.
    - callback
      - Step 1: Declare a callback class which extends uvm_callback (my_driver_callback.sv)
      - Step 2: Implement this callback class (drv_print_cb.sv)
      - Step 3: Register the callback and use the `uvm_do_callbacks macro to call the callback method (my_driver.sv)
      - Step 4: Build a case to test this callback method (test_rd_wr_with_cb.sv)
  - C code: Simple function to display transaction id of write and read transactions
      - Additional test for DPI testing
        - Need to import function name in the file which called C function

Simulation environment: 
![image](https://github.com/weichung1008/simple-UVM-environment-for-synchronizing-FIFO/assets/160299780/1f555501-7f90-4564-8378-a388e4e42959)





