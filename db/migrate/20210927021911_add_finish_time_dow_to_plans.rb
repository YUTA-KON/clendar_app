class AddFinishTimeDowToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :finish_time_dow, :string
  end
end
