#![no_std]
#![no_main]

use panic_halt as _;

#[repr(u32)]
enum FuriLogLevel {
    FuriLogLevelDefault = 0,
    FuriLogLevelNone = 1,
    FuriLogLevelError = 2,
    FuriLogLevelWarn = 3,
    FuriLogLevelInfo = 4,
    FuriLogLevelDebug = 5,
    FuriLogLevelTrace = 6,
}

extern "C" {
    fn furi_log_print(loglevel: FuriLogLevel, format: *const u8);
}

#[no_mangle]
fn entry() -> i32 {
    unsafe { furi_log_print(FuriLogLevel::FuriLogLevelWarn, b"Hello from Rust111!\r\n\0".as_ptr()); }
    0
}
