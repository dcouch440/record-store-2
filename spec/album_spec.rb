require 'rspec'
require 'album'
require 'song'

describe '#Album' do

  before(:each) do
    Album.clear()
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", "2021", "rock", "The Spoons", nil) # nil added as second argument
      album.save()
      album2 = Album.new("Blue", "2068", "pop", "Future", nil) # nil added as second argument
      album2.save()
      expect(Album.name_all()).to(eq([album.name(), album2.name()]))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", "2021", "rock", "The Spoons", nil)
      album.save()
      album2 = Album.new("Blue", "2068", "pop", "Future", nil)
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('#sort_albums') do
    it("sorts album names alphabetically") do
      album = Album.new("Giant Steps", "2021", "rock", "The Spoons", nil)
      album.save()
      album2 = Album.new("Blue", "2068", "pop", "Future", nil)
      album2.save()
      album3 = Album.new("Zoo Tycoon 5 Future Extreme", "2068", "pop", "Future", nil)
      album3.save()
      expect(Album.sort_albums().map{|inst| inst.name}).to(eq(['Blue', 'Giant Steps', "Zoo Tycoon 5 Future Extreme"]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", "2021", "rock", "The Spoons", nil)
      album.save()
      album2 = Album.new("Blue", "2068", "pop", "Future", nil)
      album2.save()
      expect(Album.find(album.id).name).to(eq(album.name))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", "2021", "rock", "The Spoons", nil)
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new("Giant Steps", "2021", "rock", "The Spoons", nil)
      album.save()
      album2 = Album.new("Blue", "2068", "pop", "Future", nil)
      album2.save()
      album.delete()
      expect(Album.name_all).to(eq([album2.name]))
    end
  end

  describe('.find_by_name') do
    it("finds an album by album name") do
      album = Album.new("Giant Steps", "2021", "rock", "John Coltrane", nil)
      album.save()
      album2 = Album.new("Blue", "2068", "pop", "Future", nil)
      album2.save()
      expect(Album.find_by_name('name', 'Giant Steps').name).to(eq(album.name))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new("Giant Steps", "2021", "rock", "John Coltrane", nil)
      album.save()
      song = Song.new("Naima", album.id, nil)
      song.save()
      song2 = Song.new("Cousin Mary", album.id, nil)
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end

end