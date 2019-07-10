class TrashController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  #This is the | GET /trash | Request, which is also the root index page.
  def index
    params.permit(:category_id) # whitelist parameters.
    trash_categories = Category.where(non_trash: false).pluck(:id)

    @all_trash = Trash.where(categories_id: trash_categories).order(collected_at: :desc) # Get Trash from database and order it by collected_at date.
    @most_recent_find = @all_trash.first # The most recent find is the first one.
    @cat = params[:category_id] # Get category id from request parameter.
    @category_hash = Category.where(non_trash: false).pluck(:id, :name).to_h # Create hash from database data of the categories.

    if @cat.nil? || @category_hash[@cat.to_i].nil? # there is no category set?
      @trash_list = @all_trash.all # then show all trash in the list.
    else
      @trash_list = Trash.where(categories_id: @cat).order(collected_at: :desc).all # or filter the trash by catergory.
    end

    @image = nil
    unless File.zero?(Rails.root.join('public/images/last_trash.png')) # is the file empty ?
      @image =  '/images/last_trash.png' # path to the image.
    end

  end

  #This is the | POST /trash | Request. This is the Request that gets called from the Trash-bot in order to make a new entry.
  def create
    params.permit(:category_id, :description, :latitude, :longitude, :image)

    image_name = 'last_trash.png'
    if Category.find(params[:category_id]).non_trash
      image_name = 'last_activity.png'
    end

    if params[:image].nil?
      File.open(Rails.root.join("public/images/#{image_name}"), 'wb') do |f|
        f.truncate(0) # empty the file
      end
    else
      File.open(Rails.root.join("public/images/#{image_name}"), 'wb') do |f|
        f.write(Base64.decode64(params[:image]))
      end
    end

    trash = Trash.new(collected_at: DateTime.now, categories_id: params[:category_id], description: params[:description], longitude: params[:longitude], latitude: params[:latitude])
    trash.save!
  end

  #GET | /trash/:id | This is not used.
  def show
    @trash = Trash.find(params[:id])
  end

  #DELETE /trash/:id
  def destroy
    #not implemented
  end


end
