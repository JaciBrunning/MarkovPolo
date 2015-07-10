module MarkovPolo
  VERSION = "0.1.0"

  class Chain
    START_TOKEN = "__start__"
    END_TOKEN = "__end__"

    def initialize hash={}
      @data = hash
    end

    def << content
      push content
    end

    def push content
      last = START_TOKEN
      sentence.split.each do |word|
        add_member last, word
        last = word
      end
      add_member last, END_TOKEN
    end

    def add_member last, word
      @data[last] = {} unless @data.include? last
      @data[last][word] = 0 unless @data[last].include? word
      @data[last][word] += 1
    end

    def to_h
      @data
    end

    def to_hash
      to_h
    end

    def load hash
      @data = hash
    end

    def generate
      last = START_TOKEN
      total = []
      while last != END_TOKEN
        choices = []
        @data[last].each do |key, val|
          val.times { choices << key }
        end
        chosen = choices.sample

        total << chosen unless chosen == END_TOKEN
        last = chosen
      end
      total.join " "
    end

    private :add_member
  end
end
