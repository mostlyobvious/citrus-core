module Citrus
  module Core
    class ConfigurationValidator

      def validate(configuration)
        Configuration === configuration &&
        configuration.build_script &&
        !configuration.build_script.empty?
      end

    end
  end
end
