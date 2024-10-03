# **Single-Cycle and Pipelined MIPS Processor**

## **1. Project Overview**
The aim of this project is to **design and simulate** a **single-cycle** and **pipelined MIPS processor** using Verilog. The processor supports basic memory reference, arithmetic and logic, and jumping/branching instructions.

## **2. Supported Instructions**
The processor supports the following instructions:
- **Memory Reference**:
  - `lw` (Load Word)
  - `sw` (Store Word)
- **Arithmetic and Logic**:
  - `add` (Addition)
  - `addi` (Addition Immediate)
  - `sub` (Subtraction)
  - `and` (Logical AND)
  - `or` (Logical OR)
  - `slt` (Set Less Than)
- **Jumping and Branching**:
  - `j` (Jump)
  - `beq` (Branch if Equal)

## **3. Instruction Formats**
The format for each instruction is as follows:
- **R-type** (e.g., `add`, `sub`, `and`, `or`, `slt`):
  - `opcode` (6 bits), `rs` (5 bits), `rt` (5 bits), `rd` (5 bits), `shamt` (5 bits), `funct` (6 bits)
  
- **I-type** (e.g., `lw`, `sw`, `addi`, `beq`):
  - `opcode` (6 bits), `rs` (5 bits), `rt` (5 bits), `immediate` (16 bits)
  
- **J-type** (e.g., `j`):
  - `opcode` (6 bits), `address` (26 bits)

## **4. Features**
- **Single-Cycle Implementation**: Executes each instruction in a single clock cycle.
- **Pipelined Implementation**: Divides instruction execution into multiple stages to improve throughput.
  
## **5. Tools**
- **Design Language**: Verilog
- **Simulation Tools**: Any Verilog-compatible simulator (e.g., ModelSim, QuestaSim)
