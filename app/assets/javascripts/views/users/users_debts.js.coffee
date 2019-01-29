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