# frozen_string_literal: true

# Before we move on, let's take a step back to our MyStack class. We'll modify it so that we always know the maximum value in the stack. We could write a max method that calls @store.max. However, this requires us to iterate over every item in the @store array, which gives us a time complexity of O(n). This isn't good enough for us; we want to be able to return the max in constant time (O(1)).

# If we can't iterate over @store, how else could we modify the stack to get this functionality?

# Once you have max implemented, it should be easy to add a min method.

# na bieżąco dodając element sprawdzać czy jest najwiekszy?

# Hint: We could store some metadata with the value of each element. In other words, we can be storing more information than just the value with new element to the store. Think about how to do this and what information to store.

# Implement peek, size, empty?, max, min, pop, push methods on your MinMaxStack.
