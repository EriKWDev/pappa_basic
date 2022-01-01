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

int expr(pnt)
unsigned char **pnt;
{
   int i, j;
   i = expr2(pnt);
   switch(**pnt)
   {
     case AND:    (*pnt)++;
                  j = expr2(pnt);
                  printf("AND");
                  return(i & j);
     case OR:     (*pnt)++;
                  j = expr2(pnt);
                  printf("OR");
                  return(i | j);
   }
   return(i);
}

int expr2(pnt)
unsigned char **pnt;
{
   int i, j;
   i = expr3(pnt);
   switch(**pnt)
   {
     case EQ:     (*pnt)++;
                  j = expr3(pnt);
                  return(i != j);
     case NEQ:    (*pnt)++;
                  j = expr3(pnt);
                  return(i == j);
     case LT:     (*pnt)++;
                  j = expr3(pnt);
                  return(i < j);
     case GT:     (*pnt)++;
                  j = expr3(pnt);
                  return(i > j);
     case LTE:    (*pnt)++;
                  j = expr3(pnt);
                  return(i <= j);
     case GTE:    (*pnt)++;
                  j = expr3(pnt);
                  return(i >= j);
   }
   return(i);
}

int expr3(pnt)
unsigned char **pnt;
{
   int i, j;
   i = expr4(pnt);
   switch(**pnt)
   {
     case PLUS:   (*pnt)++;
                  j = expr4(pnt);
                  return(i + j);
     case MINUS:  (*pnt)++;
                  j = expr4(pnt);
                  return(i - j);
   }
   return(i);
}

int expr4(pnt)
unsigned char **pnt;
{
   int i, j;
   i = expval(pnt);
   switch(**pnt)
   {
     case MUL:    (*pnt)++;
                  j = expval(pnt);
                  return(i * j);
     case DIV:    (*pnt)++;
                  j = expval(pnt);
                  if (j == 0)
                  {
                    printf("Div 0\n");
                    return(0);
                  }
                  else
                  return(i / j);
   }
   return(i);
}
/*
 * Now lowest level, evaluate numeric, parantheses
 * functions or variables.
 */

int expval(pnt)
unsigned char **pnt;
{
  int i;

  if (**pnt == '2')
  {
    i = *(*pnt + 1) << 8;
    i += *(*pnt + 2);
    *pnt += 3;
    return(i);
  }
  if (**pnt == '4')
  {
    i = *(*pnt + 1) << 24;
    i += *(*pnt + 2) << 16;
    i += *(*pnt + 3) << 8;
    i += *(*pnt + 4);
    *pnt += 5;
    return(i);
  }
  if (**pnt == LEFTPAR)
  {
    printf("PAR 4");
    (*pnt)++;
    i = expr(pnt);
    if (**pnt != RIGHTPAR)
       error("Syntax: missing )");
    *pnt++;
    return(i);
  }
  if (**pnt >= 0x80)
  {
    (*pnt)++;
    return(0);
  }
  if (**pnt >= 0x40)
  {
    i = vars[**pnt - 'A'];
    (*pnt)++;
    return(i);
  }
}
