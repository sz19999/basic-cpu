# A Basic Processor

## About

This project implements a minimal processor designed as a final project for a Verilog course.  
The goal was to build a simple yet complete CPU within a 2–3 week timeline.

The processor is written in Verilog HDL and consists of the following sub-units (modules):

- Arithmetic Logic Unit (ALU)  
- Sequence Counter  
- Registers 
- Multiplexer  
- Control Unit  

These modules are integrated in a top-level module to form the full processor.

## Current Limitations

- The design currently includes only an Instruction Register (IR).  
- There is no external memory (RAM) interface.  
- The instruction set is minimal and intended primarily for learning and demonstration purposes.

In its current state, the processor is not yet a fully standalone CPU.

## Future Plans

I plan to extend this project by:

1. Acquiring an FPGA development board
2. Adding a RAM module and memory interface
3. Expanding the instruction set and hardware features
4. Building an assembler for the processor
5. Writing and running programs on the CPU

The long-term goal is to turn this into a small but complete custom CPU platform, which resembles ARM architecture.

## Instruction Set Overview

The processor uses a **16-bit Instruction Register (IR)**, but only **9 bits are currently used**:

```
IR[8:6]  OPCODE   (3 bits)
IR[5:3]  DEST     (3 bits)
IR[2:0]  SRC      (3 bits)
```

* Only `IR[8:0]` are decoded right now
* `IR[15:9]` are reserved for future extensions
* For `MVI`, the `SRC` field is **not used** — the immediate comes from the external `Din` input

### Supported Instructions

| Opcode | Mnemonic | Description                  | Operation              | Cycles |
| ------ | -------- | ---------------------------- | ---------------------- | ------ |
| `000`  | `NOP`    | No operation                 | No state change        | 2      |
| `001`  | `MV`     | Move register to register    | `Rdest <- Rsrc`        | 3      |
| `010`  | `ADD`    | Add two registers            | `Rdest <- Rdest + Rsrc`| 4      |
| `011`  | `SUB`    | Subtract two registers       | `Rdest <- Rdest - Rsrc`| 4      |
| `100`  | `MVI`    | Move immediate into register | `Rdest <- Din`         | 3      |

### ALU Operations

The ALU has only **three modes**:

| `alu_op` | Operation |
| -------- | --------- |
| `00`     | NOP       |
| `01`     | ADD       |
| `10`     | SUB       |
| `11`     | Unused    |

### Execution Model

* All instructions start with a **Fetch** step (`IRin` asserted)
* A **sequence counter** steps through the micro-operations
* `MV` completes in 2 cycles (no ALU used)
* `MVI` completes in 3 cycles (immediate fetched from `Din`)
* `ADD` / `SUB` complete in 4 cycles (use A and G registers)
* `done` is asserted when the instruction finishes

### Notes

* Only `ADD` and `SUB` use the ALU
* Only `ADD` and `SUB` use the **A** and **G** registers
* No PC, RAM, branching, or flags yet



## How to Simulate

This project is intended to be simulated using **ModelSim / Questa**.

### Requirements

* ModelSim or Questa
* Quartus (optional, for synthesis)
* Git

### Setup

1. Clone the repository:

   ```bash
   git clone <repo>
   cd <repo>
   ```

2. Open ModelSim and create a new project

   * File -> New -> Project
   * Set the project location inside the repository folder
   * Add all `.v` source files from the project, this includes modules and testbenches as well.

3. Compile the design

   * Compile -> Compile All
   * Ensure there are no compilation errors

### Running the Top-Level Simulation

1. Set the top-level testbench (`top_tb`)

2. Start the simulation

3. Run the simulation

4. (Optional) Add signals to the waveform

### Notes

* The main top-level module is: `top`
* Clock and reset are generated inside the testbench
* Some registers and buses may start as `X` (undefined)
