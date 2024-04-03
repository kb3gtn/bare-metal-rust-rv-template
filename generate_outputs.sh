#!/bin/bash
# See: https://github.com/rust-embedded/cargo-binutils

# get cargo project name as base exectable name
prjname=`sed -n '2p' Cargo.toml | grep -oP 'name = "\K[^"]+'`


if [ $1 = "cleanup" ]; then
	rm ${prjname}.asm
	rm ${prjname}.bin
	rm ${prjname}_blockram.bin
	rm ${prjname}_blockram.hex
	exit 0
fi


# use cargo to build elf binary
echo "running cargo build on project blinky.."
cargo build
# Extract program from elf output and disassemble to asm dump
echo "Generating blinky assembly listing blinky.asm"
cargo objdump --release -- --disassemble > ${prjname}.asm
# Extract binary blob from elf output.
echo "Generating raw binary for blinky. (blinky.bin)"
cargo objcopy --release -- -O binary ${prjname}.bin
# pad out blockram to 128K
cp ${prjname}.bin ${prjname}_blockram.bin
truncate -s 128k ${prjname}_blockram.bin
# convert binary file to hex file to be loaded into blockram on FPGA.
echo "Convert bin file to hex file for blockram loading"
python3 bin2hex.py ${prjname}_blockram.bin ${prjname}_blockram.hex

