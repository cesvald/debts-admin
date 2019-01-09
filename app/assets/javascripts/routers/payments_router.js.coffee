class Debts.Routers.Payments extends Backbone.Router

	routes:
		"general_debts/:general_debts_id/payments/new": 'newEdit'
		"general_debts/:general_debts_id/payments/edit": 'newEdit'
		"agreement_payments/:agreement_payment_id/payments/new": 'newEdit'
		"agreement_payments/:agreement_payment_id/payments/:payment_id/edit": 'newEdit'
		"monthly_debts/:monthly_debts_id/payments/new": 'newEdit'
		"monthly_debts/:monthly_debts_id/payments/edit": 'newEdit'
		
	newEdit: ->
		view = new Debts.Views.PaymentsNewEdit()