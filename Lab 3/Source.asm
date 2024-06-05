.686
.model flat, stdcall

.stack 100h

.data
triangle dw -3, 1, 5, 2, 1, -3
dots dw 2, 1, -1, -1, 4, -2
dAB dw 2 dup(0)
dBC dw 2 dup(0)
dCA dw 2 dup(0)
dAP dw 2 dup(0)
dBP dw 2 dup(0)
dCP dw 2 dup(0)
temp dw 3 dup(0)
res dw 0

.code
ExitProcess PROTO STDCALL :DWORD
Start:

5finit

fild triangle[4]
fild triangle[0]
fsub
fistp dAB[0]
fild triangle[6]
fild triangle[2]
fsub
fistp dAB[2]

fild triangle[8]
fild triangle[4]
fsub
fistp dBC[0]
fild triangle[10]
fild triangle[6]
fsub
fistp dBC[2]

fild triangle[0]
fild triangle[8]
fsub
fistp dCA[0]
fild triangle[2]
fild triangle[10]
fsub
fistp dCA[2]

xor ecx, ecx
checkdot:
fild dots[ecx*2]
fild triangle[0]
fsub
fistp dAP[0]
fild dots[ecx*2+2]
fild triangle[2]
fsub
fistp dAP[2]
fild dAB[0]
fild dAP[0]
fmul
fild dAB[2]
fild dAP[2]
fmul
fadd
fistp temp[0]

fild dots[ecx*2]
fild triangle[4]
fsub
fistp dBP[0]
fild dots[ecx*2+2]
fild triangle[6]
fsub
fistp dBP[2]
fild dBC[0]
fild dBP[0]
fmul
fild dBC[2]
fild dBP[2]
fmul
fadd
fistp temp[2]

fild dots[ecx*2]
fild triangle[8]
fsub
fistp dCP[0]
fild dots[ecx*2+2]
fild triangle[10]
fsub
fistp dCP[2]
fild dCA[0]
fild dCP[0]
fmul
fild dCA[2]
fild dCP[2]
fmul
fadd
fistp temp[4]

cmp temp[0], 0
ja elif
cmp temp[2], 0
ja elif
cmp temp[4], 0
ja elif
jmp dot_in

elif:
fild temp[0]
ftst
fstsw ax
sahf
jb dot_out
fild temp[2]
ftst
fstsw ax
sahf
jb dot_out
fild temp[4]
ftst
fstsw ax
sahf
jb dot_out
jmp dot_in

dot_out:
mov ax, res
shl ax, 1
mov res, ax
jmp checkout

dot_in:
mov ax, res
shl ax, 1
or ax, 1
mov res, ax

checkout:
inc ecx
cmp ecx, 3
jb checkdot

exit:
Invoke ExitProcess, res
End Start