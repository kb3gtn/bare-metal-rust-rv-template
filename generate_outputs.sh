#!/bin/bash
# See: https://github.com/rust-embedded/cargo-binutils

# get cargo project name as base exectable name
prjname=`sed -n '2p' Cargo.toml | grep -oP 'name = "\K[^"]+'`


if [ "$1" = "cleanup" ]; then
	rm ${prjname}.asm
	rm ${prjname}.bin
	rm ${prjname}_blockram.bin
	rm ${prjname}_blockram.hex
	cargo clean
	exit 0
fi


# use cargo to build elf binary
echo "running cargo build on project"
cargo build
# Extract program from elf output and disassemble to asm dump
echo "Generating assembly listing"
cargo objdump --release -- -d -M "no-aliases" > ${prjname}.asm
# Extract binary blob from elf output.
echo "Generating raw binary for myproj."
cargo objcopy --release -- -O binary ${prjname}.bin
# pad out blockram to 128K
cp ${prjname}.bin ${prjname}_blockram.bin
truncate -s 128k ${prjname}_blockram.bin
# convert binary file to hex file to be loaded into blockram on FPGA.
echo "Convert bin file to hex file for blockram loading"
python3 bin2hex.py ${prjname}_blockram.bin ${prjname}_blockram.hex
echo "Complete.."
