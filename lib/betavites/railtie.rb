require "betavites"
require "rails"

module Betavites
  class Railtie < Rails::Railtie

    initializer "betavites.middleware" do |app|
      Betavites::Config.load(File.join(Rails.root, CONFIG_PATH))
    end
  end
end
