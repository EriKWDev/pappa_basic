/*
 * MG monitor. Copyright Martin Gren 890918, based on first release in
 * 1981.
 *
 * Last update: 900415 as monitor
 * Jan 5, 1996: Recreated and modified to be a basic interface.
 *
 * This monitor may be extended to support other commands etc.
 *
 */

#include <stdio.h>
#include "typedef.h"
#include "mgmon.h"
#include "commands.h"
#include "basic.h"

#define maxtkn 80

byte mem[0x4000]; /* This is really only for mgmon. */

/*
 *
 * All procedures are stored here for c purpose
 *
 */

extern do_hd();
extern do_info();
extern do_prog();
extern do_move();
extern do_exit();
extern do_verf();
extern do_check();
extern do_fill();
extern do_find();
extern do_modify();
extern do_load();
extern do_save();
extern do_run();
extern do_reg();
extern do_set();
extern do_mode();
extern do_help();
extern do_reset();
extern do_comp();
extern do_list();

struct comtype
{
  char *name;
  int (*execute)();
};

#define MAXCOMMAND 20
struct comtype commands[MAXCOMMAND] =
    {
        {"hd", do_hd}, {"info", do_info}, {"program", do_prog}, {"move", do_move}, {"exit", do_exit}, {"fill", do_fill}, {"verify", do_verf}, {"check", do_check}, {"find", do_find}, {"modify", do_modify}, {"load", do_load}, {"save", do_save}, {"reg", do_reg}, {"set", do_set}, {"run", do_run}, {"mode", do_mode}, {"list", do_list}, {"help", do_help}, {"reset", do_reset}, {"comp", do_comp}};

int16 pos;
FILE *fil;

main()
{
  /*
   *
   * The system calls are to make it character oriented on a Unix system.
   * If you port it into a target system, they shall be excluded.
   * Cut the lines together for Unix compatibility.
   *
   */

  system("stty cbreak -echo tandem");
  shell();
  prtmsg("\nMG-monitor exited.\n");
  system("stty -cbreak echo -tandem");
  exit(0);
}

/* ---------------------------------------------------------- */

/*
 * Error handling
 */
error(msg) char *msg;
{
  printf("Error: %s\n", msg);
  errnum = 3;
}

shell()
{
  int funktion, i;

  funktion = 7;
  prtmsg("\nMG Basic/monitor\n4.0 Jan 8, 1996\n\nType help if in doubt!\n");
  do
  {
    if (funktion != 0)
      prtmsg("\nMgmon\n");
    buffer();
    i = ignblk_pos();
    if ((i >= '0') && (i <= '9'))
    {
      do_comp();
      continue;
    }
    lower();
    funktion = sekcom();
    if (funktion == -1)
      prtmsg("Undefined command, try help!\n");
    if ((funktion > 0) && (funktion <= MAXCOMMAND))
    {
      (*(commands[funktion - 1].execute))();
    }
  } while (funktion != 5);
}

/*
 *
 * All memory read and write should use the following routines.
 * This is to allow for units where memory is not strightforward
 *
 * plesae use these routines rather than reading directly in the mem
 * variable.
 *
 * This is not maintained by the 6809 simulator due to performance
 * degradation.
 *
 */

char memr(adr)

int32 adr;

{
  return (mem[adr]);
}

memw(adr, data)

    int32 adr;
int data;

{
  mem[adr] = data;
}

prtchr(ch)

    char ch;
{
  putc(ch, stdout);
}

char getchr()
{
  return (getchar());
}

prtmsg(string)

    char *string;

{
  int i;

  for (i = 0; string[i] != 0;)
  {
    if (string[i++] == '\n')
      prtchr('\n');
    else
      prtchr(string[i - 1]);
  }
}

/*
 *
 * Input buffering routine. Rather strange, but compatible
 * with the 6809 assembly format.
 *
 */

buffer()

{

  char ch;
  int bryt;

  bryt = pos = 0;
  do
  {
    ch = getchr();
    if (ch == 8)
      if (pos > 0)
      {
        pos--;
        prtchr(8);
        prtchr(32);
        prtchr(8);
      }
    if (ch > 31)
      if (pos < maxtkn)
      {
        prtchr(ch);
        inbuf[pos++] = ch;
      }
    if (pos == 1)
      if ((ch == '+') || (ch == '-'))
        bryt = 1;
  } while ((ch != CR) && (bryt == 0));
  inbuf[pos++] = ch;
  inbuf[pos] = ch;
  prtchr('\n');
  prtchr(13);
  pos = 0;
}

