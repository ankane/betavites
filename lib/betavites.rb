require "betavites/commands"
require "betavites/config"
require "betavites/remote"
require "betavites/railtie" if defined?(Rails::Railtie)

module Betavites

  HOST = "http://betavites.heroku.com"
  VERSION = 1
  CONFIG_PATH = "config/betavites.yml"

  class << self

    def add_user(args)
      code, message = Remote.send("api/add_user", args)
    end

    def validate_code(code)
      code, message = Remote.send("api/validate_code", {:code => code})
    end

    def redeem_code(code)
      code, message = Remote.send("api/redeem_code", {:code => code})
    end

    def invite_friend(email, inviter_id=nil)
      code, message = Remote.send("api/invite_friend", {:email => email, :inviter_id => inviter_id})
    end

  end
end
