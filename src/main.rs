#![no_std]
#![no_main]

mod arch;

use core::panic::PanicInfo;

#[unsafe(no_mangle)]
pub extern "C" fn kmain() {}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
