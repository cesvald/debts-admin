require 'csv'
class ItemsController < ApplicationController
  inherit_resources
  
  has_scope :by_name
  
  def create
    create! { items_path }
  end
  
  def update
    update! { items_path }
  end
  
  def index
		@items = params[:q] ? Item.by_name(params[:q]).order(:name).limit(10) : end_of_association_chain.order(:name).page(params[:page])
	
		respond_to do |format|
			format.html
			format.json  {render :json => @items}
		end
	end
  
  def import
		excel = params[:file]
        import_results='INICIO ------------------------:   '
        CSV.foreach(excel.path, :headers => true, :col_sep => ';', encoding:'iso-8859-1:utf-8') do |row|
          item=Item.where("name = ?", row['concepto'])
          if item.empty?
            @item = Item.new()
            @item.name= row['concepto']
            if @item.save
              puts "--------graba ok"
              puts  row['concepto']
              import_results =import_results+  "  "+ row['concepto']+ " OK: ---------- <br>"
            else
              puts "----------------------------------------------no graba"
              puts @item.errors.full_messages
              import_results =  import_results+ "  "+ row['concepto']+@item.errors.full_messages.inspect + " ERROR---------- <br>"
            end
          else
            puts "--------EL CONCEPTO YA EXISTE" 
            puts row['concepto']
          end
        end
        import_results=import_results+"      ---------------FIN"
        puts import_results
	end
	
	def import_new
		
	end	
		
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :headquarter_id)
    end
  
  
end
