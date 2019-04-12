class Debts.Routers.PartialPayPeriods extends Backbone.Router

	routes:
		"monthly_debts/:monthly_debts_id/partial_pay_periods/new": 'newEdit',
		"monthly_debts/:monthly_debts_id/partial_pay_periods/:partial_pay_period_id/edit": 'newEdit'
		
	newEdit: ->
		view = new Debts.Views.PartialPayPeriodsNewEdit()
    