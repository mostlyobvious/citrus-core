module Citrus
  module Core
    module Publisher

      def add_subscriber(subscriber)
        subscribers << subscriber
      end

      def publish(event, *args)
        subscribers.each do |subscriber|
          subscriber.public_send(event, *args) if subscriber.respond_to?(event)
        end
      end

      protected

      def subscribers
        @subscribers ||= []
      end

    end
  end
end
