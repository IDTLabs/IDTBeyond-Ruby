require "spec_helper"
require "webmock"
describe 'IDTBeyond - IMTU' do
  before(:each) do
    @idtbeyond = IDTBeyond::Service::IATU.new 'app-id', 'app-key', 'test term id'

  end
  describe 'get_app_id' do
    it 'returns the app id that was passed in during instantiation ' do
      expect(@idtbeyond.get_app_id).to eq('app-id')
    end
  end
  describe 'get_app_key' do
    it 'returns the app key that was passed in during instantiation ' do
      expect(@idtbeyond.get_app_key).to eq('app-key')
    end
  end
  describe 'get_status' do
    it 'should call the /v1/status' do
      stub_request(:get, "https://api.idtbeyond.com/v1/status").
          with(:headers => {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v0.9.1',
            'X-Idt-Beyond-App-Id'=>'app-id',
            'X-Idt-Beyond-App-Key'=>'app-key'}).
          to_return(:status => 200, :body => "{\"alive\":true}", :headers => {})
      response = @idtbeyond.get_status
      expect(response['alive']).to eq(true)
    end
  end
  describe 'post_topup' do
    it 'should call the /v1/iatu/topups' do
      stub_request(:post, "https://api.idtbeyond.com/v1/iatu/topups").
          with(
            :body => {
              "amount"=>"amount",
              "carrier_code"=>"carrier-code",
              "client_transaction_id"=>/app-id-\d+/,
              "country_code"=>"country-code",
              "mobile_number"=>"phone-number",
              "plan"=>"Production",
              "terminal_id"=>"test term id"},
            :headers => {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type'=>'application/x-www-form-urlencoded',
              'User-Agent'=>'Faraday v0.9.1',
              'X-Idt-Beyond-App-Id'=>'app-id',
              'X-Idt-Beyond-App-Key'=>'app-key'}).
          to_return(:status => 200, :body => "{\"success\":true}", :headers => {})
      response = @idtbeyond.post_topup "amount", "carrier-code", "country-code", "phone-number"
      expect(response['success']).to eq(true)
    end
  end
  describe 'reverse_topup' do
    it 'should call the /v1/iatu/topups/reverse' do
      stub_request(:post, "https://api.idtbeyond.com/v1/iatu/topups/reverse").
          with(
            :body => {
              "client_transaction_id"=>"client-transaction-id",
              "to_service_number"=>"to-service-number"},
            :headers => {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type'=>'application/x-www-form-urlencoded',
              'User-Agent'=>'Faraday v0.9.1',
              'X-Idt-Beyond-App-Id'=>'app-id',
              'X-Idt-Beyond-App-Key'=>'app-key'}).
          to_return(:status => 200, :body => "{\"success\":true}", :headers => {})
      response = @idtbeyond.reverse_topup "client-transaction-id", "to-service-number"
      expect(response['success']).to eq(true)
    end
  end
end