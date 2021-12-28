gcc2_compiled.:
___gnu_compiled_c:
	.global _stringvar
.data
	.align 4
_stringvar:
	.word	_mem+4096
	.global _DEBUG
	.align 4
_DEBUG:
	.word	0
	.global _commands
	.align 4
_commands:
	.word	LC0
	.word	_do_hd
	.word	LC1
	.word	_do_info
	.word	LC2
	.word	_do_prog
	.word	LC3
	.word	_do_move
	.word	LC4
	.word	_do_exit
	.word	LC5
	.word	_do_fill
	.word	LC6
	.word	_do_verf
	.word	LC7
	.word	_do_check
	.word	LC8
	.word	_do_find
	.word	LC9
	.word	_do_modify
	.word	LC10
	.word	_do_load
	.word	LC11
	.word	_do_save
	.word	LC12
	.word	_do_reg
	.word	LC13
	.word	_do_set
	.word	LC14
	.word	_do_run
	.word	LC15
	.word	_do_mode
	.word	LC16
	.word	_do_list
	.word	LC17
	.word	_do_help
	.word	LC18
	.word	_do_reset
	.word	LC19
	.word	_do_comp
.text
	.align 8
LC19:
	.ascii "comp\0"
	.align 8
LC18:
	.ascii "reset\0"
	.align 8
LC17:
	.ascii "help\0"
	.align 8
LC16:
	.ascii "list\0"
	.align 8
LC15:
	.ascii "mode\0"
	.align 8
LC14:
	.ascii "run\0"
	.align 8
LC13:
	.ascii "set\0"
	.align 8
LC12:
	.ascii "reg\0"
	.align 8
LC11:
	.ascii "save\0"
	.align 8
LC10:
	.ascii "load\0"
	.align 8
LC9:
	.ascii "modify\0"
	.align 8
LC8:
	.ascii "find\0"
	.align 8
LC7:
	.ascii "check\0"
	.align 8
LC6:
	.ascii "verify\0"
	.align 8
LC5:
	.ascii "fill\0"
	.align 8
LC4:
	.ascii "exit\0"
	.align 8
LC3:
	.ascii "move\0"
	.align 8
LC2:
	.ascii "program\0"
	.align 8
LC1:
	.ascii "info\0"
	.align 8
LC0:
	.ascii "hd\0"
	.align 8
LC20:
	.ascii "stty cbreak -echo tandem\0"
	.align 8
LC21:
	.ascii "\12MG-monitor exited.\12\0"
	.align 8
LC22:
	.ascii "stty -cbreak echo -tandem\0"
	.align 4
	.global _main
	.proc	04
_main:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call ___main,0
	nop
	sethi %hi(LC20),%o0
	call _system,0
	or %o0,%lo(LC20),%o0
	call _shell,0
	nop
	sethi %hi(LC21),%o0
	call _prtmsg,0
	or %o0,%lo(LC21),%o0
	sethi %hi(LC22),%o0
	call _system,0
	or %o0,%lo(LC22),%o0
	call _exit,0
	mov 0,%o0
	ret
	restore
	.align 8
LC23:
	.ascii "Error: %s\12\0"
	.align 4
	.global _error
	.proc	04
_error:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	call _printf,0
	mov %i0,%o1
	mov 3,%o0
	sethi %hi(_errnum),%o1
	st %o0,[%o1+%lo(_errnum)]
	ret
	restore
	.align 8
LC24:
	.ascii "\12MG Basic/monitor\12"
	.ascii "4.0 Jan 8, 1996\12\12Type help if in doubt!\12\0"
	.align 8
LC25:
	.ascii "\12Mgmon\12\0"
	.align 8
LC26:
	.ascii "Undefined command, try help!\12\0"
	.align 4
	.global _shell
	.proc	04
_shell:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	mov 7,%l0
	sethi %hi(LC24),%o0
	call _prtmsg,0
	or %o0,%lo(LC24),%o0
	sethi %hi(LC25),%l3
	sethi %hi(LC26),%l2
	sethi %hi(_commands),%o0
	or %o0,%lo(_commands),%l1
	cmp %l0,0
L23:
	be L17
	nop
	call _prtmsg,0
	or %l3,%lo(LC25),%o0
L17:
	call _buffer,0
	nop
	call _ignblk_pos,0
	nop
	add %o0,-48,%o0
	cmp %o0,9
	bgu L18
	nop
	call _do_comp,0
	nop
	b L21
	cmp %l0,5
L18:
	call _lower,0
	nop
	call _sekcom,0
	nop
	mov %o0,%l0
	cmp %o0,-1
	bne L22
	add %l0,-1,%o0
	call _prtmsg,0
	or %l2,%lo(LC26),%o0
	add %l0,-1,%o0
L22:
	cmp %o0,19
	bgu L16
	sll %o0,3,%o0
	add %o0,%l1,%o0
	ld [%o0+4],%o0
	call %o0,0
	nop
L16:
	cmp %l0,5
L21:
	bne L23
	cmp %l0,0
	ret
	restore
	.align 4
	.global _memr
	.proc	04
_memr:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_mem),%g2
	or %g2,%lo(_mem),%g2
	retl
	ldsb [%o0+%g2],%o0
	.align 4
	.global _memw
	.proc	04
_memw:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_mem),%g2
	or %g2,%lo(_mem),%g2
	retl
	stb %o1,[%o0+%g2]
	.align 4
	.global _prtchr
	.proc	04
_prtchr:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(__iob+20),%o1
	ld [%o1+%lo(__iob+20)],%o0
	or %o1,%lo(__iob+20),%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L36
	st %o2,[%o1+%lo(__iob+20)]
	ld [%o3+4],%o1
	add %o1,1,%o0
	st %o0,[%o3+4]
	b L37
	stb %i0,[%o1]
L36:
	lduh [%o3+16],%o0
	andcc %o0,128,%g0
	be L38
	sub %g0,%o2,%o0
	ld [%o3+12],%o1
	cmp %o0,%o1
	bge L42
	and %i0,0xff,%o0
	ld [%o3+4],%o1
	and %i0,0xff,%o0
	cmp %o0,10
	be L40
	stb %i0,[%o1]
	ld [%o3+4],%o0
	add %o0,1,%o0
	b L37
	st %o0,[%o3+4]
