Citrus::Configuration.describe do |c|
  c.build_script = 'gem ins bundler && bundle install && bundle exec rspec'
end
