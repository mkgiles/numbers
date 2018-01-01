# numbers
A Scheme (R5RS) program for converting natural numbers to their equivalent english names according to Conway-Weschler long count.

This script provides a function and a collection of helper functions for the purpose of converting whole numbers into their english names according to the Conway-Weschler nomenclature.
Contained within this script are the functions:

prefix: a function which takes the size of a number and returns the corresponding Conway-Weschler prefix.

index: a function which takes the size of a number and returns the suffix associated with a number of that magnitude.

number-block: a function which takes a number n, an index i, and a block size b; and returns just the b-digit number at index i.

human-number: a function which names numbers between 0-999 inclusive.

name: a function using all of the above helper functions to name any number nameable according to the nomenclature.
