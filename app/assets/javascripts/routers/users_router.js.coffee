class Debts.Routers.Users extends Backbone.Router

	routes:
		"users/:user_id/debts": 'debts',
		
	debts: ->
		view = new Debts.Views.UsersDebts()
    