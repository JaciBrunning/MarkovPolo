require 'json'
require 'optparse'

require 'markov-polo'

@cycles = 1

OptionParser.new do |o|
  o.on('-s SUBREDDIT') {|sr| @subreddit = sr}
  o.on('-m CYCLES') {|m| @cycles = m.to_i}
  o.on('-h') { puts o; exit }
  o.parse!
end

@subreddit ||= (puts "Subreddit?"; gets.chop!)

chain = MarkovPolo::Chain.new
chain.load JSON.parse(File.read("dump/r/#{@subreddit}_dump.json"))
@cycles.to_i.times { puts chain.generate }