L40:
	ld [%o3+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %o3,%o1
	b,a L37
L38:
	and %i0,0xff,%o0
L42:
	sethi %hi(__iob+20),%o1
	call __flsbuf,0
	or %o1,%lo(__iob+20),%o1
L37:
	ret
	restore
	.align 4
	.global _getchr
	.proc	04
_getchr:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(__iob),%o1
	ld [%o1+%lo(__iob)],%o0
	or %o1,%lo(__iob),%o2
	add %o0,-1,%o0
	cmp %o0,0
	bl L47
	st %o0,[%o1+%lo(__iob)]
	ld [%o2+4],%o1
	add %o1,1,%o0
	st %o0,[%o2+4]
	b L48
	ldub [%o1],%o0
L47:
	call __filbuf,0
	mov %o2,%o0
L48:
	sll %o0,24,%i0
	sra %i0,24,%i0
	ret
	restore
	.align 4
	.global _prtmsg
	.proc	04
_prtmsg:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	ldsb [%i0],%o0
	cmp %o0,0
	be L51
	sethi %hi(__iob+20),%l1
	or %l1,%lo(__iob+20),%l0
	ldsb [%i0],%o0
L75:
	cmp %o0,10
	bne L53
	add %i0,1,%i0
	ld [%l1+%lo(__iob+20)],%o0
	mov 10,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bge L70
	st %o2,[%l1+%lo(__iob+20)]
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L57
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L73
	mov 10,%o0
	ld [%l0+4],%o0
	b L67
	stb %o3,[%o0]
L57:
	b L73
	mov 10,%o0
L53:
	ld [%l1+%lo(__iob+20)],%o0
	ldub [%i0-1],%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L63
	st %o2,[%l1+%lo(__iob+20)]
L70:
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L50
	stb %o3,[%o1]
L63:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L65
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L73
	mov %o3,%o0
	ld [%l0+4],%o0
	cmp %o3,10
	be L67
	stb %o3,[%o0]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L50
	st %o0,[%l0+4]
L67:
	ld [%l0+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l0,%o1
	b L74
	ldsb [%i0],%o0
L65:
	mov %o3,%o0
L73:
	call __flsbuf,0
	or %l1,%lo(__iob+20),%o1
L50:
	ldsb [%i0],%o0
L74:
	cmp %o0,0
	bne,a L75
	ldsb [%i0],%o0
L51:
	ret
	restore
	.align 4
	.global _buffer
	.proc	04
_buffer:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(_pos),%o0
	st %g0,[%o0+%lo(_pos)]
	mov 0,%l5
	mov %o0,%l3
	sethi %hi(__iob+20),%l2
	sethi %hi(__iob),%l6
	or %l6,%lo(__iob),%l4
	add %l4,20,%l0
	ld [%l6+%lo(__iob)],%o0
L140:
	add %o0,-1,%o0
	cmp %o0,0
	bl L81
	st %o0,[%l6+%lo(__iob)]
	ld [%l4+4],%o1
	add %o1,1,%o0
	st %o0,[%l4+4]
	b L82
	ldub [%o1],%o0
L81:
	call __filbuf,0
	mov %l4,%o0
L82:
	mov %o0,%l1
	sll %l1,24,%o0
	sra %o0,24,%o0
	cmp %o0,8
	bne L132
	sll %l1,24,%o0
	ld [%l3+%lo(_pos)],%o0
	cmp %o0,0
	ble L83
	add %o0,-1,%o0
	ld [%l2+%lo(__iob+20)],%o1
	st %o0,[%l3+%lo(_pos)]
	mov 8,%o3
	add %o1,-1,%o2
	cmp %o2,0
	bl L86
	st %o2,[%l2+%lo(__iob+20)]
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L85
	stb %o3,[%o1]
L86:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L88
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L133
	mov 8,%o0
	ld [%l0+4],%o0
	stb %o3,[%o0]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L85
	st %o0,[%l0+4]
L88:
	mov 8,%o0
L133:
	call __flsbuf,0
	or %l2,%lo(__iob+20),%o1
L85:
	ld [%l2+%lo(__iob+20)],%o0
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L93
	st %o2,[%l2+%lo(__iob+20)]
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L92
	stb %o3,[%o1]
L93:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L95
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L134
	mov 32,%o0
	ld [%l0+4],%o0
	stb %o3,[%o0]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L92
	st %o0,[%l0+4]
L95:
	mov 32,%o0
L134:
	call __flsbuf,0
	or %l2,%lo(__iob+20),%o1
L92:
	ld [%l2+%lo(__iob+20)],%o0
	mov 8,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L100
	st %o2,[%l2+%lo(__iob+20)]
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L83
	stb %o3,[%o1]
L100:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L102
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L135
	mov 8,%o0
	ld [%l0+4],%o0
	stb %o3,[%o0]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L83
	st %o0,[%l0+4]
L102:
	mov 8,%o0
L135:
	call __flsbuf,0
	or %l2,%lo(__iob+20),%o1
L83:
	sll %l1,24,%o0
L132:
	sra %o0,24,%o0
	cmp %o0,31
	ble L106
	ld [%l3+%lo(_pos)],%o0
	cmp %o0,79
	bg L136
	cmp %o0,1
	ld [%l2+%lo(__iob+20)],%o0
	add %o0,-1,%o2
	cmp %o2,0
	bl L109
	st %o2,[%l2+%lo(__iob+20)]
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L108
	stb %l1,[%o1]
L109:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L111
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L137
	and %l1,0xff,%o0
	ld [%l0+4],%o1
	and %l1,0xff,%o0
	cmp %o0,10
	be L113
	stb %l1,[%o1]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L108
	st %o0,[%l0+4]
L113:
	ld [%l0+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l0,%o1
	b L138
	ld [%l3+%lo(_pos)],%o1
L111:
	and %l1,0xff,%o0
L137:
	call __flsbuf,0
	or %l2,%lo(__iob+20),%o1
L108:
	ld [%l3+%lo(_pos)],%o1
L138:
	add %o1,1,%o0
	st %o0,[%l3+%lo(_pos)]
	sethi %hi(_inbuf),%o0
	or %o0,%lo(_inbuf),%o0
	stb %l1,[%o1+%o0]
L106:
	ld [%l3+%lo(_pos)],%o0
	cmp %o0,1
L136:
	bne L139
	sll %l1,24,%o0
	sra %o0,24,%o0
	cmp %o0,43
	be L117
	cmp %o0,45
	bne L139
	sll %l1,24,%o0
L117:
	mov 1,%l5
	sll %l1,24,%o0
L139:
	sra %o0,24,%o0
	cmp %o0,10
	be L78
	sethi %hi(_pos),%o1
	cmp %l5,0
	be L140
	ld [%l6+%lo(__iob)],%o0
L78:
	ld [%o1+%lo(_pos)],%o2
	add %o2,1,%o0
	st %o0,[%o1+%lo(_pos)]
	sethi %hi(_inbuf),%o0
	or %o0,%lo(_inbuf),%o0
	stb %l1,[%o2+%o0]
	ld [%o1+%lo(_pos)],%o1
	mov 10,%o4
	stb %l1,[%o1+%o0]
	sethi %hi(__iob+20),%o1
	ld [%o1+%lo(__iob+20)],%o0
	or %o1,%lo(__iob+20),%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L119
	st %o2,[%o1+%lo(__iob+20)]
	ld [%o3+4],%o1
	add %o1,1,%o0
	st %o0,[%o3+4]
	b L118
	stb %o4,[%o1]
L119:
	lduh [%o3+16],%o0
	andcc %o0,128,%g0
	be L121
	sub %g0,%o2,%o0
	ld [%o3+12],%o1
	cmp %o0,%o1
	bge L141
	mov 10,%o0
	ld [%o3+4],%o0
	stb %o4,[%o0]
	ld [%o3+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %o3,%o1
	b L142
	sethi %hi(__iob+20),%o1
L121:
	mov 10,%o0
L141:
	sethi %hi(__iob+20),%o1
	call __flsbuf,0
	or %o1,%lo(__iob+20),%o1
L118:
	sethi %hi(__iob+20),%o1
L142:
	ld [%o1+%lo(__iob+20)],%o0
	mov 13,%o4
	or %o1,%lo(__iob+20),%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L126
	st %o2,[%o1+%lo(__iob+20)]
	ld [%o3+4],%o1
	add %o1,1,%o0
	st %o0,[%o3+4]
	b L125
	stb %o4,[%o1]
L126:
	lduh [%o3+16],%o0
	andcc %o0,128,%g0
	be L128
	sub %g0,%o2,%o0
	ld [%o3+12],%o1
	cmp %o0,%o1
	bge L143
	mov 13,%o0
	ld [%o3+4],%o0
	stb %o4,[%o0]
	ld [%o3+4],%o0
	add %o0,1,%o0
	b L125
	st %o0,[%o3+4]
L128:
	mov 13,%o0
L143:
	sethi %hi(__iob+20),%o1
	call __flsbuf,0
	or %o1,%lo(__iob+20),%o1
L125:
	sethi %hi(_pos),%o0
	st %g0,[%o0+%lo(_pos)]
	ret
	restore
	.align 4
	.global _getadr
	.proc	04
_getadr:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%i0
L148:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L149
	sll %i0,4,%o0
	b L148
	add %o0,%o1,%i0
L149:
	ret
	restore
	.align 4
	.global _getbyt
	.proc	04
_getbyt:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	nop
	call _gethex,0
	nop
	call _gethex,0
	mov %o0,%i0
	orcc %o0,%g0,%o1
	bl L156
	cmp %i0,0
	bge L155
	sll %i0,4,%o0
L156:
	b L157
	mov -1,%i0
L155:
	add %o0,%o1,%i0
L157:
	ret
	restore
	.align 4
	.global _gethex
	.proc	04
_gethex:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _nxtch,0
	nop
	cmp %o0,96
	bg,a L164
	add %o0,-32,%o0
L164:
	add %o0,-48,%o0
	cmp %o0,9
	bg,a L165
	add %o0,-7,%o0
L165:
	cmp %o0,15
	bg,a L166
	mov -1,%o0
L166:
	cmp %o0,0
	bl,a L167
	mov -1,%o0
L167:
	ret
	restore %g0,%o0,%o0
	.align 4
	.global _nxtch
	.proc	04
_nxtch:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_pos),%o1
	sethi %hi(_inbuf),%g2
	ld [%o1+%lo(_pos)],%g3
	or %g2,%lo(_inbuf),%g2
	ldub [%g3+%g2],%o0
	cmp %o0,10
	be L171
	add %g3,1,%g2
	st %g2,[%o1+%lo(_pos)]
L171:
	retl
	nop
	.align 4
	.global _prtadr
	.proc	04
_prtadr:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(65535),%o0
	or %o0,%lo(65535),%l0
	cmp %i0,%l0
	bleu L175
	nop
	call _prthex,0
	srl %i0,24,%o0
	sra %i0,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %i0,%l0,%i0
L175:
	call _prthex,0
	sra %i0,8,%o0
	call _prthex,0
	and %i0,0xff,%o0
	ret
	restore
	.align 4
	.global _prthex
	.proc	04
_prthex:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	and %i0,0xff,%o0
	call _prtnib,0
	srl %o0,4,%o0
	call _prtnib,0
	and %i0,15,%o0
	ret
	restore
	.align 4
	.global _prtnib
	.proc	04
_prtnib:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	mov %i0,%o2
	and %o2,0xff,%o0
	cmp %o0,9
	bgu,a L179
	add %i0,7,%o2
L179:
	sethi %hi(__iob+20),%o0
	ld [%o0+%lo(__iob+20)],%o1
	add %o2,48,%o4
	or %o0,%lo(__iob+20),%o3
	add %o1,-1,%o2
	cmp %o2,0
	bl L181
	st %o2,[%o0+%lo(__iob+20)]
	ld [%o3+4],%o1
	add %o1,1,%o0
	st %o0,[%o3+4]
	b L180
	stb %o4,[%o1]
L181:
	lduh [%o3+16],%o0
	andcc %o0,128,%g0
	be L183
	sub %g0,%o2,%o0
	ld [%o3+12],%o1
	cmp %o0,%o1
	bge L187
	and %o4,0xff,%o0
	ld [%o3+4],%o1
	and %o4,0xff,%o0
	cmp %o0,10
	be L185
	stb %o4,[%o1]
	ld [%o3+4],%o0
	add %o0,1,%o0
	b L180
	st %o0,[%o3+4]
L185:
	ld [%o3+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %o3,%o1
	b,a L180
L183:
	and %o4,0xff,%o0
L187:
	sethi %hi(__iob+20),%o1
	call __flsbuf,0
	or %o1,%lo(__iob+20),%o1
L180:
	ret
	restore
	.align 4
	.global _lower
	.proc	04
_lower:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_inbuf),%g2
	or %g2,%lo(_inbuf),%o0
	add %o0,79,%o1
	ldub [%o0],%g2
L202:
	and %g2,0xff,%g3
	cmp %g3,64
	bleu L198
	cmp %g3,95
	bgu L198
	add %g2,32,%g2
	stb %g2,[%o0]
L198:
	add %o0,1,%o0
	cmp %o0,%o1
	ble,a L202
	ldub [%o0],%g2
	retl
	nop
	.align 4
	.global _ignblk_pos
	.proc	04
_ignblk_pos:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_pos),%o1
	sethi %hi(_inbuf),%g2
	ld [%o1+%lo(_pos)],%g3
	or %g2,%lo(_inbuf),%o0
	ldub [%g3+%o0],%g2
	cmp %g2,32
	bne L211
	sethi %hi(_pos),%g2
	mov %o1,%g3
	ld [%g3+%lo(_pos)],%g2
L212:
	add %g2,1,%g2
	st %g2,[%g3+%lo(_pos)]
	ldub [%g2+%o0],%g2
	cmp %g2,32
	be L212
	ld [%g3+%lo(_pos)],%g2
	sethi %hi(_pos),%g2
L211:
	sethi %hi(_inbuf),%g3
	ld [%g2+%lo(_pos)],%g2
	or %g3,%lo(_inbuf),%g3
	retl
	ldub [%g2+%g3],%o0
	.align 4
	.global _sekcom
	.proc	04
_sekcom:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_pos),%g3
	st %g0,[%g3+%lo(_pos)]
	mov 0,%o0
	sethi %hi(_inbuf),%o1
	ldub [%o1+%lo(_inbuf)],%g2
	cmp %g2,32
	bne L217
	mov 0,%o4
	or %o1,%lo(_inbuf),%o1
	ld [%g3+%lo(_pos)],%g2
L231:
	add %g2,1,%g2
	st %g2,[%g3+%lo(_pos)]
	ldub [%g2+%o1],%g2
	cmp %g2,32
	be L231
	ld [%g3+%lo(_pos)],%g2
L217:
	sethi %hi(_pos),%g2
	sethi %hi(_inbuf),%g3
	ld [%g2+%lo(_pos)],%o1
	or %g3,%lo(_inbuf),%g3
	ldub [%o1+%g3],%g2
	cmp %g2,10
	be L214
	cmp %o4,0
	bne,a L235
	sethi %hi(_pos),%g3
	cmp %o0,19
	bg L232
	cmp %o4,0
	mov %o1,%g1
	sethi %hi(_commands),%g2
	or %g2,%lo(_commands),%g4
	mov 0,%o2
L234:
	sll %o0,3,%o5
	add %g1,%o2,%g2
L233:
	ldub [%g2+%g3],%g2
	cmp %g2,46
	bne L224
	mov 0,%o3
	mov 1,%o4
	add %o2,1,%o2
L224:
	ld [%o5+%g4],%g2
	ldsb [%g2+%o2],%o1
	cmp %o1,0
	be,a L225
	mov 1,%o4
L225:
	add %g1,%o2,%g2
	ldub [%g2+%g3],%g2
	cmp %o1,%g2
	bne,a L223
	mov 1,%o3
	add %o2,1,%o2
L223:
	add %o3,%o4,%g2
	cmp %g2,0
	be,a L233
	add %g1,%o2,%g2
	cmp %o4,0
	bne L232
	add %o0,1,%o0
	cmp %o0,19
	ble,a L234
	mov 0,%o2
	cmp %o4,0
L232:
	bne L235
	sethi %hi(_pos),%g3
	b L214
	mov -1,%o0
L235:
	ld [%g3+%lo(_pos)],%g2
	add %o2,%g2,%g2
	st %g2,[%g3+%lo(_pos)]
L214:
	retl
	nop
	.align 8
LC27:
	.ascii "  \0"
	.align 4
	.global _do_hd
	.proc	04
_do_hd:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L238:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L239
	sll %l0,4,%o0
	b L238
	add %o0,%o1,%l0
L239:
	call _ignblk_pos,0
	mov %l0,%l4
	mov 0,%l0
L241:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L242
	sll %l0,4,%o0
	b L241
	add %o0,%o1,%l0
L242:
	call _ignblk_pos,0
	mov %l0,%l7
	mov 0,%l0
L244:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L245
	sll %l0,4,%o0
	b L244
	add %o0,%o1,%l0
L245:
	orcc %l0,%g0,%l6
	be L247
	cmp %l6,32
	ble L313
	sethi %hi(65535),%o0
L247:
	mov 8,%l6
	sethi %hi(65535),%o0
L313:
	or %o0,%lo(65535),%i1
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%i0
	sethi %hi(__iob+20),%l3
	or %l3,%lo(__iob+20),%l2
	cmp %l4,%i1
L326:
	bleu L251
	mov %l4,%l0
	call _prthex,0
	srl %l4,24,%o0
	sra %l4,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %l4,%i1,%l0
L251:
	call _prthex,0
	sra %l0,8,%o0
	call _prthex,0
	and %l0,0xff,%o0
	sethi %hi(LC27),%o0
	call _prtmsg,0
	or %o0,%lo(LC27),%o0
	mov 0,%l1
	cmp %l1,%l6
	bge,a L314
	ld [%l3+%lo(__iob+20)],%o0
	mov 32,%l5
	add %l4,%l1,%o0
L316:
	ldub [%o0+%i0],%l0
	call _prtnib,0
	srl %l0,4,%o0
	call _prtnib,0
	and %l0,15,%o0
	ld [%l3+%lo(__iob+20)],%o0
	add %o0,-1,%o2
	cmp %o2,0
	bl L258
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L254
	stb %l5,[%o1]
L258:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L260
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L315
	mov 32,%o0
	ld [%l2+4],%o0
	stb %l5,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L254
	st %o0,[%l2+4]
L260:
	mov 32,%o0
L315:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L254:
	add %l1,1,%l1
	cmp %l1,%l6
	bl L316
	add %l4,%l1,%o0
	ld [%l3+%lo(__iob+20)],%o0
L314:
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L266
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L265
	stb %o3,[%o1]
L266:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L268
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L317
	mov 32,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L265
	st %o0,[%l2+4]
L268:
	mov 32,%o0
L317:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L265:
	ld [%l3+%lo(__iob+20)],%o0
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L273
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L272
	stb %o3,[%o1]
L273:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L275
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L318
	mov 32,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L272
	st %o0,[%l2+4]
L275:
	mov 32,%o0
L318:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L272:
	mov 0,%l1
	cmp %l1,%l6
	bge L319
	ld [%l3+%lo(__iob+20)],%o0
	mov %l4,%o0
L322:
	ldub [%o0+%i0],%o3
	add %l4,1,%l4
	and %o3,127,%o0
	cmp %o0,31
	bg L283
	mov %o0,%o3
	mov 46,%o3
L283:
	ld [%l3+%lo(__iob+20)],%o0
	add %o0,-1,%o2
	cmp %o2,0
	bl L285
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L281
	stb %o3,[%o1]
L285:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L287
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L320
	and %o3,0xff,%o0
	ld [%l2+4],%o1
	and %o3,0xff,%o0
	cmp %o0,10
	be L289
	stb %o3,[%o1]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L281
	st %o0,[%l2+4]
L289:
	ld [%l2+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l2,%o1
	b L321
	add %l1,1,%l1
L287:
	and %o3,0xff,%o0
L320:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L281:
	add %l1,1,%l1
L321:
	cmp %l1,%l6
	bl L322
	mov %l4,%o0
	ld [%l3+%lo(__iob+20)],%o0
L319:
	mov 10,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L293
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L292
	stb %o3,[%o1]
L293:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L295
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L323
	mov 10,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l2,%o1
	b L324
	ld [%l3+%lo(__iob+20)],%o0
L295:
	mov 10,%o0
L323:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L292:
	ld [%l3+%lo(__iob+20)],%o0
L324:
	mov 13,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L300
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L299
	stb %o3,[%o1]
L300:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L302
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L325
	mov 13,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L299
	st %o0,[%l2+4]
L302:
	mov 13,%o0
L325:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L299:
	cmp %l7,0
	bne L306
	cmp %l4,%l7
	sethi %hi(__iob),%o1
	ld [%o1+%lo(__iob)],%o0
	or %o1,%lo(__iob),%o2
	add %o0,-1,%o0
	cmp %o0,0
	bl L309
	st %o0,[%o1+%lo(__iob)]
	ld [%o2+4],%o1
	add %o1,1,%o0
	st %o0,[%o2+4]
	b L310
	ldub [%o1],%o0
L309:
	call __filbuf,0
	mov %o2,%o0
L310:
	sll %o0,24,%o0
	sra %o0,24,%o0
	cmp %o0,10
	be L249
	cmp %l4,%i1
	b,a L326
L306:
	ble L326
	cmp %l4,%i1
L249:
	ret
	restore
	.align 4
	.global _do_info
	.proc	04
_do_info:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(_commands),%o0
	or %o0,%lo(_commands),%l5
	sethi %hi(__iob+20),%l3
	or %l3,%lo(__iob+20),%l0
	mov 0,%l4
	mov 0,%l1
L362:
	ld [%l4+%l5],%o0
L358:
	ldsb [%o0+%l1],%l2
	ld [%l3+%lo(__iob+20)],%o0
	add %l1,1,%l1
	add %o0,-1,%o2
	st %o2,[%l3+%lo(__iob+20)]
	cmp %o2,0
	bl L335
	mov %l2,%o3
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L333
	stb %o3,[%o1]
L335:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L337
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L356
	and %o3,0xff,%o0
	ld [%l0+4],%o0
	cmp %o3,10
	be L339
	stb %o3,[%o0]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L333
	st %o0,[%l0+4]
L339:
	ld [%l0+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l0,%o1
	b L357
	cmp %l2,0
L337:
	and %o3,0xff,%o0
L356:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L333:
	cmp %l2,0
L357:
	bne,a L358
	ld [%l4+%l5],%o0
	ld [%l3+%lo(__iob+20)],%o0
	mov 10,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L342
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L341
	stb %o3,[%o1]
L342:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L344
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L359
	mov 10,%o0
	ld [%l0+4],%o0
	stb %o3,[%o0]
	ld [%l0+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l0,%o1
	b L360
	ld [%l3+%lo(__iob+20)],%o0
L344:
	mov 10,%o0
L359:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L341:
	ld [%l3+%lo(__iob+20)],%o0
L360:
	mov 13,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L349
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l0+4],%o1
	add %o1,1,%o0
	st %o0,[%l0+4]
	b L330
	stb %o3,[%o1]
L349:
	lduh [%l0+16],%o0
	andcc %o0,128,%g0
	be L351
	sub %g0,%o2,%o0
	ld [%l0+12],%o1
	cmp %o0,%o1
	bge L361
	mov 13,%o0
	ld [%l0+4],%o0
	stb %o3,[%o0]
	ld [%l0+4],%o0
	add %o0,1,%o0
	b L330
	st %o0,[%l0+4]
L351:
	mov 13,%o0
L361:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L330:
	add %l4,8,%l4
	cmp %l4,152
	ble L362
	mov 0,%l1
	ret
	restore
	.align 4
	.global _do_prog
	.proc	04
_do_prog:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L365:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L366
	sll %l0,4,%o0
	b L365
	add %o0,%o1,%l0
L366:
	mov %l0,%l1
	mov 0,%l5
	sethi %hi(65535),%o0
	or %o0,%lo(65535),%l7
	sethi %hi(__iob+20),%l3
	or %l3,%lo(__iob+20),%l2
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%l4
	sethi %hi(_inbuf),%i0
	or %i0,%lo(_inbuf),%l6
	cmp %l1,%l7
L420:
	bleu L370
	mov %l1,%l0
	call _prthex,0
	srl %l1,24,%o0
	sra %l1,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %l1,%l7,%l0
L370:
	call _prthex,0
	sra %l0,8,%o0
	call _prthex,0
	and %l0,0xff,%o0
	ld [%l3+%lo(__iob+20)],%o0
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L372
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L371
	stb %o3,[%o1]
L372:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L417
	mov 32,%o0
	ld [%l2+12],%o1
	sub %g0,%o2,%o0
	cmp %o0,%o1
	bge L417
	mov 32,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L371
	st %o0,[%l2+4]
L417:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L371:
	ldub [%l1+%l4],%l0
	call _prtnib,0
	srl %l0,4,%o0
	call _prtnib,0
	and %l0,15,%o0
	ld [%l3+%lo(__iob+20)],%o0
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L381
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L380
	stb %o3,[%o1]
L381:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L383
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L418
	mov 32,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L380
	st %o0,[%l2+4]
L383:
	mov 32,%o0
L418:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L380:
	call _buffer,0
	nop
	ldsb [%i0+%lo(_inbuf)],%o0
	cmp %o0,46
	be,a L367
	mov 1,%l5
	bg L414
	cmp %o0,74
	cmp %o0,43
	be,a L367
	add %l1,1,%l1
	bg L415
	cmp %o0,45
	cmp %o0,10
	be L419
	cmp %l5,0
	cmp %o0,34
	be,a L397
	ldub [%l6+1],%o0
	b,a L406
L415:
	be,a L367
	add %l1,-1,%l1
	b,a L406
L414:
	be L391
	cmp %o0,106
	bne L406
	nop
L391:
	call _ignblk_pos,0
	nop
	call _gethex,0
	nop
	call _gethex,0
	mov %o0,%l0
	orcc %o0,%g0,%o1
	bl L394
	cmp %l0,0
	bge L393
	sll %l0,4,%o0
L394:
	b L395
	mov -1,%l0
L393:
	add %o0,%o1,%l0
L395:
	sub %l0,%l1,%o0
	add %o0,2,%o0
	b L367
	stb %o0,[%l1+%l4]
L397:
	cmp %o0,10
	be L419
	cmp %l5,0
	add %l6,1,%o2
	ldub [%o2],%o0
L421:
	add %o2,1,%o2
	mov %l1,%o1
	stb %o0,[%o1+%l4]
	ldub [%o2],%o0
	cmp %o0,10
	bne L421
	add %l1,1,%l1
	b L419
	cmp %l5,0
L406:
	call _ignblk_pos,0
	nop
	call _gethex,0
	nop
	call _gethex,0
	mov %o0,%l0
	orcc %o0,%g0,%o1
	bl L410
	cmp %l0,0
	bge L409
	sll %l0,4,%o0
L410:
	b L411
	mov -1,%l0
L409:
	add %o0,%o1,%l0
L411:
	mov %l0,%o1
	cmp %o1,-1
	be L367
	mov %l1,%o0
	add %l1,1,%l1
	b L406
	stb %o1,[%o0+%l4]
L367:
	cmp %l5,0
L419:
	be L420
	cmp %l1,%l7
	ret
	restore
	.align 4
	.global _do_move
	.proc	04
_do_move:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L424:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L425
	sll %l0,4,%o0
	b L424
	add %o0,%o1,%l0
L425:
	call _ignblk_pos,0
	mov %l0,%l1
	mov 0,%l0
L427:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L428
	sll %l0,4,%o0
	b L427
	add %o0,%o1,%l0
L428:
	call _ignblk_pos,0
	mov %l0,%l2
	mov 0,%l0
L430:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L431
	sll %l0,4,%o0
	b L430
	add %o0,%o1,%l0
L431:
	cmp %l1,%l2
	be L433
	mov %l0,%o2
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%o3
L436:
	mov %l1,%o0
	add %l1,1,%l1
	mov %o2,%o1
	add %o2,1,%o2
	ldsb [%o0+%o3],%o0
	cmp %l1,%l2
	bne L436
	stb %o0,[%o1+%o3]
L433:
	ret
	restore
	.align 4
	.global _do_exit
	.proc	04
_do_exit:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	retl
	nop
	.align 4
	.global _do_fill
	.proc	04
_do_fill:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L456:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L457
	sll %l0,4,%o0
	b L456
	add %o0,%o1,%l0
L457:
	call _ignblk_pos,0
	mov 0,%l2
L459:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L460
	sll %l2,4,%o0
	b L459
	add %o0,%o1,%l2
L460:
	call _ignblk_pos,0
	nop
	call _gethex,0
	nop
	call _gethex,0
	mov %o0,%l1
	orcc %o0,%g0,%o1
	bl L463
	cmp %l1,0
	bge,a L462
	sll %l1,4,%o0
L463:
	b L464
	mov -1,%l1
L462:
	add %o0,%o1,%l1
L464:
	cmp %l0,%l2
	be L466
	mov %l1,%o0
	and %o0,0xff,%o1
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%o2
L468:
	mov %l0,%o0
	add %l0,1,%l0
	cmp %l0,%l2
	bne L468
	stb %o1,[%o0+%o2]
L466:
	ret
	restore
	.align 8
LC28:
	.ascii "Checksum \0"
	.align 8
LC29:
	.ascii "\12\0"
	.align 4
	.global _do_check
	.proc	04
_do_check:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L471:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L472
	sll %l0,4,%o0
	b L471
	add %o0,%o1,%l0
L472:
	call _ignblk_pos,0
	mov 0,%l1
L474:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L475
	sll %l1,4,%o0
	b L474
	add %o0,%o1,%l1
L475:
	mov %l1,%o1
	cmp %l0,%o1
	bge L477
	mov 0,%l2
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%o2
L479:
	mov %l0,%o0
	add %l0,1,%l0
	ldsb [%o0+%o2],%o0
	cmp %l0,%o1
	bl L479
	add %l2,%o0,%l2
L477:
	sethi %hi(LC28),%o0
	call _prtmsg,0
	or %o0,%lo(LC28),%o0
	mov %l2,%l0
	sethi %hi(65535),%o0
	or %o0,%lo(65535),%l1
	cmp %l0,%l1
	bleu L481
	nop
	call _prthex,0
	srl %l0,24,%o0
	sra %l0,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %l0,%l1,%l0
L481:
	call _prthex,0
	sra %l0,8,%o0
	call _prthex,0
	and %l0,0xff,%o0
	sethi %hi(LC29),%o0
	call _prtmsg,0
	or %o0,%lo(LC29),%o0
	ret
	restore
	.align 8
LC30:
	.ascii "Error at \0"
	.align 4
	.global _do_verf
	.proc	04
_do_verf:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L484:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L485
	sll %l0,4,%o0
	b L484
	add %o0,%o1,%l0
L485:
	call _ignblk_pos,0
	mov %l0,%l1
	mov 0,%l0
L487:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L488
	sll %l0,4,%o0
	b L487
	add %o0,%o1,%l0
L488:
	call _ignblk_pos,0
	mov %l0,%l6
	mov 0,%l0
L490:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L491
	sll %l0,4,%o0
	b L490
	add %o0,%o1,%l0
L491:
	cmp %l1,%l6
	bge L493
	sethi %hi(65535),%o0
	or %o0,%lo(65535),%i0
	sethi %hi(__iob+20),%l5
	or %l5,%lo(__iob+20),%l2
	add %l2,-20,%l7
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%o0
	add %l0,%o0,%l4
	add %l1,%o0,%l3
L521:
	ldsb [%l3],%o1
	ldsb [%l4],%o0
	cmp %o1,%o0
	be L494
	sethi %hi(LC30),%o0
	call _prtmsg,0
	or %o0,%lo(LC30),%o0
	cmp %l1,%i0
	bleu L498
	mov %l1,%l0
	call _prthex,0
	srl %l1,24,%o0
	sra %l1,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %l1,%i0,%l0
L498:
	call _prthex,0
	sra %l0,8,%o0
	call _prthex,0
	and %l0,0xff,%o0
	ld [%l5+%lo(__iob+20)],%o0
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L500
	st %o2,[%l5+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L499
	stb %o3,[%o1]
L500:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L522
	mov 32,%o0
	ld [%l2+12],%o1
	sub %g0,%o2,%o0
	cmp %o0,%o1
	bge L522
	mov 32,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L499
	st %o0,[%l2+4]
L522:
	call __flsbuf,0
	or %l5,%lo(__iob+20),%o1
L499:
	ldub [%l3],%l0
	call _prtnib,0
	srl %l0,4,%o0
	call _prtnib,0
	and %l0,15,%o0
	ld [%l5+%lo(__iob+20)],%o0
	mov 32,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L509
	st %o2,[%l5+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L508
	stb %o3,[%o1]
L509:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L523
	mov 32,%o0
	ld [%l2+12],%o1
	sub %g0,%o2,%o0
	cmp %o0,%o1
	bge,a L523
	mov 32,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L508
	st %o0,[%l2+4]
L523:
	call __flsbuf,0
	or %l5,%lo(__iob+20),%o1
L508:
	ldub [%l4],%l0
	call _prtnib,0
	srl %l0,4,%o0
	call _prtnib,0
	and %l0,15,%o0
	sethi %hi(LC29),%o0
	call _prtmsg,0
	or %o0,%lo(LC29),%o0
	sethi %hi(__iob),%o1
	ld [%o1+%lo(__iob)],%o0
	add %o0,-1,%o0
	cmp %o0,0
	bl L519
	st %o0,[%o1+%lo(__iob)]
	ld [%l7+4],%o1
	add %o1,1,%o0
	st %o0,[%l7+4]
	b L520
	ldub [%o1],%o0
L519:
	call __filbuf,0
	mov %l7,%o0
L520:
	sll %o0,24,%o0
	sra %o0,24,%o0
	cmp %o0,10
	be L493
	nop
L494:
	add %l3,1,%l3
	add %l1,1,%l1
	cmp %l1,%l6
	bl L521
	add %l4,1,%l4
L493:
	ret
	restore
	.align 4
	.global _do_find
	.proc	04
_do_find:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L526:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L527
	sll %l0,4,%o0
	b L526
	add %o0,%o1,%l0
L527:
	call _ignblk_pos,0
	mov %l0,%l4
	mov 0,%l0
L529:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L530
	sll %l0,4,%o0
	b L529
	add %o0,%o1,%l0
L530:
	mov %l0,%l1
	mov %l4,%o0
	add %l4,1,%l4
	sethi %hi(_mem),%o1
	or %o1,%lo(_mem),%o1
	ldsb [%o0+%o1],%l5
	mov %o1,%l6
	sethi %hi(65535),%o0
	or %o0,%lo(65535),%l7
	sethi %hi(__iob+20),%l3
	or %l3,%lo(__iob+20),%l2
	mov 0,%o2
L535:
	add %l4,%o2,%o0
	ldsb [%o0+%l6],%o1
	add %l1,%o2,%o0
	ldsb [%o0+%l6],%o0
	xor %o1,%o0,%o1
	subcc %g0,%o1,%g0
	subx %g0,-1,%o1
	cmp %o2,%l5
	bl,a L565
	mov 1,%o0
	mov 0,%o0
L565:
	andcc %o1,%o0,%g0
	be L536
	cmp %o2,%l5
	b L535
	add %o2,1,%o2
L536:
	bl L539
	cmp %l1,%l7
	bleu L541
	mov %l1,%l0
	call _prthex,0
	srl %l1,24,%o0
	sra %l1,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %l1,%l7,%l0
L541:
	call _prthex,0
	sra %l0,8,%o0
	call _prthex,0
	and %l0,0xff,%o0
	ld [%l3+%lo(__iob+20)],%o0
	add %l1,1,%l1
	mov 10,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L543
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L542
	stb %o3,[%o1]
L543:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L545
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L561
	mov 10,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	ldub [%o0],%o0
	call __flsbuf,0
	mov %l2,%o1
	b L562
	ld [%l3+%lo(__iob+20)],%o0
L545:
	mov 10,%o0
L561:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L542:
	ld [%l3+%lo(__iob+20)],%o0
L562:
	mov 13,%o3
	add %o0,-1,%o2
	cmp %o2,0
	bl L550
	st %o2,[%l3+%lo(__iob+20)]
	ld [%l2+4],%o1
	add %o1,1,%o0
	st %o0,[%l2+4]
	b L549
	stb %o3,[%o1]
L550:
	lduh [%l2+16],%o0
	andcc %o0,128,%g0
	be L552
	sub %g0,%o2,%o0
	ld [%l2+12],%o1
	cmp %o0,%o1
	bge L563
	mov 13,%o0
	ld [%l2+4],%o0
	stb %o3,[%o0]
	ld [%l2+4],%o0
	add %o0,1,%o0
	b L549
	st %o0,[%l2+4]
L552:
	mov 13,%o0
L563:
	call __flsbuf,0
	or %l3,%lo(__iob+20),%o1
L549:
	sethi %hi(__iob),%o1
	ld [%o1+%lo(__iob)],%o0
	or %o1,%lo(__iob),%o2
	add %o0,-1,%o0
	cmp %o0,0
	bl L558
	st %o0,[%o1+%lo(__iob)]
	ld [%o2+4],%o1
	add %o1,1,%o0
	st %o0,[%o2+4]
	b L559
	ldub [%o1],%o0
L558:
	call __filbuf,0
	mov %o2,%o0
L559:
	sll %o0,24,%o0
	sra %o0,24,%o2
	cmp %o2,10
	be,a L534
	mov 0,%l1
	b L564
	cmp %l1,0
L539:
	add %l1,1,%l1
L534:
	cmp %l1,0
L564:
	bne L535
	mov 0,%o2
	ret
	restore
	.align 4
	.global _do_modify
	.proc	04
_do_modify:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L577:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L578
	sll %l0,4,%o0
	b L577
	add %o0,%o1,%l0
L578:
	call _ignblk_pos,0
	nop
	call _gethex,0
	nop
	call _gethex,0
	mov %o0,%l1
	orcc %o0,%g0,%o1
	bl L581
	sethi %hi(_mem),%o0
	cmp %l1,0
	bge,a L580
	sll %l1,4,%o0
L581:
	b L584
	mov -1,%l1
L580:
	add %o0,%o1,%l1
	sethi %hi(_mem),%o0
L584:
	or %o0,%lo(_mem),%o0
	stb %l1,[%l0+%o0]
	ret
	restore
	.align 4
	.global _do_reg
	.proc	04
_do_reg:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	retl
	nop
	.align 4
	.global _do_set
	.proc	04
_do_set:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	retl
	nop
	.align 4
	.global _do_mode
	.proc	04
_do_mode:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	retl
	nop
	.align 4
	.global _not
	.proc	04
_not:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	subcc %g0,%o0,%g0
	retl
	subx %g0,-1,%o0
	.align 8
LC31:
	.ascii "rb\0"
	.align 8
LC32:
	.ascii "The file does not exist\12\0"
	.align 8
LC33:
	.ascii "End address : \0"
	.align 4
	.global _do_load
	.proc	04
_do_load:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L600:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L601
	sll %l0,4,%o0
	b L600
	add %o0,%o1,%l0
L601:
	sethi %hi(_pos),%o3
	sethi %hi(_inbuf),%o0
	ld [%o3+%lo(_pos)],%o1
	or %o0,%lo(_inbuf),%o2
	ldub [%o1+%o2],%o0
	cmp %o0,32
	bne L604
	mov %l0,%l1
	mov %o3,%o1
	ld [%o1+%lo(_pos)],%o0
L613:
	add %o0,1,%o0
	st %o0,[%o1+%lo(_pos)]
	ldub [%o0+%o2],%o0
	cmp %o0,32
	be,a L613
	ld [%o1+%lo(_pos)],%o0
L604:
	sethi %hi(_inbuf),%l0
	call _scancr,0
	or %l0,%lo(_inbuf),%l0
	sethi %hi(_pos),%o0
	ld [%o0+%lo(_pos)],%o0
	sethi %hi(LC31),%o1
	or %o1,%lo(LC31),%o1
	call _fopen,0
	add %o0,%l0,%o0
	sethi %hi(_fil),%o1
	cmp %o0,0
	bne L606
	st %o0,[%o1+%lo(_fil)]
	sethi %hi(LC32),%o0
	call _prtmsg,0
	or %o0,%lo(LC32),%o0
	b,a L607
L606:
	mov %o1,%l2
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%l0
L608:
	call _fgetc,0
	ld [%l2+%lo(_fil)],%o0
	mov %o0,%o1
	cmp %o1,-1
	be L609
	sethi %hi(LC33),%o0
	mov %l1,%o0
	add %l1,1,%l1
	b L608
	stb %o1,[%o0+%l0]
L609:
	call _prtmsg,0
	or %o0,%lo(LC33),%o0
	mov %l1,%l0
	sethi %hi(65535),%o0
	or %o0,%lo(65535),%l1
	cmp %l0,%l1
	bleu L612
	nop
	call _prthex,0
	srl %l0,24,%o0
	sra %l0,16,%o0
	call _prthex,0
	and %o0,0xff,%o0
	and %l0,%l1,%l0
L612:
	call _prthex,0
	sra %l0,8,%o0
	call _prthex,0
	and %l0,0xff,%o0
	sethi %hi(LC29),%o0
	call _prtmsg,0
	or %o0,%lo(LC29),%o0
L607:
	ret
	restore
	.align 8
LC34:
	.ascii "Syntax error\0"
	.align 8
LC35:
	.ascii "wb\0"
	.align 4
	.global _do_save
	.proc	04
_do_save:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L616:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L617
	sll %l0,4,%o0
	b L616
	add %o0,%o1,%l0
L617:
	call _ignblk_pos,0
	mov %l0,%l1
	mov 0,%l0
L619:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L620
	sll %l0,4,%o0
	b L619
	add %o0,%o1,%l0
L620:
	sethi %hi(_pos),%o3
	sethi %hi(_inbuf),%o0
	ld [%o3+%lo(_pos)],%o1
	or %o0,%lo(_inbuf),%o2
	ldub [%o1+%o2],%o0
	cmp %o0,32
	bne L631
	sethi %hi(_pos),%l2
	mov %o3,%o1
	ld [%o1+%lo(_pos)],%o0
L632:
	add %o0,1,%o0
	st %o0,[%o1+%lo(_pos)]
	ldub [%o0+%o2],%o0
	cmp %o0,32
	be L632
	ld [%o1+%lo(_pos)],%o0
	sethi %hi(_pos),%l2
L631:
	sethi %hi(_inbuf),%o0
	ld [%l2+%lo(_pos)],%o1
	or %o0,%lo(_inbuf),%l3
	ldub [%o1+%l3],%o0
	cmp %o0,10
	bne L621
	nop
	sethi %hi(LC34),%o0
	call _prtmsg,0
	or %o0,%lo(LC34),%o0
	b,a L626
L621:
	call _scancr,0
	nop
	ld [%l2+%lo(_pos)],%o0
	sethi %hi(LC35),%o1
	or %o1,%lo(LC35),%o1
	call _fopen,0
	add %o0,%l3,%o0
	sethi %hi(_fil),%o1
	cmp %l1,%l0
	be L628
	st %o0,[%o1+%lo(_fil)]
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%l3
	mov %o1,%l2
	mov %l1,%o0
L633:
	ldsb [%o0+%l3],%o0
	ld [%l2+%lo(_fil)],%o1
	call _fputc,0
	add %l1,1,%l1
	cmp %l1,%l0
	bne,a L633
	mov %l1,%o0
L628:
	sethi %hi(_fil),%o0
	call _fclose,0
	ld [%o0+%lo(_fil)],%o0
L626:
	ret
	restore
	.align 4
	.global _scancr
	.proc	04
_scancr:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_inbuf),%g2
	or %g2,%lo(_inbuf),%g3
	add %g3,79,%o0
	ldub [%g3],%g2
L646:
	cmp %g2,10
	be,a L643
	stb %g0,[%g3]
L643:
	add %g3,1,%g3
	cmp %g3,%o0
	ble,a L646
	ldub [%g3],%g2
	retl
	nop
	.align 4
	.global _do_reset
	.proc	04
_do_reset:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	retl
	nop
	.align 8
LC36:
	.ascii "Type info to see a list of all available commands. \12\12\0"
	.align 8
LC37:
	.ascii "All commands may be abbrevated by . E g program 2000 is eqv. p.2000\12\0"
	.align 8
LC38:
	.ascii "All end addresses should be one extra.\12\0"
	.align 8
LC39:
	.ascii "    Save 8000 0 AX7 saves file AX7 from 8000 to FFFF\12\0"
	.align 8
LC40:
	.ascii "Load <address> filename will load file to RAM\12\0"
	.align 8
LC41:
	.ascii "All commands with addresses have syntax start, end, to\12\0"
	.align 8
LC42:
	.ascii "Use dis command to dissassemble 6809 instructions\12\0"
	.align 8
LC43:
	.ascii "When using set command, use only one character for register\12\0"
	.align 8
LC44:
	.ascii "    E g 'set p e650' for setting pc to e650. set pc e650 => pc=000C\12\0"
	.align 8
LC45:
	.ascii "When simulating 6809, use run. Dont't forget to set registers\12\0"
	.align 8
LC46:
	.ascii " especially PC (check with 'reg'\12\0"
	.align 8
LC47:
	.ascii "Reset command will reset registers as 6809 (PC=[FFFE])\12\0"
	.align 8
LC48:
	.ascii "Known bugs: V-flag not working, DAA instruction not implemented\12\0"
	.align 8
LC49:
	.ascii "Use ass command to get one line assembler. Note: use $ for hex!\12\0"
	.align 8
LC50:
	.ascii "\12Good luck !\12\0"
	.align 4
	.global _do_help
	.proc	04
_do_help:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(LC36),%o0
	call _printf,0
	or %o0,%lo(LC36),%o0
	sethi %hi(LC37),%o0
	call _printf,0
	or %o0,%lo(LC37),%o0
	sethi %hi(LC38),%o0
	call _printf,0
	or %o0,%lo(LC38),%o0
	sethi %hi(LC39),%o0
	call _printf,0
	or %o0,%lo(LC39),%o0
	sethi %hi(LC40),%o0
	call _printf,0
	or %o0,%lo(LC40),%o0
	sethi %hi(LC41),%o0
	call _printf,0
	or %o0,%lo(LC41),%o0
	sethi %hi(LC42),%o0
	call _printf,0
	or %o0,%lo(LC42),%o0
	sethi %hi(LC43),%o0
	call _printf,0
	or %o0,%lo(LC43),%o0
	sethi %hi(LC44),%o0
	call _printf,0
	or %o0,%lo(LC44),%o0
	sethi %hi(LC45),%o0
	call _printf,0
	or %o0,%lo(LC45),%o0
	sethi %hi(LC46),%o0
	call _printf,0
	or %o0,%lo(LC46),%o0
	sethi %hi(LC47),%o0
	call _printf,0
	or %o0,%lo(LC47),%o0
	sethi %hi(LC48),%o0
	call _printf,0
	or %o0,%lo(LC48),%o0
	sethi %hi(LC49),%o0
	call _printf,0
	or %o0,%lo(LC49),%o0
	sethi %hi(LC50),%o0
	call _printf,0
	or %o0,%lo(LC50),%o0
	ret
	restore
	.align 4
	.global _do_comp
	.proc	04
_do_comp:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(_pos),%o3
	sethi %hi(_inbuf),%o0
	ld [%o3+%lo(_pos)],%o1
	or %o0,%lo(_inbuf),%o2
	ldub [%o1+%o2],%o0
	cmp %o0,32
	bne L661
	sethi %hi(_mem+4096),%l0
	mov %o3,%o1
	ld [%o1+%lo(_pos)],%o0
L662:
	add %o0,1,%o0
	st %o0,[%o1+%lo(_pos)]
	ldub [%o0+%o2],%o0
	cmp %o0,32
	be,a L662
	ld [%o1+%lo(_pos)],%o0
	sethi %hi(_mem+4096),%l0
L661:
	or %l0,%lo(_mem+4096),%l0
	sethi %hi(_pos),%o0
	ld [%o0+%lo(_pos)],%o2
	mov %l0,%o1
	sethi %hi(_inbuf),%o0
	or %o0,%lo(_inbuf),%o0
	call _compline,0
	add %o2,%o0,%o0
	add %l0,-4096,%o0
	call _basicins,0
	mov %l0,%o1
	ret
	restore
	.align 8
LC51:
	.ascii "%s\12\0"
	.align 4
	.global _do_list
	.proc	04
_do_list:
	!#PROLOGUE# 0
	save %sp,-264,%sp
	!#PROLOGUE# 1
	call _ignblk_pos,0
	mov 0,%l0
L672:
	call _gethex,0
	nop
	mov %o0,%o1
	cmp %o1,-1
	be L673
	sll %l0,4,%o0
	b L672
	add %o0,%o1,%l0
L673:
	mov %l0,%l1
	add %fp,-168,%l2
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%l3
	sethi %hi(LC51),%l4
	mov %l2,%o0
L677:
	add %l1,%l3,%l0
	call _list_line,0
	mov %l0,%o1
	or %l4,%lo(LC51),%o0
	call _printf,0
	mov %l2,%o1
	ldub [%l0],%o0
	add %l1,%o0,%l1
	ldub [%l1+%l3],%o0
	cmp %o0,0
	bne L677
	mov %l2,%o0
	ret
	restore
	.align 4
	.global _basic_new
	.proc	04
_basic_new:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi %hi(_vars),%g2
	or %g2,%lo(_vars),%o2
	sethi %hi(_stringadr),%g2
	or %g2,%lo(_stringadr),%g2
	mov -1,%o1
	sethi %hi(_strings_used),%o0
	mov 0,%g3
L691:
	st %g0,[%g3+%o2]
	st %o1,[%g3+%g2]
	add %g3,4,%g3
	cmp %g3,116
	ble L691
	st %g0,[%o0+%lo(_strings_used)]
	sethi %hi(_stack),%g2
	or %g2,%lo(_stack),%g2
	mov 36,%g3
	st %g0,[%g3+%g2]
L696:
	addcc %g3,-4,%g3
	bpos,a L696
	st %g0,[%g3+%g2]
	retl
	nop
	.align 8
LC52:
	.ascii "Empty program\0"
	.align 8
LC53:
	.ascii "Exec adr %04x token %02x err %dx\12\0"
	.align 8
LC54:
	.ascii "for without to\0"
	.align 4
	.global _do_run
	.proc	04
_do_run:
	!#PROLOGUE# 0
	save %sp,-120,%sp
	!#PROLOGUE# 1
	sethi %hi(_vars),%o0
	or %o0,%lo(_vars),%o4
	sethi %hi(_stringadr),%o0
	or %o0,%lo(_stringadr),%o0
	mov -1,%o3
	sethi %hi(_strings_used),%o2
	mov 0,%o1
L702:
	st %g0,[%o1+%o4]
	st %o3,[%o1+%o0]
	add %o1,4,%o1
	cmp %o1,116
	ble L702
	st %g0,[%o2+%lo(_strings_used)]
	sethi %hi(_stack),%o0
	or %o0,%lo(_stack),%o0
	mov 36,%o1
	st %g0,[%o1+%o0]
L740:
	addcc %o1,-4,%o1
	bpos,a L740
	st %g0,[%o1+%o0]
	mov 0,%l1
	sethi %hi(_errnum),%l0
	st %g0,[%l0+%lo(_errnum)]
	sethi %hi(_mem),%o0
	or %o0,%lo(_mem),%l2
	st %l2,[%fp-20]
	sethi %hi(_stack_pnt),%l4
	ldub [%o0+%lo(_mem)],%o0
	cmp %o0,0
	bne L707
	st %g0,[%l4+%lo(_stack_pnt)]
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC52),%o1
	call _printf,0
	or %o1,%lo(LC52),%o1
	mov 3,%o0
	st %o0,[%l0+%lo(_errnum)]
L707:
	ld [%fp-20],%o0
	ld [%l0+%lo(_errnum)],%o1
	add %o0,4,%o0
	cmp %o1,0
	bne L710
	st %o0,[%fp-20]
	mov %l2,%i3
	mov %l0,%l2
	add %fp,-20,%l3
	mov %l4,%l0
	sethi %hi(_data_stack),%o0
	or %o0,%lo(_data_stack),%l5
	add %l5,4,%i0
	sethi %hi(_vars),%o0
	or %o0,%lo(_vars),%l7
	add %l5,-4,%i1
	add %l5,-8,%i2
	sethi %hi(_stack),%o0
	or %o0,%lo(_stack),%l4
	add %l4,-4,%l6
	sethi %hi(_DEBUG),%o0
L745:
	ld [%o0+%lo(_DEBUG)],%o0
	cmp %o0,0
	be L711
	sethi %hi(LC53),%o0
	ld [%fp-20],%o1
	ldub [%o1],%o2
	or %o0,%lo(LC53),%o0
	ld [%l2+%lo(_errnum)],%o3
	call _printf,0
	sub %o1,%i3,%o1
L711:
	ld [%fp-20],%o4
	ldub [%o4],%o0
	cmp %o0,131
	be,a L723
	add %o4,1,%o0
	bg L733
	cmp %o0,148
	cmp %o0,10
	be,a L714
	add %o4,1,%o0
	bg L734
	cmp %o0,58
	cmp %o0,0
	be L741
	mov -1,%o0
	b,a L731
L734:
	be L716
	cmp %o0,128
	be L718
	add %o4,1,%o0
	b,a L731
L733:
	be L729
	cmp %o0,148
	bg L735
	cmp %o0,149
	cmp %o0,136
	be L717
	cmp %o0,137
	be L730
	add %o4,1,%o0
	b,a L731
L735:
	be L726
	cmp %o0,150
	be L742
	ld [%l0+%lo(_stack_pnt)],%o0
	b,a L731
L714:
	st %o0,[%fp-20]
	ldub [%o4+1],%o0
	cmp %o0,0
	bne L715
	add %o4,5,%o0
	mov -1,%o0
L741:
	b L712
	st %o0,[%l2+%lo(_errnum)]
L715:
	b L712
	st %o0,[%fp-20]
L716:
	add %o4,1,%o0
	b L712
	st %o0,[%fp-20]
L717:
	add %o4,1,%o0
	st %o0,[%fp-20]
	call _print,0
	add %fp,-20,%o0
	b L743
	cmp %l1,0
L718:
	st %o0,[%fp-20]
	call _assign,0
	mov %l3,%o0
	ld [%fp-20],%o1
	add %o1,1,%o0
	st %o0,[%fp-20]
	ldub [%o1],%o0
	cmp %o0,129
	be L719
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC54),%o1
	call _printf,0
	or %o1,%lo(LC54),%o1
	mov 3,%o0
	st %o0,[%l2+%lo(_errnum)]
L719:
	call _int_expr,0
	mov %l3,%o0
	ld [%l0+%lo(_stack_pnt)],%o1
	ld [%fp-20],%o2
	sll %o1,3,%o1
	st %o0,[%o1+%l5]
	ldub [%o2],%o0
	cmp %o0,130
	bne,a L739
	mov 1,%o0
	add %o2,1,%o0
	st %o0,[%fp-20]
	call _int_expr,0
	mov %l3,%o0
	ld [%l0+%lo(_stack_pnt)],%o1
	sll %o1,3,%o1
L739:
	st %o0,[%o1+%i0]
	ld [%l0+%lo(_stack_pnt)],%o0
	ld [%fp-20],%o2
	sll %o0,2,%o1
	st %o2,[%o1+%l4]
	add %o0,1,%o0
	b L712
	st %o0,[%l0+%lo(_stack_pnt)]
L723:
	st %o0,[%fp-20]
	ldub [%o4+1],%o1
	ld [%l0+%lo(_stack_pnt)],%o5
	add %o1,-65,%o1
	sll %o1,2,%o1
	ld [%o1+%l7],%o2
	sll %o5,3,%o3
	ld [%o3+%i1],%o0
	add %o2,%o0,%o2
	st %o2,[%o1+%l7]
	ld [%o3+%i2],%o0
	cmp %o2,%o0
	bg L724
	add %o5,-1,%o0
	sll %o5,2,%o0
	ld [%o0+%l6],%o0
	b L709
	st %o0,[%fp-20]
L724:
	st %o0,[%l0+%lo(_stack_pnt)]
	add %o4,2,%o0
	b L712
	st %o0,[%fp-20]
L726:
	add %o4,1,%o3
	st %o3,[%fp-20]
	ld [%l0+%lo(_stack_pnt)],%o2
	add %fp,-20,%o0
	add %o2,1,%o1
	st %o1,[%l0+%lo(_stack_pnt)]
	sll %o2,2,%o2
	call _int_expr,0
	st %o3,[%o2+%l4]
	cmp %o0,0
	bne L743
	cmp %l1,0
	ld [%l0+%lo(_stack_pnt)],%o0
L742:
	sll %o0,2,%o0
	b L712
	ld [%o0+%l6],%l1
L729:
	add %o4,1,%o0
	st %o0,[%fp-20]
	call _dim_string,0
	add %fp,-20,%o0
	b L743
	cmp %l1,0
L730:
	st %o0,[%fp-20]
L731:
	call _assign,0
	add %fp,-20,%o0
L712:
	cmp %l1,0
L743:
	be L744
	ld [%l2+%lo(_errnum)],%o0
	st %l1,[%fp-20]
	mov 0,%l1
L709:
	ld [%l2+%lo(_errnum)],%o0
L744:
	cmp %o0,0
	be L745
	sethi %hi(_DEBUG),%o0
L710:
	ret
	restore
	.align 8
LC55:
	.ascii "missing =\0"
	.align 4
	.global _assign
	.proc	04
_assign:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	ld [%i0],%o1
	ldub [%o1],%l0
	cmp %l0,96
	ble L752
	add %o1,1,%o0
	call _string_assign,0
	mov %i0,%o0
	b,a L753
L752:
	st %o0,[%i0]
	ldub [%o1+1],%o0
	cmp %o0,161
	be L754
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC55),%o1
	call _printf,0
	or %o1,%lo(LC55),%o1
	mov 3,%o0
	sethi %hi(_errnum),%o1
	st %o0,[%o1+%lo(_errnum)]
L754:
	ld [%i0],%o1
	mov %i0,%o0
	add %o1,1,%o1
	call _int_expr,0
	st %o1,[%o0]
	sethi %hi(_vars-260),%o1
	or %o1,%lo(_vars-260),%o1
	sll %l0,2,%o2
	st %o0,[%o2+%o1]
L753:
	ret
	restore
	.align 8
LC56:
	.ascii "Not defined var\0"
	.align 8
LC57:
	.ascii "%s\0"
	.align 8
LC58:
	.ascii "%d\0"
	.align 8
LC59:
	.ascii "%c\0"
	.align 8
LC60:
	.ascii "After expr prg is %04x\12\0"
	.align 4
	.global _print
	.proc	04
_print:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	sethi %hi(_stringadr-388),%o0
	or %o0,%lo(_stringadr-388),%l3
	sethi %hi(_errnum),%l4
	sethi %hi(_stringvar),%l2
	sethi %hi(LC59),%l1
L757:
	ld [%i0],%o1
L773:
	ldub [%o1],%l0
	add %l0,-97,%o0
	cmp %o0,25
	bgu L759
	add %o1,1,%o0
	st %o0,[%i0]
	sll %l0,2,%o0
	ld [%o0+%l3],%o1
	cmp %o1,-1
	bne L760
	sethi %hi(LC57),%o0
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC56),%o1
	call _printf,0
	or %o1,%lo(LC56),%o1
	mov 3,%o0
	st %o0,[%l4+%lo(_errnum)]
	b L756
	mov 0,%i0
