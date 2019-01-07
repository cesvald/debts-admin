class Debts.Routers.AgreementPayments extends Backbone.Router

	routes:
		"general_debts/:general_debt_id/agreement_payments/new": 'newEdit'
		"general_debts/:general_debt_id/agreement_payments/:agreement_payment_id/edit": 'newEdit'
		
	newEdit: ->
		view = new Debts.Views.AgreementPaymentsNewEdit()