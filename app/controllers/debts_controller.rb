require 'csv'
class DebtsController < ApplicationController
  inherit_resources
  
  belongs_to :general_debt, :monthly_debt, :agreement_payment, polymorphic: true
  
  before_action :set_parent
  
  def create
      create! { url_for session[:back_url] }
  end
  
  def new
    session[:back_url] = request.referer
    new! 
  end
  
  def edit
    session[:back_url] = request.referer
    edit! 
  end
  
  def update
    update! { url_for session[:back_url] }
  end
  
  def import
		excel = params[:file]
        import_results='INICIO ------------------------:   '
        
        CSV.foreach(excel.path, :headers => true, :col_sep => ';', encoding:'iso-8859-1:utf-8') do |row|
          puts "---------------------------------------"
          puts row['email']
          @debt = Debt.new()
          
          @debt.amount = row['amount']
          @debt.registered_at=row['registered_at']
          @debt.expired_at=row['registered_at']
          @debt.comment=row['comment']
          @debt.state=row['status']


          ih=ItemHeadquarter.new()
          ih.item= Item.new()
          ih.item.name=row['item']
          ih.headquarter=Headquarter.new()
          ih.headquarter.id=row['headquarter']
          @item_headquarter_id=nil
          ih.item_headquarter_by_item_and_headquarter.each do |aux|
            puts "hola .................."
            @item_headquarter_id=aux["id"]
            puts @item_headquarter_id
          end
          
          if @item_headquarter_id.nil?
            puts " item_headquarter_id no existe"
          else
            item_headquarter=ItemHeadquarter.where("id = ?",@item_headquarter_id)
            item_headquarter=item_headquarter.first
            @debt.item_headquarter=item_headquarter
          end
          
          user=User.where("email = ?", row['email'])
          if user.empty?
            puts " user no existe"
          else
            puts "######################### USER"
            user = user.first
            puts user.name
            @debt.user= user
          end

          if @debt.save
              puts "--------graba ok"
              import_results =import_results+  "  "+ row['item']+ "  "+row['headquarter']+ " OK: ---------- <br>"
          else
              puts "----------------------------------------------no graba"
              puts @debt.errors.full_messages
              import_results =  import_results+ "  "+ row['item']+"  "+row['email'] +  @debt.errors.full_messages.inspect + " ERROR---------- <br>"
          end
          
        end                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        import_results=import_results+"      ---------------FIN"
        puts import_results
	end
	
	def import_new
		
	end	
  
	
  
  private
    def set_parent
      @debtable = parent
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:amount, :balance, :registered_at, :expired_at, :comment, :grace_months, :is_billable, :item_id, :general_debt_id, :monthly_debt_id, :agreement_payment_id, :state)
    end

end