L760:
	or %o0,%lo(LC57),%o0
	ld [%l2+%lo(_stringvar)],%o2
	add %o1,4,%o1
	call _printf,0
	add %o1,%o2,%o1
	b L773
	ld [%i0],%o1
L759:
	cmp %l0,50
	be L763
	cmp %l0,52
	be L763
	add %l0,-65,%o0
	cmp %o0,25
	bgu L762
	cmp %l0,168
L763:
	call _int_expr,0
	mov %i0,%o0
	mov %o0,%l0
	sethi %hi(LC58),%o0
	or %o0,%lo(LC58),%o0
	call _printf,0
	mov %l0,%o1
	b L773
	ld [%i0],%o1
L762:
	bne L764
	cmp %l0,34
	add %o1,1,%o0
	b L757
	st %o0,[%i0]
L764:
	be L772
	cmp %l0,39
	bne,a L758
	ld [%i0],%o0
	b L774
	add %o1,1,%o0
L769:
	ldub [%o0],%o1
	call _printf,0
	or %l1,%lo(LC59),%o0
	ld [%i0],%o1
L772:
	add %o1,1,%o0
L774:
	st %o0,[%i0]
	ldub [%o1+1],%o0
	cmp %o0,%l0
	bne,a L769
	ld [%i0],%o0
	ld [%i0],%o0
	add %o0,1,%o0
	b L757
	st %o0,[%i0]
