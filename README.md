# Rust Bare Metal starting Template
Based on work from https://github.com/defermelowie/bare-metal-rust-on-riscv    
This is a starting template for building bare metal minimal application for risc-v rv32 cpus.    
MIT LICENSE

# How to use this template
Modify the Cargo.toml file and change the project name.
Output binary will be call projectname.bin

# Helper Scripts
* generate_outputs.sh    
This script takes the elf file output from cargo build and uses cargo objdump to pull raw exectable information and to build into .bin and .hex formats that can be loaded into processor memory.
This script also generates a assembly dump of the program for debugging.

* bin2hex.py    
This python script converts a binary file, outputs a hex file.. (32 bits per line)

# Memory Layout
Memory layout for the program is defined via linker script in /res directory.
The default linker script (memory.ld) assumes a 256K memory only system, with boot address of 0x00000000.

# System Dependencies to build risc-v on x86_64 
will need to install riscv toolchain support:    

for basic riscv32i cpu support:
> rustup target add riscv32i-unknown-linux-gnu

You may need to install a risc-v toolchain for linker. 
Risc-v community has toolchains for multiple different OSes.

