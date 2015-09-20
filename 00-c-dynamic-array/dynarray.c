// `#include` is C's version of Ruby's `require`. These libraries let
// us allocate memory (`stdlib.h`) and do I/O (`stdio.h`).
#include "stdlib.h"
#include "stdio.h"

// Notes:
// * `malloc(numBytes)` returns `numBytes` of allocated storage.
// * `typedef struct { ... } XYZ` defines a struct in C. A struct is
//   like an object without methods. C doesn't have methods; instead,
//   functions that are passed a DynamicArray argument are defined
//   below.
// * A `void*` is a pointer (also called a reference) to an unknown
//   type of object. This array stores pointers to objects. Because we
//   store a `void*`, we can store a reference to any kind of object
//   into our array, just like in Ruby.
// * `sizeof(XYZ)` returns the number of bytes it takes to store an
//   object. Presumably `sizeof(void*) == 8` since on a 64bit machine
//   a word is eight bytes long.
// * Given a pointer to a struct (like `DynamicArray* dynArrp`), we
//   access an instance variable by `dynArrp->fieldName`.

// Print an error message and then exit.
void error(char* message) {
  printf("%s\n", message);

  exit(1);
}

int DEFAULT_SIZE = 10;

typedef struct {
  // a pointer to an block of memory that stores the pointers to
  // objects in the array.
  void** _store;
  // the maximum capacity of the currently allocated store; we can
  // increase this when we run out of room.
  int _storeCapacity;

  // the number of elements currently stored in the array. This must
  // be <= _storeCapacity at all times.
  int _len;
} DynamicArray;

DynamicArray* createDynamicArray() {
  // Allocate memory for the dynamic array struct.
  DynamicArray* dynArrp = malloc(sizeof(DynamicArray));

  // allocate memory for the store, starting with a default amount of
  // space. There are no elements yet, of course.
  dynArrp->_store = malloc(DEFAULT_SIZE * sizeof(void*));
  dynArrp->_storeCapacity = DEFAULT_SIZE;
  dynArrp->_len = 0;

  return dynArrp;
}

void freeDynamicArray(DynamicArray* arrp) {
  free(arrp->_store);
  free(arrp);
}

// "method" to return the length of a dynamic array.
int length(DynamicArray* dynArrp) {
  return dynArrp->_len;
}

// "method" to get the `idx`th element of the array.
void* get(DynamicArray* dynArrp, int idx) {
  // check that idx is within bounds
  if ((idx < 0) || (idx >= dynArrp->_len)) {
    error("Access out of range!");
  }

  // return the `idx`th pointer in the store array.
  return *(dynArrp->_store + idx);
}

// method to set the `idx`th element of the array to the reference
// `objp`.
void set(DynamicArray* dynArrp, int idx, void* objp) {
  // check that idx is within bounds
  if ((idx < 0) || (idx >= dynArrp->_len)) {
    error("Set out of range");
  }

  // set the `idx`th pointer in the store to `objp`
  *(dynArrp->_store + idx) = objp;
}

// double the size of the store to allow more elements to be stored.
void resize(DynamicArray* dynArrp) {
  // allocate a new store with twice the capacity
  int newStoreCapacity = dynArrp->_storeCapacity * 2;
  void** newStore = malloc(newStoreCapacity * sizeof(void*));

  // copy over the old elements
  for (int i = 0; i < dynArrp->_len; i++) {
    *(newStore + i) = *(dynArrp->_store + i);
  }

  // release the memory for the old store so that it may be reused.
  free(dynArrp->_store);

  // set the `_store` and `_storeCapcity` instance variables.
  dynArrp->_store = newStore;
  dynArrp->_storeCapacity = newStoreCapacity;
}

// push a single reference into the array.
void push(DynamicArray* dynArrp, void* objp) {
  // resize if the store is full.
  if (dynArrp->_len == dynArrp->_storeCapacity) {
    // debugging information so we can see the resize happening.
    printf("Resizing!\n");
    resize(dynArrp);
  }

  // store `objp` at position `_len`
  *(dynArrp->_store + dynArrp->_len) = objp;
  // increment `_len`
  dynArrp->_len += 1;
}

// pop an element from the array.
void* pop(DynamicArray* dynArrp) {
  // check that the array isn't empty.
  if (dynArrp->_len == 0) {
    error("popped empty array");
  }

  // get the last element, decrement `_len`.
  void* objp = *(dynArrp->_store + (dynArrp->_len - 1));
  dynArrp->_len -= 1;

  return objp;
}
