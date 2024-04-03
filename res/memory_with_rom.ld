/*
Source: https://sourceware.org/binutils/docs/ld/Scripts.html
Source: https://docs.rs/riscv-rt/latest/riscv_rt/
Source: https://docs.rust-embedded.org/embedonomicon/memory-layout.html
*/

/* Define memory layout (RAM only architecture) */
MEMORY {
    ROM : ORIGIN = 0x00000000, LENGTH =  256K   /* 256K of rom available */
    RAM : ORIGIN = 0x00100000, LENGTH =  256K   /* 1K = 1 KiBi = 1024 bytes */
}

/* Define sections */
SECTIONS {
    . = ORIGIN(ROM);
    .init : { *(.init) } > REGION_INIT /* Set init as first section, this is the program's entry point if the PC starts at zero */
    .text : { *(.text .text.*) } > REGION_TEXT
    .rodata : { *(.rodata) } > REGION_RODATA
    . = ALIGN(4)
    . - ORIGIN(RAM)
    .data : { *(.data) } > REGION_DATA
    . = ALIGN(4);
}

/* Set aliases (since this is a RAM only architecture, all regions are in RAM) */
REGION_ALIAS("REGION_INIT", ROM);
REGION_ALIAS("REGION_TEXT", ROM);
REGION_ALIAS("REGION_RODATA", ROM);
REGION_ALIAS("REGION_DATA", RAM);

