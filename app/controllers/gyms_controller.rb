class GymsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_responce
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        gyms = Gym.all 
        render json: gyms
    end

    def show
        gym = find_gym
        render json: gym, status: :ok
    end
    
    def destroy
        find_gym.destroy
        head :no_content
    end

private
def find_gym
    Gym.find(params[:id])
end

def gym_params
    params.permit(:name, :address)
end

    def render_record_not_found_responce
        render json: { error: 'Gym not found' }, status: :not_found
    end


    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
