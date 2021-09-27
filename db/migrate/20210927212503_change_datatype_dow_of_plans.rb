class ChangeDatatypeDowOfPlans < ActiveRecord::Migration[5.2]
  def change
    change_column :plans, :dow, :string
  end
end
