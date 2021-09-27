class AddStartTimeDowToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :start_time_dow, :string
  end
end
