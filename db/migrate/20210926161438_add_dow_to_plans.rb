class AddDowToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :dow, :integer
  end
end
