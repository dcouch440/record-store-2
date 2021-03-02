class Album
  attr_reader :id, :name, :year, :genre, :artist #Our new save method will need reader methods.

  @@albums = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an Album is added.

  def initialize(name, year, genre, artist, id) # We've added id as a second parameter.
    @name = name
    @year = year
    @genre = genre
    @artist = artist
    @id = id || @@total_rows += 1  # We've added code to handle the id.
  end

  def self.all
    @@albums.values()
  end
  def self.albums
    @@albums
  end
  def save
    @@albums[self.id] = Album.new(self.name, self.year, self.genre, self.artist, self.id)

  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.find(id)
    @@albums[id]
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def update(name)
    @name = name
  end

  def delete
    @@albums.delete(self.id)
  end

  def self.find_by_name(name)
    @@albums.values().select {|obj| obj.name == name}[0]
  end
end

