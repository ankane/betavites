require "yaml"

module Betavites
  class Config
    class << self

      def load(config_file)
        begin
          config = YAML::load_file(config_file)
          env_config = config[app_env] || {}
          @api_key = env_config["api-key"] || config["api-key"]
        rescue Exception => e
          raise "Configuration error: #{e.message}"
        end
      end

      def api_key
        @api_key unless @api_key.nil?
      end

      def app_env
        ENV["RACK_ENV"] || ENV["RAILS_ENV"]|| "development"
      end

    end
  end
end
