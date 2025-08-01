# FSM Controller in SystemVerilog

This repository provides a SystemVerilog implementation of a simple multi-cycle controller finite state machine (FSM), including a comprehensive testbench for simulation and verification. The design demonstrates state transitions based on various opcodes and input signals, suitable for educational purposes or as a reference for CPU/processor control logic.

## Features

- **Controller FSM**: Handles instruction fetch, decode, execution, and memory operations based on opcode and status signals.
- **Opcode Support**: Supports a range of instructions including HALT, SKZ, ADD, AND, XOR, LDA, STO, and JMP.
- **Testbench**: Includes a detailed testbench (`controller_tb`) that:
  - Drives all opcode cases through the FSM
  - Checks state transitions and output control signals
  - Demonstrates special cases (e.g., SKZ with `zero=1`)
  - Provides formatted output for easy debugging and understanding of FSM behavior

## Files

- `controller.sv`: SystemVerilog source code for the FSM controller module.
- `controller_tb.sv`: SystemVerilog testbench for simulating and verifying the controller module.

## Usage

### Prerequisites

- A SystemVerilog simulator (e.g., ModelSim, Questa, Xcelium, VCS, or Icarus Verilog with SV support).
