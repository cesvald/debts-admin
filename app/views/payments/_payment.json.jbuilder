json.extract! payment, :id, :amount, :balance, :paid_at, :comment, :payment_type, :payment_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
