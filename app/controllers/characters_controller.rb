class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  
  def index
    @characters = Character.all
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      flash[:info] = "登録完了しました"
      redirect_to characters_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @character.update(character_params)
      flash[:info] = "登録完了しました"
      redirect_to "/characters/#{@character.id}"
    else
      render 'new'
    end
  end

  def destroy
    if @character.destroy
      flash[:success] = "削除しました"
      redirect_to characters_path
    else
      render 'index'
    end
  end

  private
    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :role, :position, :countory, :birthplace, :career, :person, :appearance_chapter)
    end
end