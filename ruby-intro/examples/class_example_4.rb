class C1
    def initialize(a)
        @a = a
    end

    def method1()
        puts('versione base')
    end
end

class C2 < C1
    def initialize(a,b)
        super(a)
        @b = b
    end

    def method1()
        super()
        puts('versione extra')
    end

    attr_reader :a, :b
end

c = C1.new(1)
c2 = C2.new(1,2)
puts(c2.a)
puts(c2.b)
c2.method1()
