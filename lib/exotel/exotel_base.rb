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
      params.inject({}){ |h, (key, value)| h[key.to_s.capitalize.to_sym] = value; h }
    end
    
    def auth
      {:username => Exotel.exotel_sid, :password => Exotel.exotel_token}
    end
  end
end  



