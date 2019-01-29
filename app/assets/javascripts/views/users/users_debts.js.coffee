class Debts.Views.UsersDebts extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('a[href="' +window.location.hash+ '"]').tab('show')
        $('#btn-edit-deposit').click( ->
            $(this).parent().fadeOut(200, ->
                $(this).find('input:last').removeClass('invisible')
                $('#btn-cancel-edit-deposit').removeClass('invisible')   
                $('#btn-edit-deposit').addClass('hidden')
                $('#monthly_debt_deposit').focus()
                $('#monthly_debt_deposit').removeAttr('readonly')
                $(this).fadeIn(200)
            )
        )
        
        $('#btn-cancel-edit-deposit').click( ->
            $(this).parent().fadeOut(200, ->
                $(this).find('input:last').addClass('invisible')
                $('#btn-edit-deposit').removeClass('hidden')
                $('#btn-cancel-edit-deposit').addClass('invisible')
                $('#monthly_debt_deposit').blur()
                $('#monthly_debt_deposit').attr('readonly', 'readonly')
                $(this).fadeIn(200)
            )
        )
        
        $('.btn-pay-period-edit').click( ->
            $(this).parent().fadeOut(200, ->
                $(this).find('.btn-pay-period-edit').addClass('hidden')
                $(this).find('.btn-pay-period-delete').addClass('hidden')
                $(this).parent().find('.pay-period-comment').addClass('hidden')
                $(this).find('.btn-pay-period-update').removeClass('hidden')
                $(this).find('.btn-pay-period-cancel').removeClass('hidden')
                $(this).parent().find('.comment-form').removeClass('hidden').find('input.form-control:first').focus()
                
                $(this).fadeIn(200)
            )
        )
        
        $('.btn-pay-period-cancel').click( ->
            $(this).parent().fadeOut(200, ->
                $(this).find('.btn-pay-period-edit').removeClass('hidden')
                $(this).find('.btn-pay-period-delete').removeClass('hidden')
                $(this).parent().find('.pay-period-comment').removeClass('hidden')
                $(this).find('.btn-pay-period-update').addClass('hidden')
                $(this).find('.btn-pay-period-cancel').addClass('hidden')
                $(this).parent().find('.comment-form').addClass('hidden').find('input.form-control:first').blur()
                
                $(this).fadeIn(200)
            )
        )
        
        $('.btn-pay-period-update').click( ->
            $(this).closest('tr').find('form').submit()
        )