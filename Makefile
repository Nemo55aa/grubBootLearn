GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
#ASPARAMS=--32
objects  = loader.o kernel.o
LDPARAMS = -melf_i386

%.o: %.cpp
	g++ $(GPPPARAMS) -o $@ -c $<
%.o: $.s
	#as $(ASPARAMS) -o $@ $<
	as --32 -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin
