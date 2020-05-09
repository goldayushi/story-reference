class EpisodesController < ApplicationController
  def index
    @episodes = Episode.all.order(chapter: :desc).page(params[:page]).per(10)
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      redirect_to episodes_path
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
  def episode_params
    params.require(:episode).permit(:chapter, :title, :overview, :content, :set, :keyword, :keyitem, :division, :year)
  end
end
