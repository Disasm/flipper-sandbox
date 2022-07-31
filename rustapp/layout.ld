MEMORY
{
    RAM : ORIGIN = 0x00000000, LENGTH = 128K
}

ENTRY(entry);
SECTIONS
{
    .text :
    {
        *(.text .text.*);
    } > RAM

    .rodata : ALIGN(4)
    {
        . = ALIGN(4);
        *(.rodata .rodata.*);

        /* 4-byte align the end (VMA) of this section.
           This is required by LLD to ensure the LMA of the following .data
           section will have the correct alignment. */
        . = ALIGN(4);
    } > RAM

    .data : ALIGN(4)
    {
        . = ALIGN(4);
        *(.data .data.*);
        . = ALIGN(4); /* 4-byte align the end (VMA) of this section */
    } > RAM

    .bss (NOLOAD) : ALIGN(4)
    {
        . = ALIGN(4);
        *(.bss .bss.*);
        *(COMMON); /* Uninitialized C statics */
        . = ALIGN(4); /* 4-byte align the end (VMA) of this section */
    } > RAM

    /DISCARD/ :
    {
        /* Unused exception related info that only wastes space */
        *(.ARM.exidx);
        *(.ARM.exidx.*);
        *(.ARM.extab.*);
        *(.ARM.attributes);
        *(.comment);
    }
}

//furi_log_print = 0x0806359d;
