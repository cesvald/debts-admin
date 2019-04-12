class BalanceController < ApplicationController
  inherit_resources
  
  #belongs_to :general_debt, :monthly_debt, :agreement_payment, polymorphic: true, optional: true
  
  #before_action :set_parent
  
 
 ###NOS FALTA AGREGAR EL CAMPO CURRENCY EN BALANCE
 
    def monthly_balance
        
        from_date=Date.new 
        until_date=Date.new
        preview_balance=  nil  ### from_date menos un mes para sacar el saldo inicial
        
        balace_results=""
        User.all.each do |user|
            ####deudas generales
            @balace_general_debts = Balance.new()
            if preview_balance == nil
                ### EN EL PRIMER BALANCE OBTIENE DIRECTO DE DEUDAS GENERALES
                puts user.name
                puts user.group.headquarter.name
                puts user.group.name
                results=user.total_general_debts_first_load
                puts results
                results.each do |row|
                    puts "hola"
                    puts row['HEADQUARTER_ID'] + "    " + row['TOTAL_DEBT']
                end
                
                @balace_general_debts.user=user
                puts " UNO --------- -***************************************"
                puts results['HEADQUARTER_ID']
               # @balace_general_debts.headquarter.headquarter_id=results['HEADQUARTER_ID']
                puts " DOS "
                #@balace_general_debts.debt_type="GeneralDebt"
                #puts " TRES "
                #@balace_general_debts.debt=results['TOTAL_DEBT']
                puts " CUATRO "
                #@balace_general_debts.payment=results['TOTAL_PAYMENT']
                puts " CINCO "
                #@balace_general_debt.due=0
                puts " SEIS "
                #@balace_general_debts.generated_at=Date.new
                puts " SIETE "
                if @balace_general_debts.save
                    puts "--------graba ok"
                    balace_results =balace_results+  "  "+ results['email']+ "  "+results['name'] +"  "+results['surname']+ " OK: ---------- <br>"
                else
                    puts "----------------------------------------------no graba"
                    puts @balace_general_debts.errors.full_messages
                    balace_results =  balace_results+ "  "+ results['email']+"  "+results['name'] +"  "+results['surname']+  @balace_general_debts.errors.full_messages.inspect + " ERROR---------- <br>"
                end
                 
            else  
                ###BUSCA SALDO INICIAL EN BALANCE DEL MES ANTERIOR MAS LAS DEUDAS DEL NUEVO MES
                aux="a partir del segundo corte de saldos"
            end
        end
    end
     
end