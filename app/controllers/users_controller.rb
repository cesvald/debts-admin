class UsersController < ApplicationController
    inherit_resources
  before_action :set_user, only: [:show, :edit, :update, :destroy, :detail_debts, :debts]
  
  # GET /users
  # GET /users.json
  def index
        
        @status = (params[:by_status].present? and params[:by_status] == 'inactive' ? 'Inactivos' : 'Activos')
        
        if current_user.admin?
            @users = end_of_association_chain.includes(:level, :lesson).order(:name)
            @groups = Group.where( headquarter_id: (params.has_key?(:by_headquarter_id) ? params[:by_headquarter_id] : nil)).onsite
        elsif current_user.coor?
            params[:by_headquarter_id] = current_user.group.headquarter.id
            @users = end_of_association_chain.by_headquarter_id(current_user.group.headquarter.id).includes(:level, :lesson).order(:name)
            @groups = Group.where(headquarter: current_user.group.headquarter).onsite
        elsif current_user.acom?
            params[:by_headquarter_id] = current_user.group.headquarter.id
            @users = end_of_association_chain.by_headquarter_id(current_user.group.headquarter.id).by_group_ids(current_user.groups.map{|p| p.id }).includes(:level, :lesson).order(:name)
            @groups = current_user.groups.onsite
        end
        respond_to do |format|
            format.xlsx {
                response.headers['Content-Disposition'] = "attachment; filename=\"Reporte Iniciados #{Date.today.strftime('%d %b %Y')}.xlsx\""
            }
            format.html {
                if params[:send_email] == "1"
                    @users.not_confirmed.update_all(is_confirmed: nil)
                    @users.each do |user|
                    	password = "odkehsl" + user.id.to_s
                    	user.password = password
                    	puts "Trying to send email for User: "  + user.id.to_s
                    	UserMailer.welcome(user, password).deliver!
                    	user.is_confirmed = true
                    ./	user.save
                    	puts "User email sent and user saved as confirmed, User: "  + user.id.to_s
                    end
                end
                @users = Kaminari.paginate_array(@users).page(params[:page])
            }
        end
    end

    def detail_concept_payments
        if current_user.admin?
            @users = end_of_association_chain.includes(:level, :lesson).order(:name)
        elsif current_user.coor?
            params[:by_headquarter_id] = current_user.group.headquarter.id
            @users = end_of_association_chain.by_headquarter_id(current_user.group.headquarter.id).includes(:level, :lesson).order(:name)
        elsif current_user.acom?
            params[:by_headquarter_id] = current_user.group.headquarter.id
            @users = end_of_association_chain.by_headquarter_id(current_user.group.headquarter.id).by_group_ids(current_user.groups.map{|p| p.id }).includes(:level, :lesson).order(:name)
        end
        @users.joins :debts
        respond_to do |format|
			format.xlsx {
				response.headers['Content-Disposition'] = "attachment; filename=\" test.xlsx\""
			}
			format.html
		end
    end
    
    def detail_debts
        @debts= @user.debts
        respond_to do |format|
			format.xlsx {
				response.headers['Content-Disposition'] = "attachment; filename=\" test.xlsx\""
			}
			format.html
		end
    end
    
    def debts
        @general_debt = @user.general_debt.nil? ? GeneralDebt.create(user: @user) : @user.general_debt
        @monthly_debt = @user.monthly_debt.nil? ? MonthlyDebt.create(user: @user) : @user.monthly_debt
        session[:back_url] = debts_user_path(@user)
    end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :country_id, :lesson_id, :level_id)
    end
end
