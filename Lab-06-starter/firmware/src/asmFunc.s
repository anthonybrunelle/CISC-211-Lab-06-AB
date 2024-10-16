/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/

    /* Store dividend and divisor */
    ldr r2, =dividend
    str r0, [r2] /* Store dividend to r0 */
    ldr r2, =divisor
    str r1, [r2] /* Store divisor to r1 */
    
    /* Set mod and quotient to 0 */
    ldr r2, =quotient
    movs r3, 0 /* Move 0 into r3 */
    str r3, [r2] /* Store 0 into quotient */
    ldr r2, =mod
    str r3, [r2] /* Store 0 into mod */
    
    /* Make sure dividend and divisor != 0 */
    cmp r0, 0
    beq error /* Branch to error if dividend (r0) = 0 */
    cmp r1, 0
    beq error /* Branch to error if divisor (r1) = 0 */
    
    /* Prepare for subtraction loop */
    movs r4, 0 /* Move 0 into r4 */
    
division_loop:
    cmp r0, r1 /* Compare dividend (r0) to divisor (r1) */
    blt division_finish /* Branch to division_finish if dividend < divisor */
    subs r0, r0, r1 /* Subtract divisor (r1) from dividend (r0) */
    adds r4, r4, 1 /* Add 1 to r4 */
    b division_loop /* Loop back to division_loop */

division_finish:
    /* Store quotient and mod */
    ldr r2, =quotient
    str r4, [r2] /* Store quotient to r4 */
    ldr r2, =mod
    str r0, [r2] /* Store mod to r0 */
    
    /* Set we_have_a_problem to 0 */
    ldr r2, =we_have_a_problem
    movs r3, 0 /* Move 0 into r3 */
    str r3, [r2] /* Store 0 into we_have_a_problem */
    
    /* Set r0 to quotient address */
    ldr r0, =quotient
    
    /* We are done! */
    b done /* Branch to done */

error:
    /* Set we_have_a_problem to 1 */
    ldr r2, =we_have_a_problem
    movs r3, 1 /* Move 1 into r3 */
    str r3, [r2] /* Store r3 into we_have_a_problem */
    
    /* Set r0 to quotient address */
    ldr r0, =quotient
    b done /* Branch to done */
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




