class StoresController < ApplicationController
  before_action :set_store, only: %i[ show edit update destroy ]
  before_action :admin_logged_in?

  def index
    @stores = Store.all
  end

  def show
  end
  
  def new
    @store = Store.new
  end

  def edit
  end
  
  def create
    @store = Store.new(store_params)
    respond_to do |format|
      if @store.save
        format.html { redirect_to store_url(@store), notice: "Store was successfully created." }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to store_url(@store), notice: "Store was successfully updated." }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url, notice: "Store was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_store
      @store = Store.find(params[:id])
    end
    def store_params
      params.require(:store).permit(:name, :category, :description, :price, :author, files: [])
    end
    def admin_logged_in?
      if session[:admin].nil?
        flash[:notice] = "You need to do admin login to continue!"
        redirect_to admin_login_url
      end
    end
end
