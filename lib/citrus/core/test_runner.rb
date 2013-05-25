module Citrus
  module Core
    class TestRunner

      def start(configuration, path)
        process = ChildProcess.build(configuration.build_script)
        process.cwd = path.to_s
        process.start
        return TestResult.new(process)
      end

    end
  end
end