/*
 *
 * Get one memory addr.
 *
 */

int32 getadr()

{

  int32 adr, i;

  ignblk_pos();
  adr = i = 0;
  while ((i = gethex()) != -1)
  {
    adr = adr * 16 + i;
  }
  return (adr);
}

int getbyt()

{

  int byt, i;

  ignblk_pos();
  byt = i = 0;
  byt = gethex();
  i = gethex();
  if ((i < 0) || (byt < 0))
    byt = -1;
  else
    byt = byt * 16 + i;
  return (byt);
}

int gethex()

{

  int i;

  i = nxtch();
  if (i > 96)
    i -= 32;
  i -= 48;
  if (i > 9)
    i -= 7;
  if (i > 15)
    i = -1;
  if (i < 0)
    i = -1;
  return (i);
}

int nxtch()

{
  int i;
  i = inbuf[pos];
  if (i != CR)
    pos++;
  return (i);
}

prtadr(adr)

    int32 adr;

{
  if ((adr >= 0x10000) || (adr < 0))
  {
    prthex((adr >> 24) & 0xff);
    prthex((adr >> 16) & 0xff);
    adr = adr & 0xffff;
  }
  prthex(adr >> 8);
  prthex(adr & 0xff);
}

prthex(hex)

    byte hex;

{
  prtnib((hex >> 4) & 0x0F);
  prtnib(hex & 15);
}

prtnib(nib)

    byte nib;

{
  if (nib > 9)
    nib += 7;
  prtchr(nib + '0');
}

lower()

{
  int i;

  for (i = 0; i < maxtkn; i++)
    if (inbuf[i] > 64)
      if (inbuf[i] < 96)
        inbuf[i] += 32;
}

/*
 *
 * Ignore blanks.
 *
 */

int ignblk_pos()

{
  while (inbuf[pos] == 32)
    pos++;
  return (inbuf[pos]);
}

/*
 *
 * Search for command in an array.
 * Then execurte it. It works together with the struct in the beginning of
 * of this program.
 *
 */

int sekcom()

{

  int16 i, j, miss, found;

  pos = 0;
  i = 0;
  found = 0;
  if (ignblk_pos() != CR)
  {
    while ((found == 0) && (i < MAXCOMMAND))
    {
      j = 0;
      do
      {
        miss = 0;
        if (inbuf[pos + j] == '.')
        {
          found = 1;
          j++;
        }
        if (commands[i].name[j] == 0)
          found = 1;
        if (commands[i].name[j] == inbuf[pos + j])
          j++;
        else
          miss = 1;
      } while (miss + found == 0);
      i++;
    }
    if (found == 0)
      i = -1;
    else
      pos += j;
  }
  return (i);
}

/*
 *
 * Command to list memory.
 *
 */

do_hd()

{

  int32 x, limit, width;
  int i;
  char ch;

  x = getadr();
  limit = getadr();
  width = getadr();
  if ((width == 0) || (width > 32))
    width = 8;

  while (1)
  {
    prtadr(x);
    prtmsg("  ");
    for (i = 0; i < width; i++)
    {
      prthex(memr(x + i));
      prtchr(32);
    }
    prtchr(32);
    prtchr(32);
    for (i = 0; i < width; i++)
    {
      ch = memr(x++);
      ch = ch & 0x7F;
      if (ch < 32)
        ch = 46;
      prtchr(ch);
    }
    prtchr(10);
    prtchr(13);
    if (limit == 0)
    {
      if (getchr() == CR)
        break;
    }
    else
    {
      if (x > limit)
        break;
    }
  }
}

/*
 *
 * List all available commands.
 *
 */

do_info()

{
  int i, j, ch;

  for (i = 0; i < MAXCOMMAND; i++)
  {
    j = 0;
    do
    {
      ch = commands[i].name[j++];
      prtchr(ch);
    } while (ch != 0);
    prtchr(10);
    prtchr(13);
  }
}

/*
 *
 * command to modify memory.
 *
 * Subcommands are:
 *
 * + - increase memory location with one without modifying current.
 * - - decrease memory location with one without modifying current.
 * <CR> read the same byte once again.
 * . - will break programming.
 * j - will calcualte data as offset for short branch
 * " - (open, only first appearance is significant) is used to enter ASCII
 *     data
 *
 */

do_prog()

