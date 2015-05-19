class CategoryPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_admin, model)
    @current_admin = current_admin
    @category = model
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
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @category.admin
   end

  def show?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @category.admin
  end

  def update?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @category.admin
   end

  def destroy?
    @current_admin.present? && @current_admin.role?('super_admin') || @current_admin == @category.admin
  end
end
