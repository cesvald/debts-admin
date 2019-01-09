class Api::HeadquartersController < Api::BaseController
   private
    
    def headquarter_params
        params.require(:headquarter).permit(:id, :name, :created_at, :updated_at, :mailchimp_group_id)
    end 
end