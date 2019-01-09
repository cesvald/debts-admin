class Api::GroupsController < Api::BaseController
    private
    
    def group_params
        params.require(:group).permit(:id, :name, :headquarter_id, :user_id, :created_at, :updated_at, :is_outside)
    end 
end