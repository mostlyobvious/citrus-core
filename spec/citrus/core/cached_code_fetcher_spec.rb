require 'spec_helper'
require 'tmpdir'

class Digester
  def hexdigest(input); input; end
end

describe Citrus::Core::CachedCodeFetcher do

  subject { described_class.new(cache_root, vcs_adapter, digester) }

  let(:destination)     { '/destination' }
  let(:vcs_adapter)     { fake(:git_adapter) }
  let(:digester)        { fake(:digester, hexdigest: 'dummy') }
  let(:changeset)       { fake(:changeset, head: head_commit_sha, repository_url: repository_url) }
  let(:repository_url)  { 'git://github.com/pawelpacana/citrus-core.git' }
  let(:head_commit_sha) { 'deadbeef' }
  let(:cache_root)      { Dir.mktmpdir('cache_root') }
  let(:cache_dir)       { File.join(cache_root, 'dummy') }

  context '#fetch' do
    context 'with empty cache' do

      before do
        subject.fetch(changeset, destination)
      end

      it 'should create cache dir' do
        expect(File.exist?(cache_dir)).to be_true
      end

      it 'should clone repository to cache dir' do
        expect(vcs_adapter).to have_received.clone_repository(repository_url, cache_dir)
      end

      it 'should clone updated cache to destination' do
        mock(digester).hexdigest(repository_url) { cache_dir }
        expect(vcs_adapter).to have_received.clone_repository(cache_dir, destination)
      end
    end

    context 'with repository clone in cache' do
      before do
        FileUtils.mkpath(File.join(cache_dir, 'some_file'))
        subject.fetch(changeset, destination)
      end

      it 'should fetch repository remote' do
        expect(vcs_adapter).to have_received.fetch_remote(cache_dir)
      end

      it 'should reset repository' do
        expect(vcs_adapter).to have_received.reset(cache_dir)
      end
    end

    context do
      before { subject.fetch(changeset, destination) }

      it 'should create cache dir for repository' do
        expect(Pathname.new(cache_root).children).to have(1).element
      end

      it 'should checkout head commit from changeset' do
        expect(vcs_adapter).to have_received.checkout(destination, head_commit_sha)
      end
    end

  end
end
