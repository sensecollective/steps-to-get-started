#include <stdio.h>
int main() {
  char str1[]="TGS";
  char str2[]="tgs";
  if(strcmp(str1,str2)) {
    printf("String are not matched\n");
  }
  else {
    printf("Strings are matched\n");
  }
}
