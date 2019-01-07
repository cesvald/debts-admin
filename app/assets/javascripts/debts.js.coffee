window.Debts =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
  	controller = $('body').data('controller')
  	new Debts.Routers.MDebts() if controller == "debts"
  	new Debts.Routers.Payments() if controller == "payments"
  	new Debts.Routers.AgreementPayments() if controller == "agreement_payments"
  	Backbone.history.stop()
  	Backbone.history.start( pushState: true )

ready = ->
	Debts.initialize()

$(document).ready ->
  ready()

$(document).on('page:load', ready)

