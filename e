
/*
 * Error handling
 */
error(msg)
char *msg;
{
  printf("Error: %s\n", msg);
  errnum = 3;
}
