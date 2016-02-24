require "dotenv"
Dotenv.load

require "json"
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/namespace"
require "sinatra/json"
require "pry"

Dir["./models/*.rb"].each { |file| require file }
Dir["./seeders/*.rb"].each { |file| require file }

class App < Sinatra::Base
  register Sinatra::JSON
  register Sinatra::Namespace

  get '/books' do
    index = File.join(settings.public_folder, 'index.html')
    send_file(index)
  end

  #API endpoints
  get "/api/v1/book/:id" do
    content_type :json
    @book = Book.find(params[:id].to_i)
    {
      book: @book,
      reviews: @book.reviews
    }.to_json
  end

  get "/api/v1/books" do
    content_type :json
    @books = Book.order(:title)
    books = []
    @books.each do |book|
      books << {
        book: book,
        review_score: book.average_review_score,
        reviews: book.reviews
      }
    end
    books.to_json
  end

  post "/api/v1/books/new" do
    book = Book.create(
      title: params[:title],
      author: params[:author],
      description: params[:description]
    )
    if book.valid?
      status 200
    else
      status 422
    end
  end

  post "/api/v1/book/:id/reviews/new" do
    book = Book.find(params[:id].to_i)
    review = Review.create(
      book: book,
      score: params[:review_score].to_i,
      description: params[:review_description]
    )
    if review.valid?
      status 200
    else
      status 422
    end
  end
end
