class Debts.Views.AgreementPaymentsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('#agreement_payment_started_at').datetimepicker(
            format: 'DD/MM/Y'
        )
        
        $('#agreement_payment_expired_at').datetimepicker(
            useCurrent: false
        )
        
        $("#agreement_payment_started_at").on("dp.change", (e) ->
            $('#agreement_payment_expired_at').data("DateTimePicker").minDate(e.date)
        )
        $("#agreement_payment_expired_at").on("dp.change", (e) ->
            $('#agreement_payment_started_at').data("DateTimePicker").maxDate(e.date)
        )
        
        $('a[href="' +window.location.hash+ '"]').tab('show')