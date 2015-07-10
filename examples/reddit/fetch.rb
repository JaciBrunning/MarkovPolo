require 'open-uri'
require 'json'
require 'optparse'
require 'fileutils'

require 'markov-polo'

@maximum = 5

OptionParser.new do |o|
  o.on('-s SUBREDDIT') {|sr| @subreddit = sr}
  o.on('-m MAXIMUM') {|m| @maximum = m.to_i}
  o.on('-h') { puts o; exit }
  o.parse!
end

@subreddit ||= (puts "Subreddit?"; gets.chop!)

puts "Searching Subreddit: #{@subreddit} (max recursion: #{@maximum} [#{@maximum * 100} posts])"

after = ""
index = 0
index_elapsed = 0
chain = MarkovPolo::Chain.new

start = Time.now
begin
  while ((index < @maximum) || (index == -1)) && (after != nil)
    response = JSON.parse(open("http://reddit.com/r/#{@subreddit}/search.json?restrict_sr=on&t=all&limit=100#{after == "" ? "" : "&after=#{after}"}").read)
    response['data']['children'].each do |child|
      chain << child['data']['title']
      if child['data']['selftext'] != ""
        chain << child['data']['selftext']
      end
    end
    index += 1
    index_elapsed += 1
    after = response['data']['after']
    if index_elapsed >= 30
      sleep 60 - (Time.now - start)
      start = Time.now
      index_elapsed = 0
    end
  end
rescue => e
  puts e
ensure
  puts "Stopped (#{index} pages)"
end

FileUtils.mkdir_p "dump/r" unless File.exists? "dump/r"
File.write("dump/r/#{@subreddit}_dump.json", JSON.pretty_generate(chain.to_h))
puts "Dump saved to: dump/r/#{@subreddit}_dump.json"
