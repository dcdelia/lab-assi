class ClassExample
	@@class_variable_default = 'something_default_shared'
	CONSTAT = '192.168.0.1'

	def initialize(first_arg, second_arg = 0, *other_args)
		@instance_var1 = first_arg
		@instance_var2 = second_arg
		puts("#{other_args.length} other arguments are passed")
	end
	attr_accessor :instance_var1 # can read and write this attribute
  	attr_reader :instance_var2    # can only read this attribute

    def instance_method1()
        @instance_var1 += 1
    end

    # def ClassExample.classMethod(a)
    def self.classMethod(a)
        return a*2
    end
end

v1 = ClassExample.new(1,2,3,4,5)
v2 = ClassExample.new(second_arg=-2, first_arg=-1, -3,-4,-5)

puts(v1.instance_var1)
puts(v2.instance_var2)

v1.instance_method1()
puts(v1.instance_var1)
puts(ClassExample.classMethod(1))