window.Debts =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	initialize: ->
		if typeof $('.flash').css('display') != 'undefined' and $('.flash').css('display') != 'none'
			setTimeout( ->
        $('.flash').slideUp()
      , 5000)
		
		controller = $('body').data('controller')
		new Debts.Routers.MDebts() if controller == "debts"
		new Debts.Routers.Payments() if controller == "payments"
		new Debts.Routers.AgreementPayments() if controller == "agreement_payments"
		new Debts.Routers.DebtPeriods() if controller == "debt_periods"
		new Debts.Routers.PayPeriods() if controller == "pay_periods"
		new Debts.Routers.Users() if controller == "users"
		
		Backbone.history.stop()
		Backbone.history.start( pushState: true )

ready = ->
	Debts.initialize()

$(document).ready ->
	ready()

$(document).on('page:load', ready)

