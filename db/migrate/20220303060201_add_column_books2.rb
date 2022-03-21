class AddColumnBooks2 < ActiveRecord::Migration[6.0]
  def change
    add_column :books,:category_code1, :integer
    add_column :books,:category_code2, :integer
    add_column :books,:category_code3, :integer
    add_column :books,:publisher, :string
    add_column :books,:author, :string

    remove_column :books, :category_code
    remove_column :books, :name
    remove_column :books, :search
    remove_column :books, :remark
  end
end
