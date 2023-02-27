# When done, submit this entire file to the autograder.

# Part 1

def sum arr
  #Define a method `sum(array)` that takes an array of integers as an argument and returns the sum of its elements. For an empty array it should return zero.  
  #Run associated tests via:  `$ rspec -e '#sum ' spec/part1_spec.rb`
  # YOUR CODE HERE
end

def max_2_sum arr
  #Define a method `max_2_sum(array)` which takes an array of integers as an argument and returns the sum of its two largest elements. For an empty array it should return zero. For an array with just one element, it should return that element (Consider if the two largest elements are the same value as well). 
  #Run associated tests via:  `$ rspec -e '#max_2_sum' spec/part1_spec.rb`
  # YOUR CODE HERE
end

def sum_to_n? arr, n
  #Define a method `sum_to_n?(array, n)` that takes an array of integers and an additional integer, n, as arguments and returns true if any two elements in the array of integers sum to n. `sum_to_n?([], n)` should return false for any value of n, by definition. 
  #Run associated tests via:  `$ rspec -e '#sum_to_n' spec/part1_spec.rb` 
  # YOUR CODE HERE
end

# Part 2

def hello(name)
  #Define a method `hello(name)` that takes a string representing a name and returns the string "Hello, " concatenated with the name. 
  #Run associated tests via:  `$ rspec -e '#hello' spec/part2_spec.rb`
  # YOUR CODE HERE
end

def starts_with_consonant? s
  #Define a method `starts_with_consonant?(s)` that takes a string and returns true if it starts with a consonant and false otherwise. (For our purposes, a consonant is any English letter other than A, E, I, O, U.) Make sure it works for both upper and lower case and for non-letters. 
  #Run associated tests via:  `$ rspec -e '#starts_with_consonant?' spec/part2_spec.rb`
  # YOUR CODE HERE
end

def binary_multiple_of_4? s
  #Define a method `binary_multiple_of_4?(s)` that takes a string and returns true if the string represents a binary number that is a multiple of 4, such as '1000'. Make sure it returns false if the string is not a valid binary number. 
  #Run associated tests via:  `$ rspec -e '#binary_multiple_of_4?' spec/part2_spec.rb`
  # YOUR CODE HERE
end

# Part 3

class BookInStock
  #Define a class `BookInStock` which represents a book with an ISBN number, `isbn`, and price of the book as a floating-point number, `price`, as attributes. 
  #Run associated tests via:  `$ rspec -e 'getters and setters' spec/part3_spec.rb` (Make sure you are in the correct directory: `cd assignment`)
  #The constructor should accept the ISBN number (a string, since in real life ISBN numbers can begin with zero and can include hyphens) as the first argument and price as second argument, and should raise `ArgumentError` (one of Ruby's built-in exception types) if the ISBN number is the empty string or if the price is less than or equal to zero.  Include the proper getters and setters for these attributes. Run associated tests via:  `$ rspec -e 'constructor' spec/part3_spec.rb`
  #Include a method `price_as_string` that returns the price of the book formatted with a leading dollar sign and two decimal places, that is, a price of 20 should format as `$20.00` and a price of 33.8 should format as `$33.80`. Check out formatted string methods in Ruby. Run associated tests via:  `$ rspec -e '#price_as_string' spec/part3_spec.rb`
# YOUR CODE HERE
end
