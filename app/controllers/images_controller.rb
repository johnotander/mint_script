class ImagesController < ApplicationController
  load_and_authorize_resource
  
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.js { render 'scripts/image_added' }
      else
        raise('wtf????')
      end
    end
  end

  def index
    @images = current_user.images.all

    respond_to do |format|
      format.html
      format.json { render json: @images }
    end
  end
end
