if @review.persisted?
  json.form render(partial: "reviews/form", formats: :html, locals: {hike: @hike, review: Review.new})
  json.inserted_item render(partial: "hikes/review", formats: :html, locals: {review: @review})
else
  json.form render(partial: "reviews/form", formats: :html, locals: {hike: @hike, review: @review})
end
