ENTRY(start)

SECTIONS {
    . = 0x1000000;

    /* machine code */
    .text :{
        KEEP(*(.text.start));
        *(.text .text.*);
    }

    /* read only data */
    .rodata : ALIGN(4) {
        *(.rodata .rodata.*);
    }

    /* data with initial values */
    .data : ALIGN(4) {
        *(.data .data.*);
    }

    /* data that should be zero-filled at the start */
    .bss : ALIGN(4) {
        *(.bss .bss.* .sbss .sbss.*);

        . = ALIGN(16);
        . += 64 * 1024; /* 64KB */
        __stack_top = .;

        ASSERT(. < 0x18000000, "executable is too large");
    }
}
