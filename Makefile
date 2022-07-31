FLIPPER_FIRMWARE = flipperzero-firmware/dist/f7-D/flipper-z-f7-firmware-local.elf
APP = rustapp/target/thumbv7em-none-eabi/release/rustapp
EXTERNS = rustapp/externs.ld

all: $(APP)

flash: $(APP)
	flipperzero-firmware/scripts/storage.py -p /dev/serial/by-id/usb-Flipper_Devices_Inc.*-if00 send $(APP) /ext/rustapp.elf

$(FLIPPER_FIRMWARE):
	cd flipperzero-firmware && ./fbt
	#sudo docker-compose exec dev ./fbt

$(EXTERNS): $(FLIPPER_FIRMWARE)
	nm $(FLIPPER_FIRMWARE) | utils/nm2ld.py > $(EXTERNS)

$(APP): $(EXTERNS) rustapp/src/*.rs
	cd rustapp && cargo build --release
