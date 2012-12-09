require 'ostruct'
require 'date'

module Citrus
  module Core
    class Commit

      attr_reader :sha, :author, :message, :timestamp, :changes, :url

      def initialize(sha, author, message, timestamp, changes, url = nil)
        @sha       = sha
        @url       = url
        @author    = author
        @message   = message
        @changes   = changes
        @timestamp = timestamp
      end

    end
  end
end