L758:
	ldub [%o0-1],%o0
	cmp %o0,168
	be L770
	sethi %hi(LC29),%o0
	call _printf,0
	or %o0,%lo(LC29),%o0
L770:
	sethi %hi(_DEBUG),%o0
	ld [%o0+%lo(_DEBUG)],%o0
	cmp %o0,0
	be L756
	sethi %hi(LC60),%o0
	or %o0,%lo(LC60),%o0
	sethi %hi(_mem),%o1
	ld [%i0],%o2
	or %o1,%lo(_mem),%o1
	call _printf,0
	sub %o2,%o1,%o1
L756:
	ret
	restore
	.align 8
LC61:
	.ascii "Dim non string var\0"
	.align 4
	.global _dim_string
	.proc	04
_dim_string:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	ld [%i0],%o1
	ldub [%o1],%o0
	add %o0,-97,%o2
	cmp %o2,30
	bgu L782
	sethi %hi(_stringadr),%o0
	or %o0,%lo(_stringadr),%l1
	sll %o2,2,%l0
	ld [%l0+%l1],%o0
	cmp %o0,-1
	be L778
	add %o1,1,%o0
L782:
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC61),%o1
	call _printf,0
	or %o1,%lo(LC61),%o1
	mov 3,%o0
	sethi %hi(_errnum),%o1
	st %o0,[%o1+%lo(_errnum)]
	b L775
	mov 0,%i0
