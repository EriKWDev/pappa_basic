
#define CR 10
#define MAXSIZE 0xF000

/* extern byte mem[]; */
extern byte accu[5],page,aslask,atyp,opcode,ityp,reg,areg;
extern unint16 dispc,pc;
extern byte src,dst,leareg,bryt,autostop;
extern byte inbuf[];
extern int mode_i;
extern int16 pos;
extern byte instadrm[], instruc[];
extern int mode_s,mode_r,mode_i,mode_p,mode_g,addr,break_pc, mode_sim;
extern int break_g,mode_q,break_qpc;

extern byte mem[];


