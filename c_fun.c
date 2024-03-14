#include <stdio.h>

void print_test(int id)
{
  static int count=1;
  printf("transaction id: %0d\n", id);
  printf("Test DPI: %0d\n", count++);
}
