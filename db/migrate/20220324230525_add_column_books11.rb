class AddColumnBooks11 < ActiveRecord::Migration[6.0]
  def change
    add_column :books,:evaluation, :float
    add_column :books,:total_point, :integer
    add_column :books,:category_rank, :integer
  end
end
