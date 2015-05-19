class DeviceCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device_category, only: [:show, :edit, :update, :destroy]

  # GET /device_categories
  # GET /device_categories.json
  def index
    if params[:deleted]
      @device_categories = DeviceCategory.inactive
    else
      @device_categories = DeviceCategory.active
    end
  end

  # GET /device_categories/1
  # GET /device_categories/1.json
  def show
  end

  # GET /device_categories/new
  def new
    @device_category = DeviceCategory.new
  end

  # GET /device_categories/1/edit
  def edit
    redirect_to device_categories_path, alert: "You can't edit this device category." if @device_category.deleted_at.present?
  end

  # POST /device_categories
  # POST /device_categories.json
  def create
    @device_category = DeviceCategory.new(device_category_params)

    respond_to do |format|
      if @device_category.save
        format.html { redirect_to @device_category, notice: 'Device category was successfully created.' }
        format.json { render :show, status: :created, location: @device_category }
      else
        format.html { render :new }
        format.json { render json: @device_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_categories/1
  # PATCH/PUT /device_categories/1.json
  def update
    respond_to do |format|
      if @device_category.update(device_category_params)
        format.html { redirect_to @device_category, notice: 'Device category was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_category }
      else
        format.html { render :edit }
        format.json { render json: @device_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_categories/1
  # DELETE /device_categories/1.json
  def destroy
    if @device_category.update_attributes(deleted_at: params[:revert] ? nil : DateTime.now)
      message = {notice: "Device category was successfully #{params[:revert] ? 'reverted' : 'deleted'}." }
    else
      message = {alert: @device_category.errors.first[1]}
    end
    respond_to do |format|
      format.html { redirect_to device_categories_url, message }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_category
      @device_category = DeviceCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_category_params
      params.require(:device_category).permit(:name, :description, :parent_id)
    end
end
