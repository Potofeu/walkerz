require "open-uri"
require "nokogiri"
class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end
  def new
    @hike = Hike.find(params[:hike_id])
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.new(location_params)
    @hike = Hike.find(params[:hike_id])
    authorize @location

    if Location.exists?(address: @location.address)
      @existing_location = Location.find_by address: @location.address
      PointsOfInterest.create!(hike_id: @hike.id, location_id: @existing_location.id)
      redirect_to new_hike_location_path(@hike)
    else
      if @location.save!
        PointsOfInterest.create!(hike_id: @hike.id, location_id: @location.id)
        redirect_to new_hike_location_path(@hike)
      else
        render :new, statut: :unprocessable_entity
      end
    end
  end

  def wikipedia_scrapping(name)
    url = "https://fr.wikipedia.org/wiki/#{name}"
    description = ""
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)
    html_doc.search(".mw-parser-output p").first(2).each do |element|
      description << element.text.strip
    end
    puts description
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :description, :photo)
  end

  # def wikipedia_scrapping(name)
  #   url = "https://fr.wikipedia.org/wiki/#{name}"
  #   description = ""
  #   html_file = URI.open(url).read
  #   html_doc = Nokogiri::HTML.parse(html_file)
  #   html_doc.search(".mw-parser-output p").first(2).each do |element|
  #     description << element.text.strip
  #   end
  #   puts description
  # end
end
