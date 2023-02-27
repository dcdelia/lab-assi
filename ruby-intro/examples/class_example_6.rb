class MyClass

    def initialize(first_arg, second_arg = 1, *others)
        puts(others.length())
    end

end

v = MyClass.new(1,2,3,4,5)
v = MyClass.new(2)
v = MyClass.new()