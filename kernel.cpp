#define strColor_GRN 0x2a00
#define strColor_WHT 0xff00

void printf(char *str)
{
	unsigned short * VideoMemory = (unsigned short*)0xb8000;
	for(int i = 0; str[i] != '\0'; ++i)
		VideoMemory[i] = (VideoMemory[i] & strColor_GRN) | str[i];

}

extern "C" void kernelMain(void* multiboot_structure, unsigned int magicnumber)
{
	printf("HellofrmKNL\n");
	while(1);
}

