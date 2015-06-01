class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    authorize Admin
    @admins = initialize_grid(Admin.where("id != ?", current_admin.id).order('id desc'), per_page: 10)
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    authorize @admin
  end

  # GET /admins/new
  def new
    authorize Admin
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
    # authorize @admin
    authorize @admin
  end

  # POST /admins
  # POST /admins.json
  def create
    authorize Admin
    @admin = current_admin.own_users.new(admin_params)
    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_url, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    authorize @admin
    respond_to do |format|
      attr = admin_params
      if attr[:password].blank? && attr[:password_confirmation].blank?
        attr = attr.except(:password, :password_confirmation)
      end
      if @admin.update(attr)
        format.html { redirect_to admins_url, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    authorize @admin
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
end
