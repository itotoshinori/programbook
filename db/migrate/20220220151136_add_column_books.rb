class AddColumnBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :title, :string
    add_column :books, :description, :text
  end
end
