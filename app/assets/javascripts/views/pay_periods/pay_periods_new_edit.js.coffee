class Debts.Views.PayPeriodsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        
        $('.month-picker').hover( ->
            if not $(this).hasClass('selected')
                prev = $(this).prev()
                while not prev.hasClass('selected')
                    prev.addClass('hover')
                    prev = prev.prev()
                    
        , ->
            $('.month-picker.hover').removeClass('hover')
        )
        
        if $('#pay_period_paid_at').val() == ''
            $('.month-picker').addClass('active') 
        else
            $('.month-picker:last').addClass('active')
            
        $('.month-picker').click( ->
            if $(this).hasClass('active')
                $('.month-picker.active.hover').removeClass('hover')
                $('.month-picker.active.selected').removeClass('selected')
            
                prev = $(this)
                totalPayment = 0
                while prev.hasClass('month-picker')
                    prev.addClass('selected')
                    console.log(prev.data("amount"))
                    totalPayment += parseFloat(prev.data("amount"))
                    prev = prev.prev()
                
                $('#total-payment').html(totalPayment)
                $('#pay_period_finished_at').val($(this).data('date'))
        )
    
            
            
        $('#pay_period_amount').focus( ->
            this.value = ''
        )
        
        $('#pay_period_amount').on('input', ->
            $('.month-picker .picker-currency .amount').html(this.value)
            $('.month-picker.selected').data('amount', this.value)
            $('.month-picker.selected').attr('data-amount', this.value)
            $('.month-picker.selected:last').trigger('click')
            
        )
        
        $('.month-picker:first').addClass('selected')
        $('#pay_period_started_at').val($('.month-picker:first').data('date'))
        if $('#pay_period_finished_at').val() != ""
            $('.month-picker:last').trigger("click")
        else
            $('#pay_period_finished_at').val($('.month-picker:first').data('date'))
            $('#total-payment').html($('.month-picker:first').data("amount"))
            
        $('#pay_period_paid_at').datetimepicker(
            format: 'DD/MM/Y'
        )
        
        