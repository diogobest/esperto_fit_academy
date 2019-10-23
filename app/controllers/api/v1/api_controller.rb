class Api::V1::ApiController < ActionController::API 
  #skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session
  before_action :valid?
  before_action :authenticate_employee!
  respond_to :json

  private

  def valid?
    request.headers['Authorization'].present?

  end
  
end