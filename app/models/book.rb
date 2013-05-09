class Book < ActiveRecord::Base
  attr_accessible :author, :cover, :description, :rating, :title, :download_path
  validates :title, uniqueness: true
end
