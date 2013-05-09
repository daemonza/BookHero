class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :cover
      t.string :title
      t.string :author
      t.string :description
      t.integer :rating

      t.timestamps
    end
  end
end
