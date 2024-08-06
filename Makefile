GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
#ASPARAMS=--32
objects  = loader.o kernel.o
LDPARAMS = -melf_i386

ISOGRUBDIR = iso/boot/grub/

%.o: %.cpp
	g++ $(GPPPARAMS) -o $@ -c $<
%.o: $.s
	#as $(ASPARAMS) -o $@ $<
	as --32 -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

mykernel.iso: mykernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot
	echo 'set timeout=0' > $(ISOGRUBDIR)/grub.cfg
	echo 'set default=0' >> $(ISOGRUBDIR)/grub.cfg
	echo '' >> $(ISOGRUBDIR)/grub.cfg
	echo 'menuentry "my OS!" {' >> $(ISOGRUBDIR)/grub.cfg
	echo '	multiboot /boot/mykernel.bin' >> $(ISOGRUBDIR)/grub.cfg
	echo '	boot' >> $(ISOGRUBDIR)/grub.cfg
	echo '}' >> $(ISOGRUBDIR)/grub.cfg
	echo '' >> $(ISOGRUBDIR)/grub.cfg
	grub-mkrescue --output=$@ iso
	rm -rf iso
