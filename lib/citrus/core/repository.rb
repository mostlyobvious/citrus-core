module Citrus
  module Core
    class Repository

      attr_reader :url

      def initialize(url)
        @url = url
      end

    end
  end
end
