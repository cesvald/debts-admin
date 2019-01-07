require 'csv'
class ItemHeadquartersController < ApplicationController
  inherit_resources
  
  def create
    create! { item_headquarters_path }
  end
  
  def update
    #update! { item_headquarters_path }
  end
  
  def import
		excel = params[:file]
        import_results='INICIO ------------------------:   '
        CSV.foreach(excel.path, :headers => true, :col_sep => ';', encoding:'iso-8859-1:utf-8') do |row|
          puts "---------------------------------------"
          puts row['item']
          @item_headquarter = ItemHeadquarter.new()
          @item_headquarter.is_billable=row['is_billable']
          @item_headquarter.registered_at=row['registered_at']
          
          item=Item.where("name = ?", row['item'])
          if item.empty?
            puts " item no existe"
          else
            item = item.first
            puts item.name
            @item_headquarter.item= item
          end
          
          headquarter=Headquarter.where("id = ?", row['headquarter'])
          if headquarter.empty?
            puts " headquarter no existe"
          else
            headquarter = headquarter.first
            @item_headquarter.headquarter= headquarter
          end

          if @item_headquarter.save
              puts "--------graba ok"
              import_results =import_results+  "  "+ row['item']+ "  "+row['headquarter']+ " OK: ---------- <br>"
          else
              puts "----------------------------------------------no graba"
              puts @item_headquarter.errors.full_messages
              import_results =  import_results+ "  "+ row['item']+"  "+row['headquarter'] +  @item_headquarter.errors.full_messages.inspect + " ERROR---------- <br>"
          end
          
        end                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        import_results=import_results+"      ---------------FIN"
        puts import_results
	end
	
	def import_new
		
	end	
  
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_headquarter_params
      params.require(:item_headquarter).permit(:amount,:registered_at,:is_billable,:item_id,:headquarter_id)
    end
end
