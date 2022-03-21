class AddColumnBooks4 < ActiveRecord::Migration[6.0]
  def change
    add_column :books,:publication_date, :date
  end
end
