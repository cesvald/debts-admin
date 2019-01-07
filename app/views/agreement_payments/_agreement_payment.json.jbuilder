json.extract! agreement_payment, :id, :started_at, :number_quotas, :canceled, :amount_debt, :comment, :expired_at, :amount, :created_at, :updated_at
json.url agreement_payment_url(agreement_payment, format: :json)
