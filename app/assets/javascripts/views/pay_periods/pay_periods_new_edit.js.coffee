class Debts.Views.PayPeriodsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('#pay_period_paid_at').datetimepicker(
            format: 'DD/MM/Y'
        )
        
        $('#pay_period_months').on('change', ->
            $('#total_amount').val($(this).val() * $('#pay_period_amount').val())
        )