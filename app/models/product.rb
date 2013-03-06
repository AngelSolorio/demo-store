class Product < ActiveRecord::Base
	belongs_to :admin
	has_many :images
	
	validates :name, :uniqueness => { :scope => :admin_id, :message => "Nombre de producto repetido", :case_sensitive => false }
	validates :name, :admin_id, :description, :price, :inventory, :active, presence: true
	validates :price, :numericality => { :greater_than => 0 }

end