L778:
	st %o0,[%i0]
	ldub [%o1+1],%o0
	cmp %o0,161
	be L780
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC55),%o1
	call _printf,0
	or %o1,%lo(LC55),%o1
	mov 3,%o0
	sethi %hi(_errnum),%o1
	st %o0,[%o1+%lo(_errnum)]
L780:
	ld [%i0],%o1
	mov %i0,%o0
	add %o1,1,%o1
	call _int_expr,0
	st %o1,[%o0]
	sethi %hi(_strings_used),%o4
	add %o0,4,%o0
	sethi %hi(_stringvar),%o3
	ld [%o4+%lo(_strings_used)],%o5
	sra %o0,8,%o1
	ld [%o3+%lo(_stringvar)],%o2
	st %o5,[%l0+%l1]
	stb %o1,[%o2+%o5]
	ld [%o4+%lo(_strings_used)],%o1
	ld [%o3+%lo(_stringvar)],%o2
	add %o1,%o2,%o1
	stb %o0,[%o1+1]
	ld [%o4+%lo(_strings_used)],%o1
	ld [%o3+%lo(_stringvar)],%o2
	add %o1,%o2,%o1
	stb %g0,[%o1+2]
	ld [%o4+%lo(_strings_used)],%o1
	ld [%o3+%lo(_stringvar)],%o2
	add %o1,%o2,%o1
	stb %g0,[%o1+3]
	ld [%o4+%lo(_strings_used)],%o1
	add %o0,%o1,%o0
	st %o0,[%o4+%lo(_strings_used)]
