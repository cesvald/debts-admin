class AddCommentToPayPeriod < ActiveRecord::Migration
  def change
    add_column :pay_periods, :comment, :string
  end
end
