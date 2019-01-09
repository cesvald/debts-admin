class Api::InitiationssController < Api::BaseController
   private
    
    def initiation_params
        params.require(:initiation).permit(:id, :started_at, :created_at, :updated_at)
    end 
end