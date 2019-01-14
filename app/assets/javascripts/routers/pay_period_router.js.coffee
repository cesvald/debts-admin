class Debts.Routers.PayPeriods extends Backbone.Router

	routes:
		"monthly_debts/:monthly_debts_id/pay_periods/new": 'newEdit',
		"monthly_debts/:monthly_debts_id/pay_periods/:pay_period_id/edit": 'newEdit'
		
	newEdit: ->
		view = new Debts.Views.PayPeriodsNewEdit()
    