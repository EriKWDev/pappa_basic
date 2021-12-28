/*
 *
 * Basic line command compiler
 *
 * Martin Gren Jan 5, 1996
 *
 * Base: MG Assembler, sometime 1987
 *
 */

#define DEBUG   (0 == 1)

#include "typedef.h"
#include <stdio.h>

#include "commands.h"
#include "codes.h"

/*
 * Compile one BASIC line. Format is:
 * Byte 0,1: Line number as word
 * Byte 2..x Code data.
 *
 * Code data is defined as:
 *
 * Token >= 0x80: One BASIC token.
 * data: 0x40-0x5f: Data Variable name
 * data: 0x60-0x7f: String Variable name
 * data: 0x34: Numerical value follows, stored as long word (4 bytes).
 * data: 0x32: Numerical value follows, stored as word (2 bytes).
 * data: ' or ": String value, terminated with matching quote
 * data: ':' : Line separator, stored as : (0x3a)
 */

int compline(inbuf, outbuf)

char *inbuf;
byte *outbuf;
{
  int i, token;
  byte *first;
  char *apos;


  apos = inbuf;
  first = outbuf;
  outbuf++;

  while((token = ignblk(&apos)) > 0x20)
  {
/* First take numerical values */

    if ((token >= '0') && (token <= '9')) 
    {
      token = line_expr(&apos);
      if (token >= 0x10000)
      {
        *outbuf++ = '4';
        *outbuf++ = token >> 24;
        *outbuf++ = token >> 16;
      }
      else
        *outbuf++ = '2';
      *outbuf++ = token >> 8;
      *outbuf++ = token;
      continue;
    }

/* Handle separator and words not to be compiled */
    if ((token == ':') || (token == '(') || (token == ')'))
    {
      *outbuf++ = token;
      apos++;
      continue;
    }
/* Handle quoted text */

    if ((token == '\'') || (token == '"'))
    {
      i = token;
      *outbuf++ = token;
      apos++;
      while((*apos != i) && (*apos >= 0x20))
      {
        *outbuf++ = *apos;
        apos++;
      }
      *outbuf++ = token;
      if (token == *apos)
        apos++;
      continue;
    }

/* Handle Reserved word */
    i = getnr(&apos);
    if (i != -1)
    {
      token = i;
      *outbuf++ = token;
    }
    else
    {
/* Here handle variables. If name followed by $, treat as string */
      if (token >= 0x40)
      {
        apos++;
        token = token & 0x5f;
        if (*apos == '$')
        {
          apos++;
          *outbuf++ = token + 0x20;
        }
        else
          *outbuf++ = token;
      }
      else
      {
        error("undefined token");
        return(3);
      }
    }
    continue;
  }
  token = 13;
  *outbuf++ = 10;
  i = outbuf - first;
  *first = i;
  return(0);
}

/*
 * Get the token code number. Pointer of is then
 * increased to the point of next token.
 */

int getnr(pnt)

char **pnt;

{
    int tmp,exit,current;
    byte *incode;

    incode = codes;
    exit = current = 0;
    do
    {
        tmp = 0;
        current++;
        do
        {
            if (*incode == (*(*pnt + tmp) | 0x20))
            {
              tmp++;
              incode++;
              if (*incode == 0)
              {
                 *pnt += tmp;
                 return(current - 1 + 0x80);
              }
            }
            else
               while (*incode != 0)
                    incode++;
        }
        while(*incode != 0);
        incode++;
    }
    while ((*(incode + 1) != 32) && (exit == 0));
    return(-1);
}
/*
 * Print Token code as string
 */
print_token_code(buf, token)

char **buf;
int token;
{
  byte *incode;

  incode = codes;
  token -= 0x80;
  while((token > 0) && (*incode > 0))
  {
    token--;
    while(*incode > 0)
      incode++;
    incode++;
  }
  if (token == 0)
  {
    while(*incode > 0)
      *(*buf)++ = *incode++;
  }
  else
    error("Missing Token");
}

/*
 * Ignore spaces and tabs
 */

ignblk(buf)

char **buf;

{ 
    while((**buf == 32) || (**buf == 9))
        (*buf)++;
    return(**buf);
}

/*
 * Get one numerical (or hex) digit. If so, advance *apos and leave
 * if no digit.
 * If no hexadecimal digit, return 16.
 */

int egethex(pnt)

char **pnt;
{
    int i, j;

    i = **pnt;
    if ((i < '0') || ((i >'9') && (i < 'A')))
       return(16);
    if (i > 0x60)
        i -= 0x20;
    i -= '0';
    if (i < 0)
        return(16);
    if (i > 9)
        i -= 7;
    if (i >= 16)
        return(16);
    (*pnt)++;
    return(i);
}

/*
 * Get line data. Handles extended syntax, accepts hex and dec.
 * Hex syntax is 0x4e for instance.
 * *apos is moved towards end of expression.
 */

int line_expr(pnt)

char **pnt;

{
    int i,val;

    val = 0;
    if ((**pnt == '0') && (*(*pnt + 1) == 'x'))
    {
        *pnt += 2;
        while ((i = egethex(pnt)) < 0x10)
            val = val * 0x10 + i;
    }
    else
    {
        while ((i = egethex(pnt)) < 10)
            val = val * 10 + i;
    }
    return(val);
}

/*
 * List one line of basic semicompiled data
 */

list_line(prtbuf, buf)

