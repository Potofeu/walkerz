class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    authorize @review
    @user = current_user
    @hike = Hike.find(params[:hike_id])
    @review.user = @user
    @review.hike = @hike

    respond_to do |format|
      if @review.save
        format.html { redirect_to hike_path(@hike) }
        format.json
      else
        format.html { render hike_path(@hike), status: :unprocessable_entity }
        format.json
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to hike_path(@review.hike)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end
