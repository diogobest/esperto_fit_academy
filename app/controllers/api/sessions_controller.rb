class Api::SessionsController < Devise::SessionsController
  #skip_before_action :verify_signed_out_employee
  respond_to :json  
  
  def create
    unless request.format == :json
      sign_out
      render status: 406, 
               json: { message: "JSON requests only." } and return
    end    
    
    resource = warden.authenticate!(auth_options)    
    if resource.blank?
      render status: 401, 
               json: { response: "Access denied." } and return
    end    
    
    sign_in(resource_name, resource)
    respond_with resource, location:
      after_sign_in_path_for(resource) do |format|
        format.json { render json: 
                        { success: true,
                              jwt: current_token,
                         response: "Authentication successful"
                         }
                     }
    end
  end  

  def destroy
    super and return if params['Authorization'].blank?
    user = ApiEmployee.find_by_jti(decode_token)
    super and return if employee.blank?
    revoke_token(employee)
    super
  end
  
  private 
  
  def decode_token
    token = params['Authorization'].split('Bearer ').last
    secret = ENV['DEVISE_JWT_SECRET_KEY']
    JWT.decode(token, secret, true, algorithm: 'HS256',
               verify_jti: true)[0]['jti']
  end  
  
  def revoke_token(employee)
    employee.update_column(:jti, generate_jti)
  end  
  
  def current_token
    request.env['warden-jwt_auth.token']
  end  
  
  def generate_jti
    SecureRandom.uuid
  end
end