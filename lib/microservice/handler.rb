  
# frozen_string_literal: true

require 'microservice/pb/microservice_services_pb'

module MicroService
  class Handler < MicroService::Pb::MicroService::Service
    def ping(request, _call)
      text = request.echo_text
      echo_response = MicroService::Pb::EchoResponse.new
      echo_response.echo_text = text + ' from MicroService'
      echo_response
    end
  end
end
