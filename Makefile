KARCH = x86_64
SRCS := $(wildcard src/**/*.rs)  # Include all Rust files in src

override IMAGE_NAME := lithium-$(KARCH)

build:
	cargo build
.PHONY: build

limine/limine:
	rm -rf limine
	git clone https://github.com/limine-bootloader/limine.git --branch=v9.x-binary --depth 1
	$(MAKE) -C limine

build-iso: limine/limine build
	rm -rf iso_root
	mkdir -p iso_root/boot
	cp -v target/x86_64-lithium/debug/lithium-kernel iso_root/boot/lithium-kernel
	mkdir -p iso_root/boot/limine
	cp -v limine.conf iso_root/boot/limine
	mkdir -p iso_root/EFI/BOOT
	cp -v limine/limine-bios.sys limine/limine-bios-cd.bin limine/limine-uefi-cd.bin iso_root/boot/limine/
	cp -v limine/BOOTX64.EFI iso_root/EFI/BOOT/
	cp -v limine/BOOTIA32.EFI iso_root/EFI/BOOT/
	xorriso -as mkisofs -b boot/limine/limine-bios-cd.bin \
	  	-no-emul-boot -boot-load-size 4 -boot-info-table \
      	--efi-boot boot/limine/limine-uefi-cd.bin \
   	   	-efi-boot-part --efi-boot-image --protective-msdos-label \
      	iso_root -o $(IMAGE_NAME).iso
	./limine/limine bios-install $(IMAGE_NAME).iso

run: build-iso
	qemu-system-x86_64 -cdrom $(IMAGE_NAME).iso

clean:
	rm -rf iso_root
	rm -rf limine
	rm -rf $(IMAGE_NAME)