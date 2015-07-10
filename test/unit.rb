$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )
require 'coveralls'
Coveralls.wear!
require 'test/unit'
require 'markov-polo'

class MarkovUnit < Test::Unit::TestCase

  def test_chain1
    puts "Testing First Chain"
    chain = MarkovPolo::Chain.new
    chain << "Hello World"
    chain << "Hello You"
    chain << "Hello World Again"
    chain << "Hello You Once Again Done"

    possibilites = [
      "Hello World", "Hello You", "Hello World Again",
      "Hello You Once Again", "Hello You Once Again Done",
      "Hello World Again Done"
    ]           # Seriously, how am I supposed to test randomness?

    100.times do
      assert_equal(possibilites.include?(chain.generate), true)
    end

    assert_equal(chain.to_hash.to_s, File.read("test/known_hash.txt"))

    puts "First Chain Complete"
  end

end
