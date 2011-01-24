require "net/http"
require "net/https"
require "json"

module Betavites
  class Remote
    class << self

      def send(path, data)
        uri = URI.parse("#{HOST}/#{path}")
        query = "api_key=#{Config.api_key}&version=#{VERSION}"

        begin
          post = Net::HTTP::Post.new("#{uri.path}?#{query}")
          post.set_form_data(data)

          req = Net::HTTP.new(uri.host, uri.port)
          req.use_ssl = true
          req.verify_mode = OpenSSL::SSL::VERIFY_NONE

          res = req.start do |http|
            http.read_timeout = 2
            http.request(post)
          end
          res_data = JSON.parse(res.body)
          return res_data["code"], res_data["message"]
        rescue
          return 500, "Internal server error"
        end
      end

    end
  end
end
