// You can compile this program by running `./build.sh`. Then you can
// run `./main`.
//
// normally we don't `#include` source files, but I'm making an
// exception here.
#include "./dynarray.c"

int main () {
  DynamicArray* dynArrp = createDynamicArray();

  // push a bunch of elements onto the array
  for (int i = 0; i < 25; i++) {
    // This creates strings
    char* str = malloc(255);
    snprintf(str, 255, "s%d", i);

    push(dynArrp, str);
  }

  // pop them all off
  while (length(dynArrp) > 0) {
    int position = length(dynArrp) - 1;
    char* str = pop(dynArrp);
    printf("#%d: %s\n", position, str);
    free(str);
  }
  printf("Length: %d\n", length(dynArrp));
  freeDynamicArray(dynArrp);

  return 0;
}
