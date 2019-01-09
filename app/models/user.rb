class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	# :registerable
	devise :database_authenticatable, 
				 :recoverable, :trackable, :validatable, :registerable, :timeoutable

	has_many :roles, dependent: :delete_all
	has_many :profiles, through: :roles
	has_many :coor_groups, class_name: "Group", foreign_key: "user_id"
	## Pertenece a un grupo ##
	belongs_to :group
	belongs_to :group_outside, class_name: "Group", foreign_key: 'group_outside_id'
	## Acompañante de grupos ##
	has_many :groups
	has_many :suspensions
	
	belongs_to :level
	belongs_to :level_two, class_name: "Level", foreign_key: 'level_two_id'
	has_and_belongs_to_many :pending_levels, class_name: "Level", foreign_key: "id", dependent: :destroy
	belongs_to :lesson
	
	has_one :swami
	belongs_to :initiation
	
	has_one :general_debt
	has_one :monthly_debt
	
	
	enum status: [:active, :inactive]
	
	validates_presence_of :lesson, :level, :group
	
	scope :by_name, ->(name) { where("lower(users.name) LIKE ?", "%#{name.downcase}%") }
	scope :by_surname, ->(surname) { where("lower(users.surname) LIKE ?", "%#{surname.downcase}%") }
	scope :by_group_id, -> (id) { where("users.group_id = ?", id) }
	scope :by_level_id, -> (id) { where("users.level_id = ?", id) }
	scope :by_level_two_id, -> (id) { where("users.level_two_id = ?", id) }
	scope :by_pending_level_id, -> (id) { joins(:pending_levels).where("levels_users.level_id = ?", id) }
	scope :by_lesson_id, -> (id) { where("users.lesson_id = ?", id) }
	scope :by_email, -> (email) { where("lower(users.email) LIKE ?", "%#{email.downcase}%") }
	scope :by_headquarter_id, -> (id) { joins(:group).where("groups.headquarter_id = ?", id) }
	scope :by_group_ids, -> (group_ids) { where("group_id IN (:group_ids) OR group_outside_id IN (:group_ids)", group_ids: group_ids) }
	scope :by_outside, -> (outside) { outside == "1" ? where("users.group_outside_id IS NOT NULL") : where("users.group_outside_id IS NULL")}
	scope :not_confirmed, -> { where(is_confirmed: false) }
	scope :by_status, -> (status) { where("status = ?", User.statuses[status]) }
	
	delegate :display_coor_groups, :display_pending_levels, to: :decorator
	
	def decorator
		@decorator ||= UserDecorator.new(self)
	end
	
	[:acom, :coor, :admin, :maint, :swami, :guru].each do |name|
		define_method "#{name}?" do
			if name == :admin
				return !profiles.where(name: name).empty?
			else
				return !profiles.where(name: name).empty? || admin?
			end
		end
	end
	
	def as_json(options={})
		result = super({ :except => :password }.merge(options))
		result["password"] = 'sbabaji7'
		result
	end

	def only_user?
		profiles.empty?
	end
	
	def full_name
		name + " " + (surname.nil? ? "" : surname)
	end
	
	def full_name_truncated
		(name + " " + (surname.nil? ? "" : surname))[/(\s*\S+){2}/]
	end
	
	def to_s
		"#{full_name} (#{email})"
	end
	
	def outside?
		not group_outside.nil?
	end
	
	def acom_outside?
		coor? || admin? || groups.outside.exists?
	end
	
	 #( SELECT SUM(P.VALUE)  AS  PAYMENT FROM PAYMENTS P WHERE D.ID=P.PAYABLE_ID AND  P.PAYABLE_TYPE='Debt')
	def total_debts_by_currency
		@user_id=id
	 	@query="SELECT DC.CURRENCY AS CURRENCY,SUM(DC.DEBT) AS DEBT, SUM(DC.PAYMENTS) AS PAYMENT, SUM(DC.DISCOUNTS) AS DISCOUNT, 
	 	         (SUM(DC.DEBT) - COALESCE(SUM(DC.PAYMENTS),0)   - COALESCE (SUM(DC.DISCOUNTS),0) ) AS BALANCE
				 FROM ( 
				  SELECT H.CURRENCY AS CURRENCY,DEBTS.VALUE AS DEBT,
				  (SELECT SUM(PAYMENTS.VALUE) FROM PAYMENTS  WHERE DEBTS.ID=PAYABLE_ID  AND PAYABLE_TYPE='Debt') AS PAYMENTS,
				  (SELECT SUM(DISCOUNTS.VALUE) FROM DISCOUNTS  WHERE DEBTS.ID=DISCOUNTABLE_ID  AND DISCOUNTABLE_TYPE='Debt') AS DISCOUNTS
		          FROM HEADQUARTERS H, ITEM_HEADQUARTERS IH, DEBTS
		          WHERE IH.HEADQUARTER_ID=H.ID AND DEBTS.ITEM_HEADQUARTER_ID=IH.ID AND DEBTS.USER_ID=#{@user_id}  
				  ) DC				  
		          GROUP BY DC.CURRENCY;"
		          
		results = ActiveRecord::Base.connection.execute(@query)
		return results
	end
	
	def due
		monthly_debt.due + general_debt.due
	end
end