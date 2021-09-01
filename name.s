
        .data
team:   .asciz    "Team 36\n"
Name1:  .asciz    "Ying Tzu Chen\n"
Name2:  .asciz    "Liang Tsen Li\n"
Name3:  .asciz    "Min Jia Li\n"
print:  .asciz    "*****Print Name*****\n"
end:    .asciz    "*****End Print*****\n"
Str:    .string   "%s"
label:  .string   "yo"
        .text
        .globl    name
        .globl    GetTeam
        .globl    GetName1
        .globl    GetName2
        .globl    GetName3

name:    stmfd    sp!, {lr}

         ldr      r0, =print   @*****Print Name*****
         bl       printf
         mov      r3, #9       @r3 = 9
         mov      r4, #7       @r4 = 7
         sbcs     r0, r3, r4   @r0 = r3-r4+c-1 = 9-7+0-1 = 1
         ldrne    r0, =team    @if r0 != 0 (ne = non-Zero)
         bl       printf       @then print Team 36
         mov      r3, #10      @r3 = 10
         cmp      r3, #10      @compare r3, 10
         ldreq    r0, =Name1   @if r3 = 10
         bl       printf       @Ying Tzu Chen
         add      r4, r4, #3   @r4 = r4+3 = 7+3 = 10
         cmp      r4, #10      @compare r4, 10
         ldreq    r0, =Name2   @if r4 = 10
         bl       printf       @Liang Tsen Li
         ldrvc    r0, =Name3   @if no overflow
         bl       printf       @Min Jia Li
         ldr      r0, =end     @*****End Print*****
         bl       printf
         @==================================================
         @store names so that we can use our name in main.s
         @==================================================
         ldr      r4, =Name1    @r4,r9,r10,r3 is temp register
         ldr      r9, =Name2    @ and i want to store our data
         ldr      r10, =Name3   @ in r8 (below)
         ldr      r8, =label
         ldr      r3, =team

         str      r3, [r8]       @store Team36 in r8
         str      r4, [r8, #12]  @store name1 in r8 + 12
         str      r9,[r8, #24]   @store name2 in r8 + 24
         str      r10, [r8, #32] @store name3 in r8 + 32
                                 @then we can use r8 to load
                                 @our data (in main.s)

         mov      r0, #0
         ldmfd    sp!, {lr}
         mov      pc, lr
         @===================================================
         @Total:
         @Load/Store: 2 (ex: str r3,[r8], str r4, [r8, #12])
         @Operand2: 2 DONE!!
         @Condi Exe: 3( ne & eq & vc ) Done!!!
         @sbcs r0, r3, r4 : line 19
         @===================================================

GetTeam:    stmfd sp!, {lr}
            ldr r0, =team
            mov pc, lr
GetName1:   stmfd sp!, {lr}
            ldr r0, =Name1
            mov pc, lr
GetName2:   stmfd sp!, {lr}
            ldr r0, =Name2
            mov pc, lr

GetName3:   stmfd sp!, {lr}
            ldr r0, =Name3
            mov pc,lr

