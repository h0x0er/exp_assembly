#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
extern void assembly_main();
extern void print_internal(char *, int);
extern int rename_internal(char *, char *);

int main() {

  // print_internal("heyasm\x0d\x0a", 8);
  assembly_main();

  // int ret = rename_internal("renamed2", "renamed");
  // printf("ret=%d\n", ret);

  exit(0);
}