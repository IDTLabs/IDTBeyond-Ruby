require "idtbeyond/version"
require "faraday"
require "json"

module IDTBeyond
  class Service
    class IATU
      def initialize(app_id = nil, app_key = nil, term_id = nil)
        raise "app_id, app_key and term_id are required" if app_key.nil? || app_id.nil? || term_id.nil?
        @app_id = app_id
        @app_key = app_key
        @term_id = term_id
        @url = ENV['IDTBEYOND_API_URL'] || 'https://api.idtbeyond.com'
        p "url: #{@url}"
        @conn = Faraday.new(:url => @url, :headers => {
            'x-idt-beyond-app-id' => @app_id,
            'x-idt-beyond-app-key' => @app_key
          }) do |faraday|
          faraday.request :url_encoded
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
        end

      end

      def get_app_id
        @app_id
      end

      def get_app_key
        @app_key
      end
      def get_status
        response = @conn.get "/v1/status"
        return JSON(response.body) if response.status == 200
        false
      end
      def get_balance
        response = @conn.get "/v1/iatu/balance"
        return JSON(response.body) if response.status == 200
        false
      end
      def get_all_topups_totals(date_from, date_to)
        response = @conn.get "/v1/iatu/topups/reports/totals", {:date_from => date_from, :date_to => date_to}
        return JSON(response.body) if response.status == 200
        false
      end
      def get_all_topups(date_from, date_to)
        response = @conn.get "/v1/iatu/topups/reports/all", {:date_from => date_from, :date_to => date_to}
        return JSON(response.body) if response.status == 200
        false
      end
      def get_all_charges(date_from, date_to)
        response = @conn.get "/v1/iatu/charges/reports/all", {:date_from => date_from, :date_to => date_to}
        return JSON(response.body) if response.status == 200
        false
      end
      def get_local_value(carrier_code, country_code, currency_code, amount)
        response = @conn.get "/v1/iatu/products/reports/local-value", {
          :carrier_code => carrier_code,
          :country_code => country_code,
          :currency_code => currency_code,
          :amount => amount
        }
        JSON(response.body)
      end
      def validate_number(country_code, phone_number)
        response = @conn.get "/v1/iatu/number-validator", {:country_code => country_code, :mobile_number => phone_number}
        JSON(response.body)
      end
    end
  end
end
