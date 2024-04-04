// Read/Write to registers in defined address space
// Assumes 32bit bus architecture with 32bit access regsiters.

pub struct IORegisters {
    baseaddr : u32,
    length   : u32,
}

//#[derive(Debug)]
pub enum IOAccessError {
    BoundsError
}

impl IORegisters {
    // create a new IO_Register access module
    pub fn new(baseaddr:u32, length:u32) -> Self{
        IORegisters {
            baseaddr: baseaddr,
            length : length
        }
    }
    pub fn write(&self, offsetaddr:u32, value:u32) -> Result<(),IOAccessError> {
        // bounds check
        if offsetaddr > self.length {
            return Err(IOAccessError::BoundsError);
        }
        let addr : u32 = self.baseaddr+offsetaddr;

        unsafe {
            let ptr : *mut u32 = (addr) as *mut u32;
            ptr.write_volatile(value);
        }

        Ok(())
    }
    pub fn read(&self, offsetaddr:u32) -> Result<u32,IOAccessError> {
        // bounds check
        if offsetaddr > self.length {
            return Err(IOAccessError::BoundsError);
        }

        let addr : u32 = self.baseaddr+offsetaddr;
        let value : u32;

        unsafe {
            let ptr : *mut u32 = (addr) as *mut u32;
            value = ptr.read_volatile();
        }
        Ok(value)
    }
}

