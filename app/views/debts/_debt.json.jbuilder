json.extract! debt, :id, :amount, :balance, :registered_at, :expired_at, :comment, :grace_months, :is_billable, :item_headquarter_id, :user_id, :agreement_payment_id, :state, :created_at, :updated_at
json.url debt_url(debt, format: :json)
