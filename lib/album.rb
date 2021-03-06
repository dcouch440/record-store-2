class Album
  attr_reader :id, :name, :year, :genre, :artist #Our new save method will need reader methods.

  @@albums = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an Album is added.

  def initialize(name, year, genre, artist, id) # We've added id as a second parameter.
    @name = name
    @year = year
    @genre = genre
    @artist = artist
    @id = (id || @@total_rows += 1)

  def self.name_all
    @@albums.values().map {|instance| instance.name()}
  end

  def songs
    Song.find_by_album(self.id)
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

  def self.find(id)
    @@albums[id]
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.sort_albums
    @@albums.values().sort{
      |a, b| a.name.downcase <=> b.name.downcase
    }
  end

  def update(name)
    @name = name
  end

  def delete
    @@albums.delete(self.id)
  end

  def get_data(type)
    type == 'name' ?
      self.name :
    type == 'genre' ?
      self.genre :
    type == 'year' ?
      self.year :
    type == 'artist' ?
      self.artist :
    null
  end

  def self.find_by_name(data_type, data)
    @@albums.values().select {|instance| instance.get_data(data_type).downcase() == data.downcase()}[0]
  end

end