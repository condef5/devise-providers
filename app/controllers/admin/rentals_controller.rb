class Admin::RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  def index
    @rentals = Rental.all
    render "rentals/index"
  end

  def new
    @rental = Rental.new
    authorize [:admin, @rental]
  end

  def edit
  end
  
  def show
    render "rentals/show"
  end

  
  def create
    @rental = Rental.new(rental_params)
    authorize [:admin, @rental]
    if @rental.save
      RentalMailer.with(user: current_user, rental: @rental).rental_created.deliver_later
      redirect_to admin_rental_path(@rental), notice: 'Serie was successfully created.'
    else
      render :new
    end
  end

  def update
    @rental = Rental.find(params[:id])
    authorize [:admin, @rental]
    if @rental.update(rental_params)
      RentalMailer.with(user: current_user, rental: @rental).rental_updated.deliver_later
      redirect_to admin_rental_path(@rental), notice: 'Serie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize [:admin, @rental]
    @rental.destroy
    RentalMailer.with(user: current_user, rental: @rental).rental_deleted.deliver_now
    redirect_to admin_rentals_path, notice: 'Serie was successfully destroyed.'
  end

  private
  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:paid_price, :rentable_type, :rentable_id)
  end
end
