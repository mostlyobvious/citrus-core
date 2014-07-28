require 'childprocess'
ChildProcess.posix_spawn = true

module Citrus
  module Core
    class TestRunner
      CHUNK_SIZE = 8192

      include Publisher

      def start(build, configuration, path)
        require 'bundler'
        Bundler.with_clean_env { _start(build, configuration, path) }
      end

      def _start(build, configuration, path)
        output  = build.output
        process = ChildProcess.build('/bin/sh', '-c', configuration.build_script)
        process.cwd = path.to_s
        r, w = IO.pipe
        process.io.stdout = process.io.stderr = w
        process.start
        w.close
        begin
          loop do
            chunk = r.readpartial(CHUNK_SIZE)
            output.write(chunk)
            publish(:build_output_received, build, chunk)
          end
        rescue EOFError
        end
        process.wait
        ExitCode.new(process.exit_code)
      end

    end
  end
end
