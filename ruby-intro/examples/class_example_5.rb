class Ciao

    def initialize()
        @title = 'ciao'
    end

    def title()
        return @title
    end
end

c = Ciao.new()
t = c.title()
t.reverse!()
puts(c.title()) # side effect
