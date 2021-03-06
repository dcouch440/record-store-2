require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/song')
require('./lib/album')
also_reload('lib/**/*.rb')

# Albums______________________________________>
get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/find_album') do
  @album = Album.find_by_name(params[:search_type], params[:search])
  if @album == nil
    erb(:error)
  else
    redirect to "/albums/#{@album.id}"
  end
end

get('/albums') do
  @albums = Album.sort_albums
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i)
  erb(:album)
end

post('/albums') do
  name, year, genre, artist = params.values_at(
    :album_name, :album_year, :album_genre, :album_artist
  )
  album = Album.new(name, year, genre, artist, nil)
  album.save()
  @albums = Album.sort_albums
  erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

# Songs ______________________________________>

# Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())

  song = Song.new(params[:song_name], @album.id, nil)
  song.save()

  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
