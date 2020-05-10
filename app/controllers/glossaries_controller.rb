class GlossariesController < ApplicationController
  def index
    @q = Glossary.ransack(params[:q])
    @glossaries = @q.result(distinct: true).order(:chapter).page(params[:page]).per(20)
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

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def glossary_params
      params.require(:glossary).permit(:title, :content, :chapter)
    end
end