L775:
	ret
	restore
	.align 8
LC62:
	.ascii "Not a string\0"
	.align 8
LC63:
	.ascii "Var needs dim\0"
	.align 8
LC64:
	.ascii "String requires dim\0"
	.align 8
LC65:
	.ascii "Assign var %c length %d\12\0"
	.align 8
LC66:
	.ascii "Too long string assign\0"
	.align 4
	.global _string_assign
	.proc	04
_string_assign:
	!#PROLOGUE# 0
	save %sp,-112,%sp
	!#PROLOGUE# 1
	ld [%i0],%o3
	ldub [%o3],%o0
	add %o0,-97,%o1
	cmp %o1,30
	bleu L784
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC62),%o1
	call _printf,0
	or %o1,%lo(LC62),%o1
	b L816
	mov 3,%o0
L784:
	sethi %hi(_stringadr),%o0
	or %o0,%lo(_stringadr),%o4
	sll %o1,2,%o0
	ld [%o0+%o4],%o1
	cmp %o1,-1
	bne L786
	sethi %hi(_stringvar),%o0
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC63),%o1
	call _printf,0
	or %o1,%lo(LC63),%o1
	b L816
	mov 3,%o0
L786:
	ld [%o0+%lo(_stringvar)],%o0
	add %o0,%o1,%l3
	ldub [%l3],%o1
	ldub [%l3+1],%o2
	add %o3,1,%o0
	st %o0,[%i0]
	ldub [%o3+1],%o0
	cmp %o0,161
	sll %o1,8,%o1
	be L788
	add %o1,%o2,%l4
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC55),%o1
	call _printf,0
	or %o1,%lo(LC55),%o1
	b L816
	mov 3,%o0
