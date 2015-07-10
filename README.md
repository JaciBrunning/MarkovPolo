# Markov Polo
A No Bullshit™, Super-Tiny Markov Chain engine in Pure Ruby  

[![Build Status](https://travis-ci.org/JacisNonsense/MarkovPolo.svg)](https://travis-ci.org/JacisNonsense/MarkovPolo) [![Coverage Status](https://coveralls.io/repos/JacisNonsense/MarkovPolo/badge.svg?branch=master&service=github)](https://coveralls.io/github/JacisNonsense/MarkovPolo?branch=master) [![Code Climate](https://codeclimate.com/github/JacisNonsense/MarkovPolo/badges/gpa.svg)](https://codeclimate.com/github/JacisNonsense/MarkovPolo)
## Getting Started
Getting started is very simple. First, install the Gem:
```
  gem install markov-polo
```
or, in your gem file
```
  gem 'markov-polo'
```  

Using the Gem is very simple. First, create a Chain
```ruby
require 'markov-polo'

chain = MarkovPolo::Chain.new
```

To train your chain, it's just like with any Array.  
```ruby
chain << "These are some sample words"
chain.push "This is some more sample text"
```

Generating an output is also very simple
```ruby
puts chain.generate   # => These are some more sample words
```  

Getting access to the raw chain data can be done by:  
```ruby
chain.to_h            # => Hash
```

Restoring a chain from a hash can be done through the constructor
```ruby
chain = MarkovPolo::Chain.new { ... }
```

Likewise, with the Hash, you can store your Chain as a JSON file, or other format of your choosing.
```ruby
require 'json'
File.write "cache_chain.txt", JSON.generate(chain.to_h)
```
