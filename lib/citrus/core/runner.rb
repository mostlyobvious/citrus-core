require 'posix/spawn'

module Citrus
  module Core
    class Runner

      def run(configuration, workspace)
        options = { :chdir => workspace.path.to_s, :out => "/dev/null", :err => "/dev/null" }
        Process.wait(POSIX::Spawn.spawn(configuration.build_script, options))
        $?.success?
      end

    end
  end
end
