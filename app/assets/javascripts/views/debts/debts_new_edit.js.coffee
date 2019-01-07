class Debts.Views.DebtsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('#debt_registered_at').datetimepicker(
            format: 'DD/MM/Y'
        )