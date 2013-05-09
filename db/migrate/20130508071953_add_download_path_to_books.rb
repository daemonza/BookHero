class AddDownloadPathToBooks < ActiveRecord::Migration
  def change
    add_column :books, :download_path, :string
  end
end
