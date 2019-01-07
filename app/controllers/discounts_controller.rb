class DiscountsController < ApplicationController
  inherit_resources
  belongs_to :user, :agreement_payment, :polymorphic => true
  end
  
  def create
    create! { url_for session[:back_url] }
  end
  
  def update
    #update! { debts_path }
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def discount_params
      params.require(:discount).permit(:discountable_type, :discountable_id, :amount, :registered_at, :comment)
    end
end
