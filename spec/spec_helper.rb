require 'bogus/rspec'
require 'fakefs/spec_helpers'
require 'citrus/core'

RSpec.configure do |config|
  config.order = 'random'
end

Bogus.configure do |config|
  config.search_modules << Citrus::Core
end
