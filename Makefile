clean:
	xargo clean

cargo:
	xargo build --release --target x86_64-unknown-intermezzos-gnu

# xargo test does NOT work with the intermezzos target. Don't know why.
test:
	xargo test

iso: cargo grub.cfg
	mkdir -p target/isofiles/boot/grub
	cp grub.cfg target/isofiles/boot/grub
	cp target/x86_64-unknown-intermezzos-gnu/release/intermezzos target/isofiles/boot/
	grub-mkrescue -o target/os.iso target/isofiles

run: iso
	qemu-system-x86_64 -cdrom target/os.iso
