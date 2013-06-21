require 'citrus/core'
require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.order = 'random'
end

require 'bogus/rspec'
Bogus.configure do |config|
  config.search_modules << Citrus::Core
end

require 'coveralls'
Coveralls.wear!


