class Admin::CustomersController < ApplicationController
  def index
    @all_customer = Customer.all
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  def update
  end

end
