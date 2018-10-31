class Book

  attr_accessor :id, :title, :author, :description

  def self.open_connection
    conn =PG.connect(dbname: "book", user: "postgres", password: "Acad3my1")
  end

#CONN = Connect
  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM book ORDER BY id"
    results = conn.exec(sql)

    books = results.map do |tuple|
     self.hydrate tuple
  end
  return books
end
  #find ID from Database
  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM book WHERE id = #{id}"
    result = conn.exec(sql)

    book = self.hydrate result[0]
    return book
  end

  def self.hydrate book_data
    book = Book.new
    book.id = book_data['id']
    book.title = book_data['title']
    book.author = book_data['author']
    book.description = book_data['description']

    return book
  end

  def save
    conn = Book.open_connection
    if (! self.id )
      sql = "INSERT INTO book (title, author, description) VALUES ('#{self.title}', '#{self.author}', '#{self.description}')"
    else
      sql = "UPDATE book SET title = '#{self.title}', author = '#{self.author}', description= '#{self.description}' WHERE id= '#{self.id}'"
    end
      conn.exec(sql)
  end

  def self.destroy id #u can also do self.destroy and take out thevline 50
    conn = Book.open_connection
    sql = "DELETE FROM book WHERE id = '#{id}'"
    conn.exec(sql)
  end

end
