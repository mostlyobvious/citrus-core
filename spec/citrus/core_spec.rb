require 'spec_helper'

describe Citrus::Core do

  subject { described_class }
  before  { stub(subject).root { Pathname.new('/dummy') } }

  context '.cache_root' do
    specify { expect(subject.cache_root.to_s).to match /cache\Z/ }
    specify { expect(subject.cache_root.to_s).to match /\A#{described_class.root}/ }
  end

  context '.build_root' do
    specify { expect(subject.build_root.to_s).to match /builds\Z/ }
    specify { expect(subject.build_root.to_s).to match /\A#{described_class.root}/ }
  end

end
