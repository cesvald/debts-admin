class Debts.Routers.MDebts extends Backbone.Router

	routes:
		"general_debts/:general_debts_id/debts/new": 'newEdit'
		"general_debts/:general_debts_id/debts/:id/edit": 'newEdit'
		
	initialize: ->
		$('.tokenizer-field').each ->
			$(this).tokenizeInput()
			
	newEdit: ->
		view = new Debts.Views.DebtsNewEdit()
	
	$.fn.tokenizeInput = ->
		tokenizeField = $(this)
		tokenizeField.tokenInput('/items.json', {
			crossDomain: false,
			propertyToSearch: ["name"]
			hintText: "Buscar por nombre"
			noResultsText: "No hay resultados"
			insertText: "No existe: Adicionar Concepto"
			insertUrl: '/items/new'
			insertParam: 'name'
			resultsLimit: 1
			uniqueSelection: true
			placeholder: $('#debt_item').attr('placeholder')
			selectionFormat: (item) ->
				return "#{item.name} #{item.formatted_value}"
			resultsFormatter: (item) ->
				return "<li><div class='token-result-wrapper'><div>" + item.name + "</div></div></li>"
		})