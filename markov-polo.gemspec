# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markov-polo'

Gem::Specification.new do |spec|
  spec.name          = "markov-polo"
  spec.version       = MarkovPolo::VERSION
  spec.authors       = ["JacisNonsense"]
  spec.email         = ["jaci.brunning@gmail.com"]

  spec.summary       = %q{A No Bullshit Markov Chain Generator in Pure Ruby}
  spec.homepage      = "http://github.com/JacisNonsense/MarkovPolo"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.bindir        = "bin"
  spec.files = Dir.glob("lib/**/*") + ['Rakefile', 'markov-polo.gemspec', 'Gemfile', 'Rakefile']
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "coveralls"
end
