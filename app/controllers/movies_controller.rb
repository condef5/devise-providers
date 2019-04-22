class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @movies}
    end
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
end

