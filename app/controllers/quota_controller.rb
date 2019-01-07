class QuotaController < ApplicationController
   inherit_resources
  
  def create
    create! { quota_path }
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def quotum_params
      params.require(:quotum).permit(:agreement_payment_id, :number, :state, :amount)
    end
end
