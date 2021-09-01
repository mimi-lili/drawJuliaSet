
	.global	__aeabi_idiv


	.text
	.global	drawJuliaSet
	.type	drawJuliaSet, %function

drawJuliaSet:   stmfd sp!, {lr}
                sub   sp, sp, #24
                adds  r14, r0,r1    @teacher ask to do
                cmp   r14, #0
                strne   r0, [sp, #4]  @Cx
                strne   r1, [sp, #8]  @Cy
                strne   r2, [sp, #12] @width
                strne   r3, [sp, #16] @height

                mov   r4, #-1   @x = 0
                b     loop1
@--------------------------------------------------------
loop1:
        add     r4, r4, #1      @x++

        ldr     r0, [sp, #12]   @r0 = width

        cmp     r4, r0          @x < width

        bge     done
        movle   r5, #-1
        b       loop2

@-------------------------------------------------
loop2:  add     r5, r5, #1
        ldr     r0, [sp, #16]  @r0 = height
        cmp     r5, r0         @y < height
        bge     loop1          @back to loop1
        @-------------------------------------
        mov     r7, r4          @Zx = x
        ldr     r1, [sp, #12]
        mov     r1, r1, asr #1  @width>>1
        sub     r0, r7, r1      @x - width>>1
        mov     r2, #500
        mul     r0, r0, r2
        mov     r2, #3
        mul     r0, r0, r2      @r0 = 1500*(x-(width>>1))
        bl      __aeabi_idiv
        mov     r7, r0          @Zx = 1500*(x-(width>>1))/(width>>1)
        @-------------------------------
        mov     r8, r5          @Zy
        ldr     r1, [sp, #16]   @r0 = height
        mov     r1, r1, asr #1
        sub     r0, r8, r1
        mov     r2, #1000
        mul     r0, r0, r2
        bl      __aeabi_idiv
        mov     r8, r0
        @--------------------------------
        mov     r6, #255        @i = maxIter
        mul     r0, r7, r7
        mul     r1, r8, r8
        add     r0, r0, r1      @r0 = Zx*ZX+Zy*Zy
        b       loop3
        @---------------------------------





@-------------------------------------------------
loop3:  bl      setR2           @r2 = 4000000
        cmp     r0, r2
        strgeh  r6, [sp, #20]
        ldrgeh  r6, [sp, #20]
        andge   r0, r6, #0xff      @r0 = (i&0xff)
        movge   r1, r0             @r1 = (i&0xff)
        movge   r0, r0, lsl #8     @r0 = ((i&0xff)<<8)
        orrge   r0, r0, r1         @r0 = ((i&0xff)<<8)|(i&0xff)
        mvnge   r0, r0             @(~color)
        movge   r1, #5
        movge   r2, #51
        mulge   r2, r1, r2        @ 255 = 5 * 51
        addge   r1, r2, #2        @ 255+2 = 257
        mulge   r1, r1, r2        @ 255 * 257 = 65535
        andge   r0, r0, r1        @(~color)&0xffff
        ldrge   r2, [sp, #12]
        mulge   r1, r5, r2        @r1 = y*640

        addge   r1, r1, r4        @y*640+x
        movge   r1, r1, asl #1

        addge   r2, sp, #28       @frame[y][x]
        addge   r1, r1, r2
        strge   r0, [r1]
        bge     loop2

        cmplt   r6, #0
        @-----------------------------------
        strleh  r6, [sp, #20]      @i is 16 bit
        ldrleh  r6, [sp, #20]
        andle   r0, r6, #255      @r0 = (i&0xff)
        movle   r1, r0             @r1 = (i&0xff)
        movle   r0, r0, lsl #8     @r0 = ((i&0xff)<<8)
        orrle   r0, r0, r1         @r0 = ((i&0xff)<<8)|(i&0xff)
        mvnle   r0, r0             @(~color)
        movle   r1, #5
        movle   r2, #51
        mulle   r2, r1, r2         @5 * 51 = 255
        addle   r1, r2, #2         @255 + 2 = 257
        mulle   r1, r1, r2         @255 *257 = 65535
        andle   r0, r0, r1        @(~color)&0xffff
        ldrle   r2, [sp, #12]   @ldr width
        mulle   r1, r5, r2      @r1 = y*640
        addle   r1, r1, r4        @y*640+x
        movge   r1, r1, asl #1

        addle   r2, sp, #28       @frame[y][x]
        addle   r1, r1, r2
        strle   r0, [r1]
        ble     loop2
        @-----------------------------------
        mul     r1, r7, r7
        mul     r2, r8, r8
        sub     r0, r1, r2      @r0 = Zx*Zx-Zy*Zy
        mov     r1, #1000
        bl      __aeabi_idiv
        ldr     r3, [sp, #4]   @Cx
        add     r9, r0, r3
        mul     r0, r8, r7
        add     r0, r0, r0
        mov     r1, #1000
        bl      __aeabi_idiv
        ldr     r3, [sp, #8]  @Cy
        add     r8, r0, r3      @Zy
        @-------------------------------------------
        mov     r7, r9         @Zx
        mul     r1, r7, r7
        mul     r2, r8, r8

        add     r0, r1, r2      @r0 = Zx^2+Zy^2
        sub     r6, r6, #1      @i--

        b       loop3





@--------------------------------------------------
setR2:  mov     r2, #2000
        mul     r2, r2, r2
        mov     pc, lr
@---------------------------------------------------

done:   add     sp, sp, #24
        ldmfd   sp!, {lr}
        mov     pc, lr