{
  int32 x;
  char ch;
  int i, bryt;

  x = getadr();
  bryt = 0;
  while (bryt == 0)
  {
    prtadr(x);
    prtchr(32);
    prthex(memr(x));
    prtchr(32);
    buffer();
    ch = inbuf[0];
    switch (ch)
    {
    case '+':
      x++;
      break;
    case '-':
      x--;
      break;
    case 'J':
    case 'j':
      memw(x, (getbyt() - x + 2) & 0xff);
      break;
    case '"':
      for (i = 1; inbuf[i] != CR;)
        memw(x++, inbuf[i++]);
      break;
    case CR:
      break;
    case 46:
      bryt = 1;
      break;
    default:
      while ((i = getbyt()) != -1)
        memw(x++, i);
      break;
    }
  }
}

/*
 *
 * Move (copy) memory command. Syntax move <start> <end> <to>
 *
 */

do_move()

{

  int32 start, stop, till;

  start = getadr();
  stop = getadr();
  till = getadr();

  while (start != stop)
    memw(till++, memr(start++));
}

do_exit()

{
}

/*
 *
 * Fill memory with a one byte pattern. fill <start> <stop+1> <byte>
 *
 */

do_fill()

{

  int32 start, stop;
  byte data;

  start = getadr();
  stop = getadr();
  data = getbyt();
  while (start != stop)
    memw(start++, data);
}

/*
 *
 * Calculate checksum of memory
 *
 */

do_check()

{

  int32 start, stop;
  int16 sum;

  start = getadr();
  stop = getadr();
  sum = 0;
  while (start < stop)
    sum += memr(start++);
  prtmsg("Checksum ");
  prtadr(sum);
  prtmsg("\n");
}

/*
 *
 * Verify 2 areas of memory. Syntax as in move command.
 *
 */

do_verf()

{

  int32 start, stop, mot;

  start = getadr();
  stop = getadr();
  mot = getadr();
  while (start < stop)
  {
    if (memr(start) != memr(mot))
    {
      prtmsg("Error at ");
      prtadr(start);
      prtchr(32);
      prthex(memr(start));
      prtchr(32);
      prthex(memr(mot));
      prtmsg("\n");
      if (getchr() == CR)
        break;
    }
    start++;
    mot++;
  }
}

/*
 *
 * Command to locate a specific string in memory.
 *
 * The string to search for is stored at a certain memory address,
 * with a one byte count byte at first.
 * to search for the data one specifies:
 *
 * find <matching string in memory with countbyte> <start search address>
 *
 */

do_find()

{
  int32 pattern, leta, i, lengd;

  pattern = getadr();
  leta = getadr();
  lengd = memr(pattern++);
  do
  {
    i = 0;
    while ((memr(pattern + i) == memr(leta + i)) & (i < lengd))
      i++;
    if (i >= lengd)
    {
      prtadr(leta);
      leta++;
      prtchr(10);
      prtchr(13);
      if ((i = getchr()) == CR)
        leta = 0;
    }
    else
      leta++;
  } while (leta != 0);
}

/*
 *
 * Read and store one byte at a given adress.
 *
 */

do_modify()

{
  int adr, data;

  adr = getadr();
  data = getbyt();
  memw(adr, data);
}

/*
 *
 * Print register contents (used for the simulator)
 *
 */

do_reg()
{
}

do_set()

{
}

do_mode()

{
}

/*
 *
 * Load a file into memory.
 *
 */

do_load()

{

  int32 ch, adr;

  adr = getadr();
  ignblk_pos();
  scancr();
  fil = fopen(&inbuf[pos], "rb");
  if (fil == NULL)
    prtmsg("The file does not exist\n");
  else
  {
    while ((ch = fgetc(fil)) != EOF)
      memw(adr++, ch);
    prtmsg("End address : ");
    prtadr(adr);
    prtmsg("\n");
  }
}

/*
 *
 * Save a file from memory.
 *
 */

do_save()

{

  int32 start, stop;

  start = getadr();
  stop = getadr();
  if (ignblk_pos() == CR)
    prtmsg("Syntax error");
  else
  {
    scancr();
    fil = fopen(&inbuf[pos], "wb");
    while (start != stop)
      fputc(memr(start++), fil);
    fclose(fil);
  }
}

scancr()

{
  int i;
  for (i = 0; i < maxtkn; i++)
    if (inbuf[i] == CR)
      inbuf[i] = 0;
}

do_reset()
{
}

do_help()

