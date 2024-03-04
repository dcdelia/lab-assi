# Part 1

def sum arr
    sum = 0
    if arr.length == 0
      return sum
    else
      arr.each do |item|
        sum += item
      end
      return sum
    end
  end
  
  def max_2_sum arr
    if arr.length == 0
      return 0
    elsif arr.length == 1
      return arr[0]
    else
      max1 = arr[0] #greater
      max2 = arr[1]
      if max1 < max2
        max1, max2 = max2, max1
      end
      (2...arr.length).each do |index|
        if arr[index] > max1
          max2, max1 = max1, arr[index]
        elsif arr[index] > max2
          max2 = arr[index]
        end
      end
      return max1 + max2
    end
  end
  
  def sum_to_n? arr, n
    if arr.length <= 1
      return false
    else
      (0...arr.length-1).each do |index1|
        (index1+1...arr.length).each do |index2|
          if arr[index1] + arr[index2] == n
            return true
          end
        end
      end
      return false
    end
  end
  
  # Part 2
  
  def hello(name)
    return 'Hello, '+name
  end
  
  def starts_with_consonant? s
    c = s.downcase[0]
    if (c =~ /[a-z]/) != nil && c != 'a' && c != 'e' && c != 'i' && c != 'o' && c != 'u'
      return true
    end
    return false
  end
  
  def binary_multiple_of_4? s
    if s =~ /^([01]+00|0)$/
      return true
    else
      return false
    end
  end
  
  # Part 3
  
  class BookInStock
    
    def initialize(isbn, price)
      if isbn == '' || price <= 0
        raise ArgumentError.new()
      end
      @isbn = isbn
      @price = price
    end
  
    attr_accessor :isbn, :price
  
    def price_as_string()
      "$%0.2f" % [@price]
    end
  
  end