L811:
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC64),%o1
	call _printf,0
	or %o1,%lo(LC64),%o1
	mov 3,%o0
L816:
	sethi %hi(_errnum),%o1
	st %o0,[%o1+%lo(_errnum)]
	b L783
	mov 0,%i0
L812:
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC66),%o1
	call _printf,0
	or %o1,%lo(LC66),%o1
	mov 3,%o0
	sethi %hi(_errnum),%o1
	b L791
	st %o0,[%o1+%lo(_errnum)]
L788:
	add %o3,2,%o0
	st %o0,[%i0]
	mov 0,%l1
	add %o4,-388,%l6
	sethi %hi(_errnum),%l5
L790:
	ld [%i0],%o1
L817:
	ldub [%o1],%o3
	cmp %o3,168
	be L793
	add %o1,1,%o0
	cmp %o3,164
	bne,a L792
	add %o3,-97,%o0
L793:
	b L790
	st %o0,[%i0]
L792:
	cmp %o0,25
	bgu L794
	add %o1,1,%o0
	st %o0,[%i0]
	sll %o3,2,%o0
	ld [%o0+%l6],%o4
	cmp %o4,-1
	be L811
	sethi %hi(_stringvar),%o0
	ld [%o0+%lo(_stringvar)],%o1
	sethi %hi(_DEBUG),%o0
	ld [%o0+%lo(_DEBUG)],%o2
	add %o4,%o1,%l2
	ldub [%l2+2],%o0
	cmp %o2,0
	ldub [%l2+3],%o1
	sll %o0,8,%o0
	be L797
	add %o0,%o1,%l0
	sethi %hi(LC65),%o0
	or %o0,%lo(LC65),%o0
	mov %o3,%o1
	call _printf,0
	mov %l0,%o2
