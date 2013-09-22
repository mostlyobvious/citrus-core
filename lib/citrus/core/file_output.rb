module Citrus
  module Core
    class FileOutput
      include Publisher

      attr_reader :name, :output_root

      def initialize(name, output_root = Citrus::Core.output_root)
        @name        = name
        @output_root = output_root
      end

      def read
        path.read
      rescue Errno::ENOENT
        ''
      end

      def write(data)
        path.open('a') { |file| file.write(data) }
        publish(:test_output_received, data)
      end

      def path
        @path ||= begin
          output_root.mkpath
          output_root.join(name)
        end
      end

    end
  end
end
