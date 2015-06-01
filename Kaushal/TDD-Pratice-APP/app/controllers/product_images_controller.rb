class ProductImagesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_product
  before_action :set_product_image, only: [:show, :edit, :update, :destroy]

  # GET /product_images
  # GET /product_images.json
  def index
    authorize ProductImage
    @product_images = initialize_grid((@product.blank? ? ProductImage.all : @product.product_images), per_page: 10)
  end

  # GET /product_images/1
  # GET /product_images/1.json
  def show
    authorize @product_image
  end

  # GET /product_images/new
  def new
    authorize ProductImage
    @product_image = ProductImage.new
  end

  # GET /product_images/1/edit
  def edit
    authorize @product_image
  end

  # POST /product_images
  # POST /product_images.json
  def create
    authorize ProductImage
    @product_image = current_admin.product_images.new(product_image_params)

    respond_to do |format|
      if @product_image.save
        format.html { redirect_to product_product_images_url(@product_image.product), notice: 'Product image was successfully created.' }
        format.json { render :show, status: :created, location: @product_image }
      else
        format.html { render :new }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_images/1
  # PATCH/PUT /product_images/1.json
  def update
    authorize @product_image
    respond_to do |format|
      if @product_image.update(product_image_params)
        format.html { redirect_to product_product_images_url(@product_image.product), notice: 'Product image was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_image }
      else
        format.html { render :edit }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_images/1
  # DELETE /product_images/1.json
  def destroy
    authorize @product_image
    @product_image.destroy
    respond_to do |format|
      format.html { redirect_to product_product_images_url(@product_image.product), notice: 'Product image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_product
      @product = Product.find(params[:product_id]) if params[:product_id].present?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product_image
      @product_image = ProductImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_image_params
      params.require(:product_image).permit(:product_id, :category_id, :theme_id, :image)
    end
end
