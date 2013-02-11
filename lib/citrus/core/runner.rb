module Citrus
  module Core
    class Runner

      def run(build, configuration, workspace)
        unless configuration.build_script
          build.abort
        else
          pid = Process.spawn(configuration.build_script, :chdir => workspace.path, :out => "/dev/null", :err => "/dev/null")
          Process.wait(pid)
          $?.success? ? build.succeed : build.fail
        end
        return build
      end

    end
  end
end
