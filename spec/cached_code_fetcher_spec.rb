require 'spec_helper'

describe Citrus::Core::CachedCodeFetcher do

  subject { described_class.new(cache_root, vcs_adapter) }

  let(:destination)     { fake(:pathname) }
  let(:vcs_adapter)     { fake(:git_adapter) }
  let(:changeset)       { fake(:changeset, head: head_commit_sha, repository_url: repository_url) }
  let(:repository_url)  { 'git://github.com/pawelpacana/citrus-core.git' }
  let(:head_commit_sha) { 'deadbeef' }

  context '#fetch' do
    include FakeFS::SpecHelpers

    context 'with empty cache' do
      let(:cache_root) { fake(:pathname) }
      let(:cache_dir)  { fake(:pathname) }

      before do
        stub(cache_root).join(any_args) { cache_dir }
        stub(cache_dir).exist?          { false }
        subject.fetch(changeset, destination)
      end

      it 'should clone repository to cache dir' do
        expect(vcs_adapter).to have_received.clone_repository(repository_url, cache_dir)
      end

      it 'should clone updated cache to destination' do
        expect(vcs_adapter).to have_received.clone_repository(cache_dir, destination)
      end
    end

    context 'with repository clone in cache' do
      let(:cache_root) { fake(:pathname) }
      let(:cache_dir)  { fake(:pathname) }

      before do
        stub(cache_root).join(any_args) { cache_dir }
        stub(cache_dir).exist?          { true }
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
      let(:cache_root) { Pathname.new('/cache_root') }

      before { subject.fetch(changeset, destination) }

      it 'should create cache dir for repository' do
        expect(cache_root.children).to have(1).element
      end

      it 'should checkout head commit from changeset' do
        expect(vcs_adapter).to have_received.checkout(destination, head_commit_sha)
      end
    end

  end
end
