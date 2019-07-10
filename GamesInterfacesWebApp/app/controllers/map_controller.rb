class MapController < ApplicationController
  skip_before_action :authenticate_request

  # This is the | GET /map | Request.
  def index
    data = Trash.pluck(:id, :longitude, :latitude) # get geo-related. data from the database.
    @data_array = [] # create empty array.
    data.each do |single_data| # iterate over the data
      @data_array << {x: single_data[1], y: single_data[2]} # format data to hashes inside array.
    end

    unless @data_array.empty?
      # get minimums and maxiumums fromt the database that is used for the map diagram.
      @min_long = Trash.all.minimum(:longitude).round - 1
      @min_lat = Trash.all.minimum(:latitude).round - 1
      @max_long = Trash.all.maximum(:longitude).round + 1
      @max_lat = Trash.all.maximum(:latitude).round + 1
    end

  end

end
