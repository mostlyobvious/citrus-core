require 'childprocess'
require 'shellwords'

module Citrus
  module Core
    class GitAdapter
      TIMEOUT = 10

      def clone_repository(source, destination)
        run %W(git clone #{shell_quote(source)} #{shell_quote(destination)})
      end

      def fetch_remote(destination, remote = 'origin')
        run %W(git fetch #{shell_quote(remote)}), destination
      end

      def checkout(destination, revision = nil)
        run %W(git checkout -b build #{shell_quote(revision)}), destination
      end

      def reset(destination, revision = nil)
        run %W(git reset origin --hard #{shell_quote(revision)}), destination
      end

      protected

      def run(command, directory)
        process = ChildProcess.build(command)
        process.cwd = directory.to_s
        process.start
        process.poll_for_exit(TIMEOUT)
      rescue ChildProcess::TimeoutError
        process.stop
      end

      def shell_quote(string)
        return "" unless string
        Shellwords.escape(string.to_s)
      end

    end
  end
end
