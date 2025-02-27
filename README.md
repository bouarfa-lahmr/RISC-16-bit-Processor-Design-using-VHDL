# RISC 16-bit Processor Design Using VHDL

This repository contains the design and implementation of a 16-bit RISC processor using VHDL, created as part of the module "Programmable Logic Circuits and VHDL Programming" in the Robotics & Cobotics program at EuroMed University of Fez.

## Project Overview

The project aims to design a 16-bit RISC (Reduced Instruction Set Computing) processor to understand the basic principles of processor design and gain hands-on experience with hardware description languages, particularly VHDL. The processor design includes essential components like the Arithmetic and Logic Unit (ALU), Instruction Decoder, Register File, and Control Unit.

## Features

- 16-bit RISC architecture with a simplified Instruction Set Architecture (ISA).
- Support for arithmetic, logical, control, jump, load, and store operations.
- Modular design approach with VHDL implementation for individual components.
- Simulation and validation of the processor using ModelSim.

## Table of Contents

1. [Introduction](#introduction)
2. [Design Methodology](#design-methodology)
3. [Instruction Set Architecture](#instruction-set-architecture)
4. [Processor Architecture](#processor-architecture)
5. [Implementation](#implementation)
6. [Results](#results)
7. [Conclusion](#conclusion)

## Introduction

### 1.1 Context and Motivation

The design of processors is a critical field in electronic and computer engineering, with applications in embedded systems, computing, and industrial systems. RISC architecture is known for its simplicity, speed, and low power consumption, making it ideal for embedded systems. This project focuses on designing a 16-bit RISC processor to explore processor design principles and acquire practical VHDL skills.

### 1.2 Project Objectives

- Design a 16-bit RISC processor using VHDL.
- Define a simple and effective instruction set architecture.
- Implement core components of the processor, including the ALU, Instruction Decoder, and Control Unit.
- Simulate and validate the design using ModelSim.

### 1.3 Scope of the Project

This project aims to design and implement a simplified 16-bit RISC processor for educational purposes. The processor will be designed entirely in VHDL and validated through simulations in ModelSim.

## Design Methodology

### 2.1 Instruction Set Architecture Overview

The processor’s ISA is designed to be simple and efficient for educational applications, supporting arithmetic and logical operations, control and jump instructions, and load/store operations.

### 2.2 Design Flow and Process

The design follows a structured approach:
1. Requirement analysis and specification definition.
2. Modular design of the processor's components.
3. VHDL coding for each module.
4. Simulation and testing of the modules using ModelSim.

### 2.3 Modular Design Approach

The project is divided into independent modules, such as the ALU, Instruction Decoder, Control Unit, and Register File. This modular approach simplifies the design process and allows for easy testing and reusability.

### 2.4 Testing and Validation

Each module is tested individually before being integrated into the full processor architecture. Simulation tools like ModelSim are used to ensure that the processor functions correctly.

## Instruction Set Architecture

The ISA consists of three primary categories:
- **Arithmetic and Logical Instructions**: Operations like ADD, SUB, AND, OR, NOT, etc.
- **Control and Jump Instructions**: Includes unconditional and conditional branch instructions.
- **Load and Store Instructions**: For transferring data between registers and memory.

## Processor Architecture

### 4.1 Processor Overview

The processor architecture includes the following components:
- **ALU**: Performs arithmetic and logical operations.
- **Instruction Decoder**: Decodes instructions and directs execution.
- **Control Unit**: Manages the flow of data within the processor.
- **Register File**: Holds data for operations.
- **Program Counter (PC)**: Tracks the execution address.
- **Memory**: Stores data and instructions.
- **CPU**: The central processing unit integrating all components.

### 4.2 ALU and Instruction Execution

The ALU handles all arithmetic and logical operations, while the instruction decoder breaks down each instruction for execution.

## Implementation

### 5.1 VHDL Coding for Modules

Each component of the processor (ALU, Instruction Decoder, Control Unit, etc.) was coded in VHDL. The VHDL code for each module is included in the respective directories in this repository.

### 5.2 Integration and Simulation

After coding the individual modules, they were integrated into the processor's full architecture. Simulations were conducted in ModelSim to verify the processor's functionality.

## Results

The processor design was successfully implemented and simulated. The simulations confirmed that the processor could execute the full range of supported instructions correctly, including arithmetic, logical, control, and memory operations.

## Conclusion

### 7.1 Achievements

- Successful design and implementation of a 16-bit RISC processor in VHDL.
- Full simulation and validation of the processor using ModelSim.

### 7.2 Challenges Encountered

- Ensuring correct timing and synchronization between modules.
- Debugging VHDL code during integration.

### 7.3 Future Work and Improvements

- Expanding the instruction set to support more complex operations.
- Optimizing the processor's performance for specific applications.
- Implementing a pipeline architecture to improve execution speed.

 https://github.com/yourusername/risc-16bit-processor-vhdl.git
