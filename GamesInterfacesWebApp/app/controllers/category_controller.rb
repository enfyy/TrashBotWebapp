class CategoryController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  # this is the | GET /category | Request.
  def index
    @categories = Category.all
  end

  # this is the | POST /category | Request.
  def create
    params.permit(:name)
    Category.create!(name: params[:name])
  end

  # this is the | DELETE /category | Request.
  def destroy
    cat = Category.find(params[:id])
    cat.destroy!
  end

end
