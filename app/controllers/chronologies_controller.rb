class ChronologiesController < ApplicationController
  def index
    @q = Chronology.ransack(params[:q])
    @chronologies = @q.result(distinct: true).order(:chapter).page(params[:page]).per(10)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
