require 'openssl'
require 'open-uri'
require 'json'
require 'optparse'
require 'fileutils'
require 'digest'

require 'markov-polo'

OptionParser.new do |o|
  o.on('-u LOGFILE') {|log| @log = log}
  o.on('-c CHANNEL') {|chan| @fn = chan}
  o.on('-h') { puts o; exit }
  o.parse!
end

@log ||= (puts "Log File?"; gets.chop!)
@fn ||= (puts "Channel?"; gets.chop!)

regexp = /\d*-\d*-\d*\|\d*:\d*:\d*<.*>\s+(.*)/        # Capture group 1 should be the actual message

puts "Reading Log File..."
chain = MarkovPolo::Chain.new
open(@log, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read.split(/(\r?\n)|(\r)/).each do |line|
  if !(line =~ regexp); next; end
  components = line.gsub(regexp, "\\1")
  chain << components
end

fn = Digest::MD5.hexdigest @fn
FileUtils.mkdir_p "dump/irc" unless File.exists? "dump/irc"
File.write("dump/irc/#{fn}_dump.json", JSON.pretty_generate(chain.to_h))
puts "Dump saved! (#{@fn})"
