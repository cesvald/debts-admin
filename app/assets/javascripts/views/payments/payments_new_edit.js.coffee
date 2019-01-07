class Debts.Views.PaymentsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('#payment_paid_at').datetimepicker(
            format: 'DD/MM/Y'
        )