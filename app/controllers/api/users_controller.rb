class Api::UsersController < Api::BaseController

    private
    
    def user_params
        params.require(:user).permit(:name, :surname, :email, :level_id, :level_two_id, :lesson_id, :group_id, :initiation_id, :outside, :group_outside_id, :status, :password)
    end
end