class Debts.Routers.AgreementPayments extends Backbone.Router

	routes:
		"users/:user_id/agreement_payments/new": 'newEdit'
		"users/:user_id/agreement_payments/:agreement_payment_id/edit": 'newEdit'
		
	newEdit: ->
		view = new Debts.Views.AgreementPaymentsNewEdit()