#![no_std]
#![no_main]

pub mod arch;

use core::panic::PanicInfo;

pub fn kmain() {
    
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
