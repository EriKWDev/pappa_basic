/*
 * Code for MG BASIC expression analyzer
 *
 * Jan 1982: Initial version
 * Jan 5, 1996: Initial version in C.
 *
 */

#include "typedef.h"
#include "commands.h"
#include "basic.h"
#include <stdio.h>

int int_expr(pnt)
unsigned char **pnt;
{
  int i;
  i = int_expr2(pnt);
  while (1 == 1)
  {
    switch (**pnt)
    {
    case AND:
      (*pnt)++;
      i = i & int_expr2(pnt);
      continue;
    case OR:
      (*pnt)++;
      i = i | int_expr2(pnt);
      continue;
    default:
      return (i);
    }
  }
}

int int_expr2(pnt)
unsigned char **pnt;
{
  int i;
  i = int_expr3(pnt);
  while (1 == 1)
  {
    switch (**pnt)
    {
    case EQ:
      (*pnt)++;
      i = i == int_expr3(pnt);
      continue;
    case NEQ:
      (*pnt)++;
      i = i != int_expr3(pnt);
      continue;
    case LT:
      (*pnt)++;
      i = i < int_expr3(pnt);
      continue;
    case GT:
      (*pnt)++;
      i = i > int_expr3(pnt);
      continue;
    case LTE:
      (*pnt)++;
      i = i <= int_expr3(pnt);
      continue;
    case GTE:
      (*pnt)++;
      i = i >= int_expr3(pnt);
      continue;
    default:
      return (i);
    }
  }
}

int int_expr3(pnt)
unsigned char **pnt;
{
  int i;
  i = int_expr4(pnt);
  while (1 == 1)
  {
    switch (**pnt)
    {
    case PLUS:
      (*pnt)++;
      i += int_expr4(pnt);
      continue;
    case MINUS:
      (*pnt)++;
      i -= int_expr4(pnt);
      continue;
    default:
      return (i);
    }
  }
}

int int_expr4(pnt)
unsigned char **pnt;
{
  int i, j;
  i = int_expval(pnt);
  while (1 == 1)
  {
    switch (**pnt)
    {
    case MUL:
      (*pnt)++;
      i *= int_expval(pnt);
      continue;
    case DIV:
      (*pnt)++;
      j = int_expval(pnt);
      if (j == 0)
      {
        error("Div 0");
        return (0);
      }
      else
        i = i / j;
      continue;
    default:
      return (i);
    }
  }
}

/*
 * Now lowest level, evaluate numeric, parantheses
 * functions or variables.
 */

int int_expval(pnt)
unsigned char **pnt;
{
  int i, func;

  func = **pnt;
  if (func == '2')
  {
    i = *(*pnt + 1) << 8;
    i += *(*pnt + 2);
    *pnt += 3;
    return (i);
  }
  if (func == '4')
  {
    i = *(*pnt + 1) << 24;
    i += *(*pnt + 2) << 16;
    i += *(*pnt + 3) << 8;
    i += *(*pnt + 4);
    *pnt += 5;
    return (i);
  }
  if (func == '(')
    return (int_parfunc(pnt));
  /*
   * Handle functions. Enter your function in the case-statement.
   */
  if (func >= 0x80)
  {
    (*pnt)++;
    switch (func)
    {
    case MINUS:
      return (0 - int_expr(pnt));
    case SGN:
      i = int_parfunc(pnt);
      if (i == 0)
        return (0);
      if (i > 0)
        return (1);
      return (-1);
    case ABS:
      i = int_parfunc(pnt);
      if (i < 0)
        i = 0 - i;
      return (i);
    case GET:
      return (getchr());
    case PEEK:
      i = int_parfunc(pnt);
      return (i);
    default:
      printf("Func %02x, %02x %x\n", func, **pnt, *pnt);
      error("Not implemented function");
      return (0);
    }
  }
  if (**pnt >= 0x40)
  {
    i = vars[**pnt - 'A'];
    (*pnt)++;
    return (i);
  }
}
/*
 * Handle paranthesis function
 */
int int_parfunc(pnt)

byte **pnt;

{
  int i;

  if (**pnt != '(')
  {
    error("Missing '('");
    return (0);
  }
  (*pnt)++;
  i = int_expr(pnt);
  if (**pnt != ')')
    error("Missing ')'");
  (*pnt)++;
  return (i);
}
