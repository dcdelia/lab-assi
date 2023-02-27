# Based on codes available at https://www.tutorialspoint.com/ruby/ruby_object_oriented.htm
class Box
    @@count = 0
    BOX_COMPANY = "TATA Inc" # constant
    # constructor method
    def initialize(w,h)
       @width, @height = w, h
       @@count += 1
    end
 
    # accessor methods
    def getWidth
       @width
    end
    def getHeight
       @height
    end
 
    # setter methods
    def setWidth=(value)
       @width = value
    end
    def setHeight=(value)
       @height = value
    end
   
    # instance method
    def getArea
       @width * @height
    end

    # define to_s method
    def to_s
        "(w:#@width,h:#@height)"  # string formatting of the object.
    end

    # static (class) method
    def self.printCount()
        puts "Box count is : #@@count"
    end

    def +(other)       # Define + to do vector addition
        Box.new(@width + other.width, @height + other.height)
    end
  
    def -@           # Define unary minus to negate width and height
        Box.new(-@width, -@height)
    end
  
    def *(scalar)           # To perform scalar multiplication
        Box.new(@width*scalar, @height*scalar)
    end
end

# define a subclass
class BigBox < Box

    # add a new instance method
    def printArea
       @area = @width * @height
       puts "Big box area is : #@area"
    end

    # OVERRIDING, change existing getArea method as follows
    def getArea
        @area = @width * @height
        puts "Big box area is : #@area"
    end
end
 
# create an object
box = Box.new(10, 20)
a = box.getArea()
puts "Area of the box is : #{a}"
puts Box::BOX_COMPANY
 
# use setter methods
box.setWidth = 30
box.setHeight = 50
 
# use accessor methods
x = box.getWidth()
y = box.getHeight()
 
puts "Width of the box is : #{x}"
puts "Height of the box is : #{y}"

box2 = Box.new(30, 100)

Box.printCount()

puts "String representation of box is : #{box}"

box3 = BigBox.new(10, 20)

# print the area
box3.printArea()