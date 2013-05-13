require 'yaml'

class BooksController < ApplicationController


  # Scans dir and sub dirs for books and adds them to the Book model	
  def scan


    config_file = File.expand_path('../../config/bookhero.conf',File.dirname(__FILE__))
    if !File.exist?(config_file)
      default_library_path = File.expand_path('../../books/',File.dirname(__FILE__))
      data = {"library_path" => "#{default_library_path}"}
      File.open(config_file,"w") {|f| f.write(data.to_yaml)}
    end

  	settings = YAML::load(File.open(config_file))
  	library_path = settings['library_path']
    google_api_key = settings['google_api_key']
  	
   pid = Process.fork do  
   # Support mobi, epub and pdf
 	 accepted_formats = [".mobi",".epub",".pdf"]
 	 books = Dir.glob("#{library_path}/**/*")
     books.each do |list_book|
     	if accepted_formats.include? File.extname("#{list_book}")
        found_book = File.basename("#{list_book}",File.extname("#{list_book}"))

				# Don't do a google book API call if the book is already in the DB. 
        check_book = Book.find_by_title("#{found_book}")
        if check_book.nil?
            # Setup search with API key 
            if google_api_key.blank?
              book_data = GoogleBooks.search("#{found_book}").first
            else
     		      book_data = GoogleBooks.search("#{found_book}",{:api_key => google_api_key}).first
            end 
        
            # Passing to the Book model
            # Book(id: integer, cover: string, title: string, author: string, description: string, rating: integer, created_at: datetime, updated_at: datetime)
            Book.create(cover: "#{book_data.image_link(:zoom => 5)}",
                        title: "#{found_book}",
                        author: "#{book_data.authors}",
                        description: "#{book_data.description}",
                        rating: "#{book_data.average_rating}",
      						  	  download_path: "#{list_book}")
	     end   
      end
		 end 
   end 
  end

  # Gets book details out of Book model and display it
  def list
     @my_books = Book.all
  end

  # Homepage
  def main
    @number_of_books = Book.count
    @last_six_books = Book.last(6).reverse
  end

  def show
  end

  # Download the book
  def download
    @download_book = params[:download_book]
    dl_book = Book.find_by_id(@download_book)
    download_link = dl_book.download_path
    send_file download_link
  end

  # Search for books
  def search
     search = params[:search]
     books=Book.arel_table
     @book_search = Book.where(books[:title].matches("%#{search}%")) 

  end

  # Shows a single book
  def viewbook
    @bookinfo = Book.find_by_id(params[:bookid])
  end

  # Remove book from BookHero library and delete the book on the
  # filesystem.
  def remove
    @remove_book = params[:remove_book] 
    delete_book = Book.find_by_id(@remove_book)
    delete_book.destroy
    # Delete the actual book here as well -- not now enabled for testing
    redirect_to :action => "list"
  end
end
