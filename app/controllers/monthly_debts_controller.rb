class MonthlyDebtsController < ApplicationController
    inherit_resources
    actions :update
    
    def update
        update! { request.referer + "#monthly-debt" }
    end
    
    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthly_debt_params
      params.require(:monthly_debt).permit(:deposit)
    end
end