class AddInssDiscountToProponents < ActiveRecord::Migration[7.0]
  def change
    add_column :proponents, :inss_discount, :decimal
  end
end
