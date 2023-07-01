class ClientsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_client_not_found
    def index
        clients = Client.all
        render json: clients
    end

    def show 
        client = find_client
        render json: client, status: :ok
    end

    private
def find_client
    Client.find(params[:id])
end

def render_record_not_found_responce
    render json: { error: 'Gym not found' }, status: :not_found
end


def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
end
end
