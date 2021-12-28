#include <stdio.h>

char nisse[] = "Martin Gren\n";

main()
{
  char *pnt;
  pnt = nisse;
  while (*pnt > 0)
    kalle(&pnt);
}

kalle(pek)

char **pek;

{
   int i;
   char *p2;

   i = **pek;
   printf("%c", i);
   (*pek)++;
}
