class SeriesController < ApplicationController
  def index
    @series = Serie.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @series}
    end
  end

  def show
    @serie = Serie.find(params[:id])
  end
end
