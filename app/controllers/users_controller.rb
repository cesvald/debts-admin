require 'csv'
class UsersController < ApplicationController
	inherit_resources
	before_action :set_user, only: [:show, :edit, :update, :destroy, :detail_debts, :debts]
	
	has_scope :by_status, :by_name, :by_surname, :by_level_id, :by_level_two_id, :by_lesson_id, :by_email, :by_group_id, :by_headquarter_id, :by_outside, :by_pending_level_id
	
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
			@debt_period = @monthly_debt.debt_periods.last
			unless @debt_period
				last_pay_period = @monthly_debt.pay_periods.last
				@debt_period = @user.monthly_debt.debt_periods.create(started_at: Date.today, finished_at: Date.today, amount: last_pay_period.all_amount) if last_pay_period.finished_at < Date.today.beginning_of_month
			end
			@partial_payment_is_active = (@debt_period and @debt_period.is_partial)
			@opened_agreement = @user.agreement_payments.opened.first
			session[:back_url] = debts_user_path(@user)
	end
	
	def import_general_debts
		excel = params[:file]
    puts 'INICIO ------------------------:   '
    
    row_headers = nil
    
    CSV.foreach(excel.path, :col_sep => ',', encoding:'iso-8859-1:utf-8') do |row|
      puts "---------------------------------------"
      puts row[0]
      if row[0] == "Email"
        row_headers = row
        index = 1
        while row[index] != "end" do
          if Item.where('name ILIKE :name', {name: "#{row_headers[index]}"}).first.nil?
            @errors = "#{row_headers[index]} no existe como concepto"
            render :import_new
            return false
          end
          index += 1
        end
      else
        index = 1
        user = User.where(email: row[0]).first
        general_debt = user.general_debt.nil? ? user.create_general_debt() : user.general_debt
        while row[index] != "end" do
          if !row[index].blank? and row[index] != "0"
            @debt = Debt.new()
            @debt.amount = row[index]
            @debt.registered_at = "15/05/#{row_headers[index].split(" ").last}".to_date
            @debt.item = Item.where('name ILIKE :name', {name: "#{row_headers[index]}"}).first
            @debt.debable = general_debt
            @debt.save!
          end
          index += 1
        end
        puts row[0] + " END SUCCESS"
      end
    end
    puts "END ALL"
  end
	
	def import_new
		
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
