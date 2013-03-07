class Product < ActiveRecord::Base
  belongs_to :admin
  has_many :images

  validates :name, :uniqueness => { :scope => :admin_id, :message => "Nombre de producto repetido", :case_sensitive => false }
  validates :name, :admin_id, :description, :price, :inventory, presence: true
  validates :price, :numericality => { :greater_than => 0, :message => "Debe ser una cantidad mayor a 0" }
  validates :inventory, :numericality => { :only_integer => true, :greater_than => -1, :message => "No se permiten cantidades negativas" }
end