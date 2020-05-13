class PhotosController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @q = Photo.ransack(params[:q])
    if params[:tag_name]
      @photos = Photo.tagged_with("#{params[:tag_name]}").page(params[:page]).per(5)
    else
      @photos = @q.result(distinct: true).order(:chapter).page(params[:page]).per(5)
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

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def photo_params
      params.require(:photo).permit(:title, :overview, :image, :tag_list)
    end
end
