class Debts.Views.DebtsNewEdit extends Backbone.View

	el: 'body'
		
	initialize: ->
		$('#debt_registered_at').datetimepicker(
			format: 'DD/MM/Y'
		)
		
		if $('#debt_item_id').data('debt_item_id') isnt null && $('#debt_item_id').data('debt_item_id') isnt ''
			item = $('#debt_item_id').data('item')
			$('#token-input-debt_item_id').val(item.name)
			$('#token-input-debt_item_id').attr('readonly', 'readonly')
			$('#token-input-debt_item_id').addClass('token-occupied')
			$('#debt_item_id').val(item.id)