{
  printf("Type info to see a list of all available commands. \n\n");
  printf("All commands may be abbrevated by . E g program 2000 is eqv. p.2000\n");
  printf("All end addresses should be one extra.\n");
  printf("    Save 8000 0 AX7 saves file AX7 from 8000 to FFFF\n");
  printf("Load <address> filename will load file to RAM\n");
  printf("All commands with addresses have syntax start, end, to\n");
  printf("Use dis command to dissassemble 6809 instructions\n");
  printf("When using set command, use only one character for register\n");
  printf("    E g 'set p e650' for setting pc to e650. set pc e650 => pc=000C\n");
  printf("When simulating 6809, use run. Dont't forget to set registers\n");
  printf(" especially PC (check with 'reg'\n");
  printf("Reset command will reset registers as 6809 (PC=[FFFE])\n");
  printf("Known bugs: V-flag not working, DAA instruction not implemented\n");
  printf("Use ass command to get one line assembler. Note: use $ for hex!\n");

  printf("\nGood luck !\n");
}

byte *stringvar = mem + 0x1000; /* This is for the string variables */
int strings_used;               /* Number of bytes actually used for strings */
int vars[MAXVAR];               /* a-z variables */
int stringadr[MAXVAR];
int errnum; /* Set at error routine */

byte *stack[MAXSTACK];
int data_stack[MAXSTACK * 2];
int stack_pnt;
byte inbuf[80];

int addr;
int DEBUG = (1 == 2);

do_comp()

{
  byte *outbuf;
  byte *progmem;
  byte *buffer;
  int i;

  ignblk_pos();

  buffer = mem + 0x1000;
  progmem = mem;
  i = compline(inbuf + pos, buffer);
  basicins(progmem, buffer);
}

do_list()

{
  int x;
  char prtbuf[150];

  x = getadr();
  do
  {
    list_line(prtbuf, mem + x);
    printf("%s\n", prtbuf);
    x += *(mem + x);
  } while (*(mem + x) > 0);
}
/*
 * Clear all variables for basic run
 */
basic_new()
{
  int i;

  for (i = 0; i < MAXVAR; i++)
  {
    vars[i] = 0; /* a-z variables */
    stringadr[i] = -1;
    strings_used = 0;
  }
  for (i = 0; i < MAXSTACK; i++)
    stack[i] = 0;
}

/*
 * Execute basic program
 */
do_run()
{
  byte *prg;
  byte *next;
  byte *jump;
  int len;
  int i, j, var, tmp;

  basic_new();
  jump = NULL;
  errnum = 0;
  prg = mem;
  stack_pnt = 0;
  if (*prg == 0)
    error("Empty program");
  prg += 4;
  while (errnum == 0)
  {
    if (DEBUG)
      printf("Exec adr %04x token %02x err %dx\n", prg - mem, *prg, errnum);
    switch (*prg)
    {
    case 0:
      errnum = -1;
      break;
    case 10:
      prg++;
      if (*prg == 0)
      {
        errnum = -1;
        break;
      }
      next = prg + (*prg);
      prg += 4; /* Ignore length and line number */
      break;
    case ':':
      prg++;
      break;
    case PRINT:
      prg++;
      print(&prg);
      break;
    case FOR:
      prg++;
      assign(&prg);
      if (*prg++ != TO)
        error("for without to");
      i = int_expr(&prg);
      data_stack[stack_pnt * 2] = i;
      if (*prg == STEP)
      {
        prg++;
        data_stack[(stack_pnt * 2) + 1] = int_expr(&prg);
      }
      else
        data_stack[(stack_pnt * 2) + 1] = 1;
      stack[stack_pnt] = prg;
      stack_pnt++;
      break;
    case NEXT:
      prg++;
      var = *prg - 'A';
      vars[var] += data_stack[(stack_pnt * 2) - 1];
      if (vars[var] <= data_stack[(stack_pnt * 2) - 2])
      {
        prg = stack[stack_pnt - 1];
        continue;
      }
      else
      {
        stack_pnt--;
        prg++;
      }
      break;
    case WHILE:
      prg++;
      stack[stack_pnt++] = prg;
      if (int_expr(&prg))
        break;
    case WEND:
      jump = stack[stack_pnt - 1];
      break;
    case DIM:
      prg++;
      dim_string(&prg);
      break;
    case LET:
      prg++;
      assign(&prg);
      break;
    default:
      assign(&prg);
      break;
    }
    if (jump != NULL)
    {
      prg = jump;
      jump = NULL;
    }
  }
}

/*
 * Handle implicit let assignment of numerical variable
 */
