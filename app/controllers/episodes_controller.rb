# frozen_string_literal: true

class EpisodesController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user, only: %i[new create edit update destroy]
  before_action :set_episode, only: %i[show edit update destroy]

  def index
    @q = Episode.ransack(params[:q])
    @episodes = if params[:tag_name]
                  Episode.tagged_with(params[:tag_name].to_s).page(params[:page]).per(10)
                else
                  @q.result(distinct: true).order(:chapter).page(params[:page]).per(10)
                end
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

  def show; end

  def edit; end

  def update
    if @episode.update(episode_params)
      redirect_to "/episodes/#{@episode.id}"
    else
      render 'edit'
    end
  end

  def destroy
    if @episode.destroy
      redirect_to episodes_path
    else
      render 'index'
    end
  end

  private

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:chapter, :title, :overview, :content, :set, :keyword, :keyitem, :division, :year, :tag_list)
  end
end
