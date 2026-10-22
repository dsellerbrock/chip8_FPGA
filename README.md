# chip8_FPGA

A **CHIP-8** interpreter in Verilog for the **Arty Z7-20** board. Early stage: a fetch/decode/execute state machine over a RAM preloaded with the font and a Snake ROM, with the result shown on the LEDs.

| | |
|---|---|
| Language | Verilog |
| Board | Digilent Arty Z7-20 (125 MHz clock) |
| Tools | Altair DSim project (`CHIP8.dpf`); Vivado for the board constraints |
| Status | Active (started 2025-11) |
| License | MIT |

## Layout

| Path | What |
|---|---|
| `chip8_source/RTL/chip8_top.v` | Top level: RAM walker, 4-state FSM (invalid / fetch / decode / execute), LED output |
| `chip8_source/constraints/Arty-Z7-20-Master.xdc` | Pin constraints |
| `chip8_source/memory/font.mem` | Built-in hex font sprites |
| `chip8_source/memory/snake.mem` | Snake game ROM image |
| `CHIP8.dpf` | Simulation project |

## Status

| Done | Planned |
|---|---|
| Memory init from `.mem` files, instruction fetch loop | Full opcode set, display output, keypad input, timers |
