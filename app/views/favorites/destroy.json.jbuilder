json.icon render(partial: "favorites/icon", formats: :html, locals: {hike: @hike, favorite: Favorite.destroy})
