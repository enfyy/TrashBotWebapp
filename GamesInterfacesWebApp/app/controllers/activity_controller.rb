class ActivityController < ApplicationController
  skip_before_action :authenticate_request

  def index
    params.permit(:category_id) # whitelist parameters.
    non_trash_categories = Category.where(non_trash: true).pluck(:id)

    @all_trash = Trash.where(categories_id: non_trash_categories).order(collected_at: :desc) # Get Trash from database and order it by collected_at date.
    @most_recent_find = @all_trash.first # The most recent find is the first one.
    @cat = params[:category_id] # Get category id from request parameter.
    @category_hash = Category.where(non_trash: true).pluck(:id, :name).to_h # Create hash from database data of the categories.

    if @cat.nil? || @category_hash[@cat.to_i].nil? # there is no category set?
      @trash_list = @all_trash.all # then show all trash in the list.
    else
      @trash_list = Trash.where(categories_id: @cat).order(collected_at: :desc).all # or filter the trash by catergory.
    end

    @image = nil
    unless File.zero?(Rails.root.join('public/images/last_activity.png')) # is the file empty ?
      @image =  '/images/last_activity.png' # path to the image.
    end
  end

end
