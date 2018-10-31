class PostController<Sinatra::Base    #this means class is children of Sinatra

  set :root, File.join(File.dirname(__FILE__), "..")

  set :view, Proc.new { File.join(root, "views") }

  configure:development do
    register Sinatra::Reloader
  end

# $songs = [
#   {
#     id:0,
#     title: "I like it",
#     artist: "Cardi B",
#     embed_id: "xTlNMmZKwpA"
#   },
#   {
#     id:1,
#     title: "Call Out my name ",
#     artist: "The Weekend",
#     embed_id: "M4ZoCHID9GI"
#   },
#   {
#     id:2,
#     title: "All the Stars",
#     artist: "Kendrick Lamar",
#     embed_id: "JQbjS0_ZfJ0"
#   },
#   {
#     id:3,
#     title: "Barking",
#     artist: "Ramz",
#     embed_id: "wrrbEjJEVz4"
#   }
# ]

  get "/" do
    @title_page = "Books"
    @songs = Book.all
    erb :"songs/index"
  end

  get "/new" do
    # @song = {
    #   id:"",
    #   title: "",
    #   artist: "",
    #   embed_id: ""
    # }
    @song = Book.new
    erb :'songs/new'
  end

  get "/:id_url" do
    id = params[:id_url].to_i
    @song = Book.find id
    erb :'songs/show'
  end

  get '/:id_url/edit' do
    id = params[:id_url].to_i
    @song = Book.find id
      erb :'songs/edit'
    # book.title = params[:title]
    # book.author = params[:author]
    # book.description = params[:description]
  end

  put '/:id' do
    id= params[:id].to_i

    book = Book.find id
    book.title = params[:title]
    book.author = params[:author]
    book.description = params[:description]

    book.save
    redirect '/'
    # song = $songs[id]
    # song[:title] = params[:title]
    # song[:artist] = params[:artist]
    # song[:embed_id] = params[:embed_video]
    # redirect '/'
  end

  delete '/:id' do
    id = params[:id].to_i
    Book.destroy id
    redirect '/'
  end

  post '/' do
    book = Book.new
    book.title = params[:title]
    book.author = params[:author]
    book.description = params[:description]
    book.save

    redirect "/"
  end

end
