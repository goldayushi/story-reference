# frozen_string_literal: true

class ChronologiesController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user, only: %i[new create edit update destroy]
  before_action :set_chronology, only: %i[show edit update destroy]

  def index
    @q = Chronology.ransack(params[:q])
    @chronologies = @q.result(distinct: true).order(:year).page(params[:page]).per(10)
  end

  def new
    @chronology = Chronology.new
  end

  def create
    @chronology = Chronology.new(chronology_params)
    if @chronology.save
      redirect_to chronologies_path
    else
      render 'new'
    end
  end

  def show
    redirect_to chronologies_path
  end

  def edit; end

  def update
    if @chronology.update(chronology_params)
      redirect_to chronologies_path
    else
      render 'edit'
    end
  end

  def destroy
    if @chronology.destroy
      redirect_to chronologies_path
    else
      render 'index'
    end
  end

  private

  def set_chronology
    @chronology = Chronology.find(params[:id])
  end

  def chronology_params
    params.require(:chronology).permit(:year, :japan_event, :korea_event, :china_event, :other_event)
  end
end
