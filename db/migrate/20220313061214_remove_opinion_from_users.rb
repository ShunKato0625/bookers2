class RemoveOpinionFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :opinion, :text
  end
end
