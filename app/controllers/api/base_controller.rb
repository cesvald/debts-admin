class Api::BaseController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    inherit_resources
    respond_to :json
    
    before_action :check_auth_token
    
    def check_auth_token
        values = params[:public_key].split(//).map {|ch| (ch.ord - 'A'.ord + 10) * ::Configuration[:token_code].to_i}
        if params[:access_token].to_i != values.inject(0){|sum,x| sum + x }
            p "Ok, no coinsidence"
            render json: {
              error: "auth_token invalid",
              status: 401
            }, status: 401
        end
    end
end