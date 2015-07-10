require 'json'
require 'digest'
require 'optparse'

require 'markov-polo'

@cycles = 1

OptionParser.new do |o|
  o.on('-c CHANNEL') {|c| @chan = c}
  o.on('-m CYCLES') {|m| @cycles = m.to_i}
  o.on('-h') { puts o; exit }
  o.parse!
end

@chan ||= (puts "Channel?"; gets.chop!)

chain = MarkovPolo::Chain.new
chain.load JSON.parse(File.read("dump/irc/#{Digest::MD5.hexdigest(@chan)}_dump.json"))
@cycles.to_i.times { puts chain.generate }
