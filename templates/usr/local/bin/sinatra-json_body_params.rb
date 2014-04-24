require 'sinatra/base'
require 'multi_json'

module Sinatra
  module JsonBodyParams
    
    def self.registered(app)
      app.before do
        params.merge! json_body_params
      end
      
      app.helpers do
        def json_body_params
          @json_body_params ||= begin
            MultiJson.load(request.body.read.to_s, symbolize_keys: true)
          rescue MultiJson::LoadError
            {}
          end
        end
      end
    end
    
  end  
end
