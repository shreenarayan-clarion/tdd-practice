class ProductImagePolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_admin, model)
    @current_admin = current_admin
    @product_image = model
  end

  def index?
    @current_admin.present?
  end

  def new?
    @current_admin.present? && @current_admin.role?('super_admin')
  end

  def create?
    @current_admin.present? && @current_admin.role?('super_admin')
  end

  def edit?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @product_image.admin
  end

  def show?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @product_image.admin
  end

  def update?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @product_image.admin
  end

  def destroy?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @product_image.admin
  end
end
