require "faraday"
require "json"

module IDTBeyond
  class Service
    class IATU
      # Constructor
      def initialize(app_id = nil, app_key = nil, term_id = nil)
        raise "app_id, app_key and term_id are required" if app_key.nil? || app_id.nil? || term_id.nil?
        @app_id = app_id
        @app_key = app_key
        @term_id = term_id
        @url = ENV["IDTBEYOND_API_URL"] || "https://api.idtbeyond.com"
        @plan_type = ENV["IDTBEYOND_PLAN_TYPE"] || "Production"
        @conn = Faraday.new(:url => @url, :headers => {
          "x-idt-beyond-app-id" => @app_id,
          "x-idt-beyond-app-key" => @app_key
        }) do |faraday|
          faraday.request :url_encoded
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
        end
      end

      # API Methods

      def client_transaction_id_search(client_transaction_id, date_from, date_to)
        response = @conn.post "/v1/iatu/topups/reports", {
        :client_transaction_id => client_transaction_id,
        :type_of_report => "client_transaction_id",
        :date_from => date_from,
        :date_to => date_to
        }
        JSON response.body
      end
      def get_all_charges(date_from, date_to)
        response = @conn.get "/v1/iatu/charges/reports/all", {:date_from => date_from, :date_to => date_to}
        return JSON response.body if response.status == 200
        false
      end
      def get_all_topups(date_from, date_to)
        response = @conn.get "/v1/iatu/topups/reports/all", {:date_from => date_from, :date_to => date_to}
        return JSON response.body if response.status == 200
        false
      end
      def get_all_topups_totals(date_from, date_to)
        response = @conn.get "/v1/iatu/topups/reports/totals", {:date_from => date_from, :date_to => date_to}
        return JSON response.body if response.status == 200
        false
      end
      def get_app_id
        @app_id
      end

      def get_app_key
        @app_key
      end
      def get_balance
        response = @conn.get "/v1/iatu/balance"
        return JSON response.body if response.status == 200
        false
      end
      def get_local_value(amount, carrier_code, country_code, currency_code)
        response = @conn.get "/v1/iatu/products/reports/local-value", {
        :carrier_code => carrier_code,
        :country_code => country_code,
        :currency_code => currency_code,
        :amount => amount
        }
        JSON response.body
      end

      def get_status
        response = @conn.get "/v1/status"
        p response
        return JSON response.body if response.status == 200
        false
      end

      def post_topup(amount, carrier_code, country_code, mobile_number )
        client_transaction_id = @app_id + "-" + "%06d" % Random.rand(0..999999)
        response = @conn.post "/v1/iatu/topups", {
        :country_code => country_code,
        :carrier_code => carrier_code,
        :client_transaction_id => client_transaction_id,
        :terminal_id => @term_id,
        :mobile_number => mobile_number,
        :plan => @plan_type,
        :amount => amount
        }
        JSON response.body
      end
      def reverse_topup(client_transaction_id, to_service_number)
        response = @conn.post "/v1/iatu/topups/reverse", {
                                                           :client_transaction_id => client_transaction_id,
                                                           :to_service_number => to_service_number
                                                       }
        JSON response.body
      end
      def to_service_number_search(to_service_number)
        response = @conn.post "/v1/iatu/topups/reports", {
        :to_service_number => to_service_number,
        :type_of_report => "to_service_number"
        }
        JSON response.body
      end
      def validate_number(country_code, mobile_number)
        response = @conn.get "/v1/iatu/number-validator", {
                                                            :country_code => country_code, :mobile_number => mobile_number}
        JSON response.body
      end
    end
  end
end