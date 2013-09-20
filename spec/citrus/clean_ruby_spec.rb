require 'spec_helper'

describe 'Ruby syntax' do

  it 'is clean' do
    expect(citrus_core_warnings).to eq([])
  end

  def citrus_core_warnings
    warnings.select { |w| w =~ %r{lib/citrus/core} }
  end

  def warnings
    `ruby -w lib/citrus/core.rb 2>&1`.split("\n")
  end

end
