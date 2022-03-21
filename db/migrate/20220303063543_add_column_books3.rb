class AddColumnBooks3 < ActiveRecord::Migration[6.0]
  def change
    add_column :books,:official_site, :string
    add_column :books,:amazon, :string
    add_column :books,:rakuten, :string
  end
end
