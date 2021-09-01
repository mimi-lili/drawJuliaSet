         .data
msg:    .asciz    "*****Input ID*****\n"
msg2:   .asciz    "** Please Enter Member 1 ID:**\n"
msg3:   .asciz    "** Please Enter Member 2 ID:**\n"
msg4:   .asciz    "** Please Enter Member 3 ID:**\n"
msg5:   .asciz    "** Please Enter Command **\n"
msg6:   .asciz    "*****Print Team Member ID and ID Summation*****\n"
msg7:   .asciz    "ID Summation = "
msg8:   .asciz    "*****End Print*****\n"
Int:    .string   "%d"
int:    .string   "%d\n"
Str:    .string   "%s"
enter:  .asciz    "\n"
label:   .string   "yo"
ID1:    .word     0
ID2:    .word     0
ID3:    .word     0
sum:    .word     0
Command:.word     0

        .text
        .globl    id
        .globl    GetID1
        .globl    GetID2
        .globl    GetID3
        .globl    GetSum


id:      stmfd    sp!,{lr}
         ldr      r0, =msg   @*****Input ID*****
         bl       printf
         @=================================================
         ldr      r0, =msg2  @** Please Enter Member 1 ID:
         bl       printf
         ldr      r0, =Int
         ldr      r1, =ID1
         bl       scanf
         ldr      r0, =Int
         ldr      r4, =ID1   @now r4's value is the address
                             @so we can use the value in r4
                             @to load ID1(10727206)
         @===================================================
         ldr      r0, =msg3  @** Please Enter Member 2 ID:
         bl       printf
         ldr      r0, =Int
         ldr      r1, =ID2
         bl       scanf
         ldr      r0, =Int
         ldr      r5, =ID2   @when we load r5, then we can get
                             @ID2(10727212)
         @====================================================
         ldr      r0, =msg4  @** Please Enter Member 3 ID:
         bl       printf
         ldr      r0, =Int
         ldr      r1, =ID3
         bl       scanf
         ldr      r0, =Int
         ldr      r6, =ID3

         @=====================================================

         ldr      r0, =msg5  @"** Please Enter Command **
         bl       printf
         ldr      r0, =Str
         ldr      r1, =Command
         bl       scanf
         ldr      r0, =Str
         ldr      r1, =Command @when we load r1, we get the string
         ldr      r1, [r1]     @load r1 to get the string
         cmp      r1, #112     @strcmp( r1, "p" )
         @=====================================================
         ldr      r0, =msg6   @Print Team Member ID and ID Summation
         bleq     printf      @if ( strcmp(r1, "p") == 0 ) print msg6
         ldr      r0, =int
         ldr      r1, [r4]    @load r4 to get the ID1 (r1 = 10727206)
         mov      r2, r1      @ r2 = 10727206
         mov      r9, #0      @ r9 = 0
         add      r9, r9, r2  @ r9 = r9 + r2 = 0 + 10727206
         bleq     printf      @ @if ( strcmp(r1, "p") == 0 ) print 10727206
         @=======================================================
         ldr      r0, =int
         ldr      r1, [r5]    @ load r5 to get ID2( r1 = 10727212)
         mov      r2, r1
         add      r9, r9, r2  @ r9 = r9 + r2 = 10727206 + 20727212
         bleq     printf
         @=========================================================
         ldr      r0, =int
         ldr      r1, [r6]    @ r1 = 10727224
         mov      r2, r1
         add      r9, r9, r2  @ r9 = r9 + 10727224
         bleq     printf
         @=========================================================
         ldr      r10, =sum  @store the sum of IDs
         str      r9, [r10]  @sum = ID1+ID2+ID3
                             @r9 is the sum of  IDs
                             @we store the sum in =sum(label)
                             @and r10 point to the label(=sum)
                             @so we can use r10 to load the sum
         @=========================================================
         ldr      r0, =msg7   @print the sum
         bleq     printf
         ldr      r0, =int
         mov      r1, r9      @sum
         bleq     printf
         ldr      r0, =msg8   @End Print
         bleq     printf
         ldr      r0, =enter
         bleq     printf




         @=========================================================
         mov      r0, #0
         ldmfd    sp!, {lr}
         mov      pc, lr
         @=========================================================
         @Total:
         @Load/Store: 2  (ex: str r3,[r8], str r4, [r8, #12])
         @Operand2: 2 DONE!!
         @Condi Exe: 3 ( name.s->( ne & eq & vc ) ) Done!!!
         @sbcs r0, r3, r4 : name.s -> line 19
         @===================================================


GetID1: stmfd sp!, {lr}
        ldr r0, =ID1
        ldr r0, [r0]
        mov pc, lr
GetID2: stmfd sp!, {lr}
        ldr r0, =ID2
        ldr r0, [r0]
        mov pc, lr
GetID3: stmfd sp!, {lr}
        ldr r0, =ID3
        ldr r0, [r0]
        mov pc, lr
GetSum: stmfd sp!, {lr}
        ldr r0, =sum
        ldr r0, [r0]
        mov pc, lr