char *prtbuf;
byte *buf;
{
  int i, token;
  char *t;

  buf++;  /* Ignore counter byte */
  while(*buf >= 0x20)
  {
    token = *buf++;

/* Handle parenthesis */
    if ((token == '(') || (token == ')'))
    {
      *prtbuf++ = token;
      continue;
    }
/* Handle quoted strings */
    if ((token == '"') || (token == '\''))
    {
      *prtbuf++ = token;
      while((*buf != token) && (*buf >= 0x20))
        *prtbuf++ = *buf++;
      *prtbuf++ = token;
      buf++;
      continue;
    }

/* Handle variables */
    if ((token >= 'A') && (token <= 'Z'))
    {
      *prtbuf++ = token;
      continue;
    }
    if ((token >= 'a') && (token <= 'z'))
    {
      *prtbuf++ = token - 0x20;
      *prtbuf++ = '$';
      continue;
    }
/* Handle numerical value */
    if ((token == '2') || (token == '4'))
    {
      i = 0;
      if (token == '4')
      {
        i = (*buf++) * 0x1000000;
        i += (*buf++) * 0x10000;
      }
      i += (*buf++) * 0x100;
      i += (*buf++);
      buf_decnum(&prtbuf, i);
      *prtbuf++ = ' ';
      continue;
    }
    if (token == ':')
    {
      *prtbuf++ = ' ';
      *prtbuf++ = ':';
      *prtbuf++ = ' ';
      continue;
    }
    if (token >= 0x80)
    {
      print_token_code(&prtbuf, token);
      *prtbuf++ = ' ';
      continue;
    }
  }
  *prtbuf = 0;
}

/*
 * Insert one BASIC line into memory
 *
 * Format is:
 * 1 byte line length (inclusive of num and length)
 * 2 bytes line number
 * (bytes length of data)
 * 0A = end of line
 * 00 = end of file.
 *
 * Line numbers have to be 2 bytes.
 * If you simply give a line-number, it will be removed.
 * If you re-write, it will be replaced.
 * If you remove a non-existing number, no action will be done.
 */

basicins(progmem, buffer)

byte *progmem;
byte *buffer;

{
  byte *inspos, *end;
  int size, i, newnum;

  if (*(buffer + 1) == '4')
  {
    error("Can't use linenumber over 65000\n");
    return(1);
  }
/* Get the new line number to insert */
  newnum = (*(buffer + 2)) * 0x100 + (*(buffer + 3));

/* Remove the line, if remove or replace! */
  remove_line(progmem, newnum);
  if ((*buffer <= 5) && (*(buffer + 1) == '2'))
      return(0);

  if (*(buffer + 1) != '2')
  {
    error("Direct execute\n");
    return(1);
  }
  if (DEBUG) printf("New number is %d\n", newnum);
  size = prog_size(progmem); 
  end = progmem + size; 
  i = search_line(progmem, newnum);
  inspos = progmem + i;
  if (DEBUG) printf("Size %x position %x, to insert %x\n", size, i, *buffer);

/* Now move memory to fit new line */

  while(end != inspos)
  {
    *(end + (*buffer)) = *end;
    *end--;
  }
  *(end + (*buffer)) = *end;

/* Insert the compiled buffer */

  for (i = 0; i < *buffer; i++)
  {
    *(inspos + i) = *(buffer + i);
  }
}

/*
 * Remove one line.
 */

int remove_line(progmem, num)
byte *progmem;
int num;
{
  int i, j, size, atnum;
  byte *tmp, *end;

  i = search_line(progmem, num);
  tmp = progmem + i;
  atnum = (*(tmp + 2)) * 0x100 + (*(tmp + 3));
  if (atnum != num)
      return(0);
  j = prog_size(progmem);
  end = progmem + j;
  if (DEBUG) printf("To rem: %d, am at %d, adr %x, size %x\n",num, atnum, i, j);
  size = *tmp;
  while(tmp <= end)
  {
    *tmp = *(tmp + size);
    tmp++;
  }
  return(0);
}

/*
 * Search for a line number. Answer is in offset from start.
 */

int search_line(progmem, num)

byte *progmem;
int num;
{
  int i;
  byte *tmp;
  int size = 0;

  tmp = progmem;
  while(*tmp != 0)
  { 
    i = (*(tmp + 2)) * 0x100 + (*(tmp + 3));
    if (i >= num)
      return(size);
    size += *tmp;
    tmp += *tmp;
  } 
  return(size);
}

/*
 * Count program size, in number of bytes
 */

int prog_size(progmem)

byte *progmem;
{
  byte *tmp;
  int size = 0;

  tmp = progmem;
  while (*tmp > 0)
  { 
    size += *tmp;
    tmp += *tmp;
  } 
  return(size);
}
/*
 * Print decimal number to stdout
 */

prt_decnum(num)

int num;
{
  char  stack[10];
  char  *st;

  st = stack;
  buf_decnum(&st, num);
  *st = 0;
  prtmsg(stack);
}
/*
 * Print decimal number to buffer
 */

buf_decnum(buf, num)

char **buf;
int num;
{
  int i, neg;
  char ch[10];
  char *pnt;

  i = 10;
  if (num < 0)
  {
    num = 0 - num;
    **buf = '-';
    (*buf)++;
  }
  do
  {
    i--;
    ch[i] = '0' + (num % 10);
    num = num / 10;
  }
  while(num > 0);

  while(i < 10)
  {
    **buf = ch[i++];
    (*buf)++;
  }
  **buf = 0;
}
