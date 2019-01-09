class Debts.Views.DebtPeriodsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('#debt_period_started_at').datetimepicker(
            format: 'DD/MM/Y'
        )