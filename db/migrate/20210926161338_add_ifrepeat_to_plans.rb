class AddIfrepeatToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :ifrepeat, :integer
  end
end
