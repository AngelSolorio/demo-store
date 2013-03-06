class Image < ActiveRecord::Base
	belongs_to :product	
	
	accepts_nested_attributes_for :product, :reject_if => :all_blank

	has_attached_file :image, styles: { medium: '200x200>', thumb: '48x48>' }

	validates_attachment :image, size: { less_than: 501.kilobytes }, content_type: { content_type: 'image/jpeg' }
end
