require 'thread'

module Citrus
  module Core
    class BuildQueue

      attr_reader :execute_build_service, :queue, :waiting, :running

      def initialize(execute_build_service)
        @execute_build_service = execute_build_service
        @queue = Queue.new
        @waiting = []
        @running = []
      end

      def push(build)
        queue.push(build)
        waiting << build
      end

      def pop
        build = queue.pop
        running << build
        waiting.delete(build)
        build
      end

      def cleanup(build)
        running.delete(build)
      end

      def start(concurrency = 1)
        concurrency.times do
          Thread.new do
            loop do
              build = pop
              execute_build_service.start(build)
              cleanup(build)
            end
          end
        end
      end
    end
  end
end
