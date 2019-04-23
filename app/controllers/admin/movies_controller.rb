class Admin::MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html { render "movies/index" }
      format.json { render json: @movies}
    end
  end

  def new
    @movie = Movie.new
    authorize [:admin, @movie]
  end

  def edit
    authorize [:admin, @movie]
  end

  def show
    render "movies/show"
  end

  def create
    @movie = Movie.new(movie_params)
    authorize [:admin, @movie]
    if @movie.save
      redirect_to admin_movie_path(@movie), notice: 'movie was successfully created.'
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    authorize [:admin, @movie]
    if @movie.update(movie_params)
      redirect_to admin_movie_path(@movie), notice: 'movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize [:admin, @movie]
    @movie.destroy
    redirect_to admin_movies_path, notice: 'Movie was successfully destroyed.'
  end

  private
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title ,:description ,:rating ,:duration ,:price ,:status ,:progress)
  end
end

