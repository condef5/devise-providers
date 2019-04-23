class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    authorize @rental
  end

  def edit
    authorize @rental
  end
  
  def show
  end

  
  def create
    @rental = Rental.new(rental_params)
    authorize(@rental)
    if @rental.save
      redirect_to rental_path(@rental), notice: 'Rental was successfully created.'
    else
      render :new
    end
  end

  def update
    @rental = Rental.find(params[:id])
    authorize(@rental)
    if @rental.update(rental_params)
      redirect_to rental_path(@rental), notice: 'Rental was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize(@rental)
    @rental.destroy
    redirect_to rentals_path, notice: 'Rental was successfully destroyed.'
  end

  private
  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:paid_price, :rentable_type, :rentable_id)
  end
end
