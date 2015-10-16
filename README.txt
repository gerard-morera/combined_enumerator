The aim of this class is to take a number of ordered enumerators and then
emit their values in ascending order.

Some assumptions:
  * The enumerators passed in emit their values in ascending order.
  * The enumerators emit values which are Comparable[1] with each other.
  * The enumerators can be finite *or* infinite.
  
Test suit can be run with: `ruby ./test/combined_enumerator_test.rb`.
