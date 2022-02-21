class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string  :book_code
      t.string  :category_code
      t.string  :name
      t.string  :photo
      t.integer  :classificationcode
      t.string  :publish_code
      t.integer  :price
      t.integer  :search
      t.integer  :point
      t.text :remark
      t.timestamps
    end
  end
end
