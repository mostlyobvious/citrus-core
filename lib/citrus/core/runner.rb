module Citrus
  module Core
    class Runner

      def run(configuration, workspace)
        options = { :chdir => workspace.path, :out => "/dev/null", :err => "/dev/null" }
        Process.wait(Process.spawn(configuration.build_script, options))
        $?.success?
      end

    end
  end
end
