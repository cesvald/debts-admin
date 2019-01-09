class Debts.Routers.DebtPeriods extends Backbone.Router

	routes:
		"monthly_debts/:monthly_debts_id/debt_periods/new": 'newEdit',
		"monthly_debts/:monthly_debts_id/debt_periods/:debt_period_id/edit": 'newEdit'
		
	newEdit: ->
		view = new Debts.Views.DebtPeriodsNewEdit()
    