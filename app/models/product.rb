class Product < ActiveRecord::Base
  attr_accessor :inventory_check
  
  belongs_to :admin
  has_many :images

  validates :name, :admin_id, :description, :price, :inventory, presence: true

  validates :name, :uniqueness => { :scope => :admin_id, :message => "Nombre de producto repetido", :case_sensitive => false }
  
  validates :price, :numericality => { :greater_than => 1, :message => "Precio incorrecto" }

  accepts_nested_attributes_for :images

  validates :price, :numericality => { :greater_than => 0, :message => "Debe ser una cantidad mayor a 0" }
  validates :inventory => { :only_integer => true, :greater_than => -1, :message => "No se permiten cantidades negativas" }

  scope :my_products, -> (admin) { where(:admin_id => admin.id).order(:id) }
  scope :my_product, -> (product_id, admin) { where(:id => product_id, :admin_id => admin.id) }
end
