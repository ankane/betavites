module Betavites
  class Commands
    class << self

      def run(args)

        if args[0] == "install" and api_key = args[1]

          config = <<CONFIG
# Leave api-key blank to disable Betavites.

development:
  api-key: #{api_key}

production:
  api-key: #{api_key}
CONFIG

          Dir.mkdir("config") unless File.exists?("config")
          File.open(CONFIG_PATH, "w") {|f| f.write(config) }

          puts "Created config file at #{CONFIG_PATH}"
        elsif args[0] == "test"
          begin
            Betavites::Config.load(CONFIG_PATH)
            code, message = Betavites.add_user(:email => "test@example.com")
            raise message if code != 0
            puts "Test successful! Login to http://www.betavites.com to see it."
          rescue Exception => e
            puts "Test failed:\n  #{e.message}"
          end
        else
          help =<<HELP
Usage:
  betavites install <api-key>
  betavites test
HELP
          puts help
        end

      end

    end
  end
end
