class Debts.Views.DebtPeriodsNewEdit extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('#started_at').datetimepicker(
            format: 'MMMM YYYY',
            viewMode: "months",
            useCurrent: false
        )
        
        $('#finished_at').datetimepicker(
            format: 'MMMM YYYY',
            viewMode: "months",
            useCurrent: false
        )
        
        if gon.finished_at != null
            $('#started_at').data("DateTimePicker").maxDate(new Date(gon.finished_at))
            $("#finished_at").data("DateTimePicker").maxDate(new Date(gon.finished_at))
        else
            $('#started_at').data("DateTimePicker").minDate(new Date(gon.started_at))
            $('#finished_at').data("DateTimePicker").minDate(new Date(gon.started_at))
        
        $("#started_at").on("dp.change", (e) ->
            $('#finished_at').data("DateTimePicker").minDate(e.date)
            console.log(e.date._d)
            $("#debt_period_started_at").val(e.date.format("DD/MM/YYYY"))
        )
        
        $("#finished_at").on("dp.change", (e) ->
            $('#started_at').data("DateTimePicker").maxDate(e.date)
            $("#debt_period_finished_at").val(e.date.format("DD/MM/YYYY"))
        )
        
        $('#debt_period_amount').focus( ->
            this.value = ''
        )