L797:
	add %l0,%l1,%o0
	cmp %o0,%l4
	bg L812
	mov 0,%o2
	cmp %o2,%l0
	bge,a L817
	ld [%i0],%o1
L803:
	add %l1,%l3,%o0
	add %l1,1,%l1
	add %o2,%l2,%o1
	add %o2,1,%o2
	ldub [%o1+4],%o1
	cmp %o2,%l0
	bl L803
	stb %o1,[%o0+4]
	b L817
	ld [%i0],%o1
L813:
	sethi %hi(LC23),%o0
	or %o0,%lo(LC23),%o0
	sethi %hi(LC66),%o1
	call _printf,0
	or %o1,%lo(LC66),%o1
	mov 3,%o0
	b L807
	st %o0,[%l5+%lo(_errnum)]
L794:
	cmp %o3,34
	be L805
	cmp %o3,39
	bne,a L818
	add %l1,%l3,%o0
L805:
	b L815
	st %o0,[%i0]
L810:
	add %l1,%l3,%o1
	ldub [%o0],%o0
	add %l1,1,%l1
	stb %o0,[%o1+4]
	ld [%i0],%o1
	cmp %l1,%l4
	add %o1,1,%o0
	bge L813
	st %o0,[%i0]
L815:
	ldub [%o1+1],%o1
	cmp %o1,%o3
	bne,a L810
	ld [%i0],%o0
L807:
	ld [%i0],%o0
	add %o0,1,%o0
	b L790
	st %o0,[%i0]
L791:
	add %l1,%l3,%o0
L818:
	stb %g0,[%o0+4]
	sra %l1,8,%o0
	stb %o0,[%l3+2]
	stb %l1,[%l3+3]
L783:
	ret
	restore
	.global _inbuf
	.common _inbuf,80,"bss"
	.global _pos
	.common _pos,8,"bss"
	.global _addr
	.common _addr,8,"bss"
	.global _mem
	.common _mem,16384,"bss"
	.global _vars
	.common _vars,120,"bss"
	.global _strings_used
	.common _strings_used,8,"bss"
	.global _stringadr
	.common _stringadr,120,"bss"
	.global _errnum
	.common _errnum,8,"bss"
	.global _stack
	.common _stack,40,"bss"
	.global _data_stack
	.common _data_stack,80,"bss"
	.global _stack_pnt
	.common _stack_pnt,8,"bss"
	.global _fil
	.common _fil,8,"bss"
