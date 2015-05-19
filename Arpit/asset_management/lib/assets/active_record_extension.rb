module ActiveRecordExtension

  extend ActiveSupport::Concern

  # add your Instanace(class) methods here
  def active?
    has_attribute?(:deleted_at) ? self.deleted_at.nil? : true
  end

  def inactive?
    has_attribute?(:deleted_at) ? !self.deleted_at.nil? : false
  end

  def new?
    self.id.nil?
  end

  # add your static(class) methods here
  module ClassMethods
    def active
      ActiveRecord::Base.connection.column_exists?(table_name.to_sym, :deleted_at) ? where(deleted_at: nil) : all
    end

    def inactive
      ActiveRecord::Base.connection.column_exists?(table_name.to_sym, :deleted_at) ? where.not(deleted_at: nil) : []
    end

    def find_by_params(params = {}, consider_nil = true)
      condition = {}
      params.each do |key, value|
        if consider_nil
          condition[key] = value if self.column_names.include?(key.to_s)
        else
          condition[key] = value if value.present? && self.column_names.include?(key.to_s)
        end
      end
      where(condition)
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)