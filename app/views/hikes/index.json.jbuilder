json.listes render(partial: "listes", formats: :html, locals: {hikes: @hikes})
# json.array! @hikes, partial: 'listes', as: :hike
