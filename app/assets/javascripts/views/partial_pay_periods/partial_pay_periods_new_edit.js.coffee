class Debts.Views.PartialPayPeriodsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
            
        $('#pay_period_amount').focus( ->
            this.value = ''
        )
        
        amount = parseFloat($('.month-picker:first').data('amount'))
        $('#pay_period_amount').on('input', ->
            if parseFloat(this.value) > amount
                $(this).parent().addClass('has-error')
                $('#higher-amount-error').removeClass('hidden')
                $('input[type="submit"]').attr('disabled', 'disabled')
            else
                $(this).parent().removeClass('has-error')
                $('#higher-amount-error').addClass('hidden')
                $('input[type="submit"]').removeAttr('disabled')
        )
        
        $('.month-picker:first').addClass('selected')
        
        $('#pay_period_paid_at').datetimepicker(
            format: 'DD/MM/Y'
        )
        
        