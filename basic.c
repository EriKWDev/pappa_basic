/*
 * This is the BASIC runtime package. It contains the commands decoded
 * by the MGMON from which it is ran.
 *
 * Main module is the run execution. More info in the html file, see the
 * web.
 *
 * Jan 5, 1996: Recreated and modified to be a basic interface.
 * Jan 15, 1996: Split into runtime file.
 */

#include <stdio.h>
#include "typedef.h"
#include "mgmon.h"
#include "commands.h"
#include "basic.h"

/*
 * Basic runtime variables
 */

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
int DEBUG = (2 == 1);

/*
 * Error handling
 */
error(msg) char *msg;
{
  prtmsg("Error: ");
  prtmsg(msg);
  prtmsg("\n");
  errnum = 3;
}

/*
 * Compile one line:
 */

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

/*
 * Execute the list command. Note: From memory adress, not line num.
 */
do_list()

{
  int x;
  char prtbuf[150];

  x = getadr();
  do
  {
    list_line(prtbuf, mem + x);
    prtmsg(prtbuf);
    prtmsg("\n");
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
      printf("Exec adr %04x delim %02x err %dx\n", prg - mem, *prg, errnum);
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
      if (*prg <= 'z')
        assign(&prg);
      else
      {
        if (DEBUG)
          printf("Break, Exec adr %04x delim %02x err %dx\n", prg - mem, *prg, errnum);
        error("Not implemented command");
      }
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
      prtmsg(stringvar + 4 + i);
      continue;
    }
    if (token == SEMICOLON)
    {
      (*prg)++;
      continue;
    }
    /* Print expression */
    if ((token == '2') || (token == '4') || (token >= 0x80) ||
        ((token >= 'A') && (token <= 'Z')))
    {
      token = int_expr(prg);
      prt_decnum(token);
      continue;
    }
    /* Print string */
    if ((token == '"') || (token == '\''))
    {
      (*prg)++;
      while (**prg != token)
      {
        prtchr(**prg);
        (*prg)++;
      }
      (*prg)++;
      continue;
    }
    break;
  }
  if ((*(*prg - 1)) != SEMICOLON)
    prtmsg("\n");
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
    /*
     * Handle string variable concatenate
     */
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
    /*
     * Handle assign of string with a given quoted string
     */
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
    /*
     * Handle assign of a string expression
     */
    if (delim >= MID)
    {
      (*prg)++;
      len += do_string_func(delim, prg, &invar[len + 4]);
      if (len >= maxlen)
      {
        error("Too long string assign");
        break;
      }
      continue;
    }
    break;
  }

  /* Update length and other information */

  invar[len + 4] = 0;
  invar[2] = len >> 8;
  invar[3] = len & 0xff;
}

/*
 * Handle the various string functions
 *
 * prg is the program pointer (indirect 2 steps)
 * delim is the token code of the function to be executed.
 * asspnt is the pointer where the string data is put.
 * The function returns the lenght of the assignment.
 */

int do_string_func(delim, pnt, asspnt)

byte delim;
byte **pnt;
byte *asspnt;
{
  int i;
  int handle; /* The variable on which a string expression is working */
  int asnvar, asnlen;
  int len, maxlen;
  byte *invar, *asnstr;

  switch (delim)
  {
  case RIGHT:
  case LEFT:
  case MID:
    if (**pnt != '(')
    {
      error("Missing '('");
      return (0);
    }
    (*pnt)++;
    handle = **pnt - 'a';
    if ((handle < 0) || (handle > 32))
    {
      error("Not a string in string expr");
      return (0);
    }
    (*pnt)++;
    asnvar = stringadr[handle];
    if (asnvar == -1)
    {
      error("String requires dim");
      return (0);
    }
    i = int_expr(pnt);

    /* Now junk code from string assign - watch out! */
    invar = stringvar + stringadr[handle];
    maxlen = invar[0] * 0x100 + invar[1];
    asnstr = stringvar + asnvar;
    asnlen = (asnstr[2] << 8) + asnstr[3];
    if (DEBUG)
      printf("Assign var %c length %d\n", handle, asnlen);
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

    if (**pnt != ')')
      error("Missing ')'");
    (*pnt)++;
    return (i);

  case HEX:
  case CHR:
    i = int_expr(pnt);
    if (DEBUG)
      printf("CHR %d\n", i);
    *asspnt = i;
    return (1);
  }
}
