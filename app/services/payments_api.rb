require 'faraday'
require 'faraday_middleware'

class PaymentsApi 
  class << self
    def endpoint
      Rails.configuration.esperto_fit_payment[:payment_url]
    end

    def api_version
      'v1'
    end

    def payments_url
      "#{endpoint}/api/#{api_version}"
    end

    def client
      @client ||= new_connection
    end

    private

    def new_connection
      Faraday.new(url: payments_url) do |faraday|
        faraday.use :instrumentation
        faraday.headers['Content-Type'] = 'application/json'

        faraday.response :json, parser_options: { symbolize_names: true },
                                content_type: /\bjson$/
        faraday.adapter :net_http
      end
    end
  end
end