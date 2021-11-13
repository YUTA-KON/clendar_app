class CreateGrplans < ActiveRecord::Migration[5.2]
  def change
    create_table :grplans do |t|
      t.integer :group_id
      t.string :title
      t.text :body
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :ifrepeat
      t.string :dow
      t.string :start_time_dow
      t.string :string
      t.string :finish_time_dow
      t.string :string

      t.timestamps
    end
  end
end
