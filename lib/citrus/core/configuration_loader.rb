module Citrus
  module Core
    class ConfigurationError             < StandardError; end
    class ConfigurationFileInvalidError  < ConfigurationError; end
    class ConfigurationFileNotFoundError < ConfigurationError; end

    class ConfigurationLoader

      attr_reader :validator

      def initialize(validator = ConfigurationValidator.new)
        @validator = validator
      end

      def load_from_path(pathname)
        data   = pathname.join('.citrus/config.rb').read
        config = eval(data)
        raise ConfigurationFileInvalidError unless validator.validate(config)
        config
      rescue Errno::ENOENT
        raise ConfigurationFileNotFoundError
      end

    end
  end
end
