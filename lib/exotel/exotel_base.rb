# -*- encoding: utf-8 -*-
require 'httparty'
module Exotel
  class ExotelBase
    include HTTParty
    base_uri "https://twilix.exotel.in/v1/Accounts"
    
    def initialize; end

    protected
    
    def transfrom_params(params)
      #Keys are converted to camelcase
      params.inject({}){ |h, (key, value)| h[camelcase_key(key)] = value; h }
    end

    def camelcase_key(key)
      key.to_s.split('_').map(&:capitalize).join.to_sym #Input: call_type, Output: :CallType
    end
    
    def auth
      {:username => Exotel.exotel_sid, :password => Exotel.exotel_token}
    end

  end
end  



