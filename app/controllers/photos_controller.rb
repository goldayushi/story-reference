class PhotosController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_photo, only: [:edit, :update, :destroy]

  def index
    @q = Photo.ransack(params[:q])
    if params[:tag_name]
      @photos = Photo.tagged_with("#{params[:tag_name]}").page(params[:page]).per(5)
    else
      @photos = @q.result(distinct: true).order(id: "DESC").page(params[:page]).per(5)
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def edit
    @photo.image.cache! unless @photo.image.blank?
  end

  def update
    if @photo.update(photo_params)
      redirect_to photos_path
    else
      render 'edit'
    end
  end

  def destroy
    if @photo.destroy
      redirect_to photos_path
    else
      render 'index'
    end
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:title, :overview, :image, :image_cache, :tag_list)
    end
end
