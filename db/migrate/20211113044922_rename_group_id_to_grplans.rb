class RenameGroupIdToGrplans < ActiveRecord::Migration[5.2]
  def change
    rename_column :grplans, :group_id, :user_id
  end
end
