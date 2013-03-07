class Product < ActiveRecord::Base
  belongs_to :admin
  has_many :images

  validates :name, :uniqueness => { :scope => :admin_id, :message => "Nombre de producto repetido", :case_sensitive => false }
  validates :name, :admin_id, :description, :price, :inventory, presence: true
<<<<<<< HEAD
  validates :price, :numericality => { :greater_than => 0 }
  validates :inventory, :numericality => { :only_integer => true, :greater_than => -1 }

  accepts_nested_attributes_for :images
=======
  validates :price, :numericality => { :greater_than => 0, :message => "Debe ser una cantidad mayor a 0" }
  validates :inventory, :numericality => { :only_integer => true, :greater_than => -1, :message => "No se permiten cantidades negativas" }
>>>>>>> 41009aac9576980d9a1205f27bf43ec5e952ddfd
end
