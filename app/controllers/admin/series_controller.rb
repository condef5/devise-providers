class Admin::SeriesController < ApplicationController
  before_action :set_serie, only: [:show, :edit, :update, :destroy]

  def index
    @series = Serie.all
    respond_to do |format|
      format.html { render "series/index" }
      format.json { render json: @series}
    end
  end

  def new
    @serie = Serie.new
    authorize [:admin, @serie]
  end

  def edit
    authorize [:admin, @serie]
  end
  
  def show
    render "series/show" 
  end

  def create
    @serie = Serie.new(serie_params)
    authorize [:admin, @serie]
    if @serie.save
      SerieMailer.with(user: current_user, serie: @serie).serie_created.deliver_later
      redirect_to admin_series_path(@serie), notice: 'Serie was successfully created.'
    else
      render :new
    end
  end

  def update
    @serie = Serie.find(params[:id])
    authorize [:admin, @serie]
    if @serie.update(serie_params)
      SerieMailer.with(user: current_user, serie: @serie).serie_updated.deliver_later
      redirect_to admin_series_path(@serie), notice: 'Serie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize [:admin, @serie]
    SerieMailer.with(user: current_user, serie: @serie).serie_deleted.deliver_now
    @serie.destroy
    redirect_to admin_series_index_path, notice: 'Serie was successfully destroyed.'
  end

  private
  def set_serie
    @serie = Serie.find(params[:id])
  end

  def serie_params
    params.require(:serie).permit(:title ,:description ,:rating , :price ,:status)
  end
end
