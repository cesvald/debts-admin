class Balance < ActiveRecord::Base
  belongs_to :user
  belongs_to :headquarter
  
  enum debt_type: [ :general_debt, :monthly_debt, :agreement_payment ]
 
 
  def test
      puts 'in balance'
  end
  
  
  from_Date=Date.new 
  until_ate=Date.new
  preview_balance=  nil  ### from_date menos un mes para sacar el saldo inicial
  ###NOS FALTA AGREGAR EL CAMPO CURRENCY EN BALANCE
 
  def monthly_balance
       
    balace_results=""
    User.all.each do |user|
    ####deudas generales
    balace_general_debts = Balace.new()
      if preview_balance == nil
        ### EN EL PRIMER BALANCE OBTIENE DIRECTO DE DEUDAS GENERALES
        puts user.name
        puts user.group.headquarter.name
        puts user.group.name
        results=user.total_general_debts_first_load
        balace_general_debts.user=user
        balace_general_debts.headquarter.headquarter_id=results['HEADQUARTER_ID_BALANCE']
        balace_general_debts.debt_type="GeneralDebt"
        balace_general_debts.debt=results['TOTAL_DEBT']
        balace_general_debts.payment=results['TOTAL_PAYMENT']
        balace_general_debt.due=0
        balace_general_debts.generated_at=Date.new
        if balace_general_debts.save
          puts "--------graba ok"
          balace_results =balace_results+  "  "+ results['email']+ "  "+results['name'] +"  "+results['surname']+ " OK: ---------- <br>"
        else
          puts "----------------------------------------------no graba"
          puts balace_general_debts.errors.full_messages
          balace_results =  balace_results+ "  "+ results['email']+"  "+results['name'] +"  "+results['surname']+  @balace_general_debts.errors.full_messages.inspect + " ERROR---------- <br>"
        end
      else  
        ###BUSCA SALDO INICIAL EN BALANCE DEL MES ANTERIOR MAS LAS DEUDAS DEL NUEVO MES
        aux="a partir del segundo corte de saldos"
      end
    end
  end
    
end
