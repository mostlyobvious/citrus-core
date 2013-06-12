require 'thread'

module Citrus
  module Core
    class QueuedBuilder

      attr_reader :queue, :execute_build_service

      def initialize(execute_build_service, queue = Queue.new)
        @execute_build_service = execute_build_service
        @queue = queue
      end

      def start(concurrency = 1)
        concurrency.times do
          Thread.new do
            loop { execute_build_service.start(queue.pop) }
          end
        end
      end

    end
  end
end
