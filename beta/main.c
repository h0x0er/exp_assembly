#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

extern int _get_pid();
extern int _print_pid();
extern int _print_ppid();
extern int _create_file();

extern void authn(int);
extern void to_str(int);
extern void take_input();

extern void _rename_file();

int main() {
  //   long x = _get_pid();
  //   printf("pid: %ld\n", x);

  _print_ppid();
  _print_pid();

  const char *old = "./fname";

  _create_file(old, 0777);

  authn(100);
  to_str(1);
  to_str(3);
  to_str(3);

  take_input();

  exit(0);
}