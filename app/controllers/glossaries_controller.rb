# frozen_string_literal: true

class GlossariesController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user, only: %i[new create edit update destroy]
  before_action :set_glossary, only: %i[show edit update destroy]

  def index
    @q = Glossary.ransack(params[:q])
    if params[:tag_name]
      @glossaries = Glossary.tagged_with(params[:tag_name].to_s).page(params[:page]).per(20)
    else
      @glossaries = @q.result(distinct: true).order(:chapter).page(params[:page]).per(20)
    end
  end

  def new
    @glossary = Glossary.new
  end

  def create
    @glossary = Glossary.new(glossary_params)
    if @glossary.save
      redirect_to glossaries_path
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @glossary.update(glossary_params)
      redirect_to "/glossaries/#{@glossary.id}"
    else
      render 'edit'
    end
  end

  def destroy
    if @glossary.destroy
      redirect_to glossaries_path
    else
      render 'index'
    end
  end

  private

  def set_glossary
    @glossary = Glossary.find(params[:id])
  end

  def glossary_params
    params.require(:glossary).permit(:title, :content, :chapter, :tag_list)
  end
end
