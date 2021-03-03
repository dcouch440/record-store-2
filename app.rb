require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/album') do
  @album = Album.find_by_name(params[:search_type], params[:search])
  if @album == nil
    erb(:error)
  else
    redirect to "albums/#{@album.id}"
  end
end


get('/albums') do
  @albums = Album.all
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
  @albums = Album.all()
  puts Album.albums
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

get('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end

get('/best_album_ever') do
  "This will show the best album that has ever existed in all time."
end

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end