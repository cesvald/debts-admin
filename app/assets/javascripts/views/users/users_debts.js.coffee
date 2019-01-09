class Debts.Views.UsersDebts extends Backbone.View

    el: 'body'
    	
    initialize: ->
        $('a[href="' +window.location.hash+ '"]').tab('show')