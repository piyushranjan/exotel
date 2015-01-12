module Exotel
  class CustomerWhitelist < ExotelBase
    
    def initialize; end
    
    def self.whitelist(params={})
      self.new.send(params)
    end
    
    def whitelist(params={})
      if valid?(params)
        params[:number] = [params[:number]] unless params[:number].is_a? Array
        params = transfrom_params(params)
        response = self.class.post("/#{Exotel.exotel_sid}/CustomerWhitelist/",  {:body => params, :basic_auth => auth })
        handle_response(response)
      end  
    end
    
    protected
    
    def valid?(params)
      unless [:virtual_number, :number].all?{|key| params.keys.include?(key)}
        raise Exotel::ParamsError, "Missing one or many required parameters." 
      else
        true  
      end 
    end
    
    def handle_response(response)
      case response.code.to_i
      when 200...300 then Exotel::Response.new(response)
      when 401 then raise Exotel::AuthenticationError, "#{response.body} Verify your sid and token." 
      else
        raise Exotel::UnexpectedError, response.body
      end
    end
  end
end