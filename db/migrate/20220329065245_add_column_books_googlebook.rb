class AddColumnBooksGooglebook < ActiveRecord::Migration[6.0]
  def change
    add_column :books,:googlebooks, :string
  end
end
