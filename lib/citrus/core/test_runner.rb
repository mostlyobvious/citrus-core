require 'stringio'

module Citrus
  module Core
    class TestRunner
      CHUNK_SIZE = 8192

      include Publisher

      def start(build, configuration, path)
        process = ChildProcess.build(configuration.build_script)
        process.cwd = path.to_s
        r, w = IO.pipe
        process.io.stdout = process.io.stderr = w
        process.start
        w.close
        output = StringIO.new
        begin
          loop do
            chunk = r.readpartial(CHUNK_SIZE)
            output.write(chunk)
            publish(:build_output_received, build, chunk)
          end
        rescue EOFError
        end
        process.wait
        TestResult.new(process.exit_code, output)
      end

    end
  end
end
