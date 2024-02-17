# simple-UVM-environment-for-synchronizing-FIFO

There are two parts to the simple UVM example.
One is the test bench, and the other is the design.
- design: sync_fifo
- testbench
  - design
  - interface
  - run_test
      - test : test_wr_only, test_rd_only, test_wr_rd_sequential, test_rd_wr_concurrent, test_rd_wr_random
        - environment
          - scoreboard
          - slave_agent
          - master_agent
            - sequencer <-----> sequence : wr_seq, rd_seq, rd_wr_concurrent_seq, rd_wr_random
            - driver
            - monitor
  
  
Compile environment: https://www.edaplayground.com/x/MfGU

Simulator: Synopsys VCS 2021.09

Option: +UVM_TESTNAME="test_name"
