; Main Console program
; Wayne Cook
; 20 September 2024
; Show how to do input and output
; Revised: WWC 14 March 2024 Added new module
; Revised: WWC 15 March 2024 Added this comment ot force a new commit.
; Revised: WWC 13 September 2024 Minore updates for Fall 2024 semester.
; Register names:
; Register names are NOT case sensitive eax and EAX are the same register
; x86 uses 8 registers. EAX (Extended AX register has 32 bits while AX is
;	the right most 16 bits of EAX). AL is the right-most 8 bits.
; Writing into AX or AL effects the right most bits of EAX.
;     EAX - caller saved register - usually used for communication between
;			caller and callee.
;     EBX - Callee saved register
;     ECX - Caller saved register - Counter register 
;     EDX - Caller Saved register - data, I use it for saving and restoring
;			the return address
;     ESI - Callee Saved register - Source Index
;     EDI - Callee Saved register - Destination Index
;     ESP - Callee Saved register - stack pointer
;     EBP - Callee Saved register - base pointer.386P

.386P
.model flat

extern writeline: near
extern readline: near
extern charCount: near
extern writeNumber: near

.data

msg             byte  "Hello, World", 10, 0   ; ends with line feed (10) and NULL
prompt          byte  "Please type your name: ", 0 ; ends with string terminator (NULL or 0)
results         byte  10,"You typed: ", 0
numberPrint     byte  10,"The number is: ",0
numCharsToRead  dword 1024
bufferAddr      dword ?

.code

; Library calls used for input from and output to the console; This is the entry procedure that does all of the testing.
start PROC near
_start:
    ; Type a prompt for the user
    ; WriteConsole(handle, &Prompt[0], 17, &written, 0)
    push  offset prompt
    call  charCount
    push  eax
    push  offset prompt
    call  writeline

    ; Read what the user entered.
    call  readline
    ; The following embeds the above code in a common routine, so the more complicated call only needs to be written once.
    ; writeline(&results[0], 12)
    mov   bufferAddr, eax
    push  offset results
    call  charCount
    push  eax
    push  offset results
    call  writeline
    push  numCharsToRead
    push  bufferAddr
    call  writeline

    ; Try print a number
    push  offset numberPrint
    call  charCount
    push  eax
    push  offset numberPrint
    call  writeline
    push  7190
    call  writeNumber
    pop eax                                ; PRAMETER MUST BE REMOVED HERE TO EXIT PROPERLY.

    ; And it is time to exit.
exit:
    ret                                     ; Return to the main program.

start ENDP
END