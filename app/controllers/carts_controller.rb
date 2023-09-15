class CartsController < ApplicationController
  before_action :set_cart, only: %i[  edit update destroy ]

  def index
    @carts = Cart.all
  end

  def show
    begin
      @cart = Cart.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to @cart, :notice => 'Invalid Cart'
      else
        respond_to do |format|
          format.html 
          format.json { render json: @cart }
      end
    end
  end

  def new
    @cart = Cart.new
  end

  def edit
  end


  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end
    def cart_params
      params[:cart]
    end
end