assign(prg)

    byte **prg;
{
  int var;

  var = **prg;
  if (var >= 'a')
    string_assign(prg);
  else
  {
    (*prg)++;
    if (**prg != EQ)
      error("missing =");
    (*prg)++;
    vars[var - 'A'] = int_expr(prg);
  }
}

/*
 * Basic print statement.
 */

print(prg)

    byte **prg;
{
  int token, i;

  while (1 == 1)
  {
    token = **prg;
    /* Print string */
    if ((token >= 'a') && (token <= 'z'))
    {
      (*prg)++;
      i = stringadr[token - 'a'];
      if (i == -1)
      {
        error("Not defined var");
        return (0);
      }
      printf("%s", stringvar + 4 + i);
      continue;
    }
    /* Print expression */
    if ((token == '2') || (token == '4') || ((token >= 'A') && (token <= 'Z')))
    {
      token = int_expr(prg);
      printf("%d", token);
      continue;
    }
    if (token == SEMICOLON)
    {
      (*prg)++;
      continue;
    }
    /* Print string */
    if ((token == '"') || (token == '\''))
    {
      (*prg)++;
      while (**prg != token)
      {
        printf("%c", **prg);
        (*prg)++;
      }
      (*prg)++;
      continue;
    }
    break;
  }
  if ((*(*prg - 1)) != SEMICOLON)
    printf("\n");
  if (DEBUG)
    printf("After expr prg is %04x\n", *prg - mem);
}
/*
 * Dim string variable
 */
dim_string(pnt)

    byte **pnt;
{
  byte *tmp;
  int var, size;

  var = **pnt - 'a';
  if ((var > MAXVAR) || (var < 0))
  {
    error("Dim non string var");
    return (0);
  }
  if (stringadr[var] != -1)
  {
    error("Dim non string var");
    return (0);
  }
  (*pnt)++;
  if (**pnt != EQ)
    error("missing =");
  (*pnt)++;
  /*
   * Now: Store the adress of the particular string in stringadr
   * The first 2 bytes contain the max length, make sure these are zero!
   * The following 2 bytes contain the length, make sure these are zero!
   * Then update max e t c.
   */
  size = int_expr(pnt) + 4;
  stringadr[var] = strings_used;
  stringvar[strings_used] = size >> 8;
  stringvar[strings_used + 1] = size & 0xff;
  stringvar[strings_used + 2] = 0;
  stringvar[strings_used + 3] = 0;
  strings_used += size;
}
/*
 * Handle implicit let assignment of string variable
 */
string_assign(prg)

    byte **prg;
{
  int var, asnvar, delim, len, asnlen, maxlen, i;
  byte *invar, *asnstr;

  var = **prg - 'a';
  if ((var > MAXVAR) || (var < 0))
  {
    error("Not a string");
    return (0);
  }
  if (stringadr[var] == -1)
  {
    error("Var needs dim");
    return (0);
  }
  invar = stringvar + stringadr[var];
  maxlen = invar[0] * 0x100 + invar[1];
  (*prg)++;

  if (**prg != EQ)
  {
    error("missing =");
    return (0);
  }
  (*prg)++;
  len = 0;
  /*
   * Now do the actual string expression
   */
  while (1 == 1)
  {
    delim = **prg;
    if ((delim == SEMICOLON) || (delim == PLUS))
    {
      (*prg)++;
      continue;
    }
    /* Handle string variable concatenate */
    if ((delim <= 'z') && (delim >= 'a'))
    {
      (*prg)++;
      asnvar = stringadr[delim - 'a'];
      if (asnvar == -1)
      {
        error("String requires dim");
        return (0);
      }
      asnstr = stringvar + asnvar;
      asnlen = (asnstr[2] << 8) + asnstr[3];
      if (DEBUG)
        printf("Assign var %c length %d\n", delim, asnlen);
      if (asnlen + len > maxlen)
      {
        error("Too long string assign");
        break;
      }
      for (i = 0; i < asnlen; i++)
      {
        invar[len + 4] = asnstr[i + 4];
        len++;
      }
      continue;
    }
    if ((delim == '"') || (delim == '\''))
    {
      (*prg)++;
      while ((var = **prg) != delim)
      {
        invar[len + 4] = **prg;
        len++;
        (*prg)++;
        if (len >= maxlen)
        {
          error("Too long string assign");
          break;
        }
      }
      (*prg)++;
      continue;
    }
    break;
  }
  invar[len + 4] = 0;
  invar[2] = len >> 8;
  invar[3] = len & 0xff;
}
