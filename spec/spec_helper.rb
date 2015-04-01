require 'pry'
require 'idtbeyond'
require 'idtbeyond/services/imtu'
require 'webmock/rspec'
require 'webmock/rspec/matchers'
require 'webmock/rspec/matchers/request_pattern_matcher'
require 'webmock/rspec/matchers/webmock_matcher'
WebMock.disable_net_connect!(allow_localhost: true)