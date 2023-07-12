if @favorite.persisted?
  json.icon render(partial: "favorites/icon", formats: :html, locals: {hike: @hike, favorite: Favorite.new})
else
  json.icon render(partial: "favorites/icon", formats: :html, locals: {hike: @hike, favorite: @favorite})
end
