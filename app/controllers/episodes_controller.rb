class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]
  
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
    if @episode.update(episode_params)
      redirect_to "/episodes/#{@episode.id}"
    else
      render 'new'
    end
  end

  def destroy
  end

  private
    def set_episode
      @episode = Episode.find(params[:id])
    end
    
    def episode_params
      params.require(:episode).permit(:chapter, :title, :overview, :content, :set, :keyword, :keyitem, :division, :year)
    end
end
