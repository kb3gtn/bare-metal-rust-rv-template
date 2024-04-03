#![no_std]
#![no_main]

use core::{arch::global_asm, panic::PanicInfo};

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

mod ioregisters;
//use IORegisters::IORegisters;

global_asm!(include_str!("init.s"));

/// Main program function
#[no_mangle]
extern "C" fn main() -> () {
    let mut rr : u32;
    // create io register accessor at base 0x8000000 1024 words long
    let ioregs = ioregisters::IORegisters::new(0x8000000, 1024);
    match ioregs.write(0, 0xFFFFFFFF ) {
        Ok(()) => (),
        _ => panic!(),
    };
    match ioregs.write(1, 0xFFFFFFFF ) {
        Ok(()) => (),
        _ => panic!(),
    };
    rr = match ioregs.read(0) {
        Ok(v) => v,
        _ => panic!(),
    };
    match ioregs.write(1, rr) {
        Ok(()) => (),
        _ => panic!(),
    };
    loop {}
}

