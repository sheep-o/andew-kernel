void kernel_main() {
    char *vmem = (char *)0xb8000;
    vmem[0] = 'C';
    vmem[1] = 0x0f;
}
