class AddColumnBooks10 < ActiveRecord::Migration[6.0]
  def change
    add_column :books,:qiita_point, :integer
    add_column :books,:search_point, :integer
    add_column :books,:recommended_point, :integer
    add_column :books,:introductory, :boolean
  end
end
