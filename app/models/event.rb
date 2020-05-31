class Event < ApplicationRecord

	validates :name, :location, presence: true
	validates :description, length: {minimum: 5, maximum: 50}
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validates :capacity, numericality: { only_integer: true, greater_than: 0 }
	validates :image_file_name, allow_blank: true, format: {
		with: 	/\w+\.(gif|jpg|png)\z/i,
		message: "Must reference a GIF, JPG, or PNG image"
	}

	has_many :registrations, dependent: :destroy

	def free?
		price.blank? || price.zero?
	end

	def self.upcoming
		where("starts_at >= ?", Time.now).order("starts_at")
	end

	def spots_remaining
		capacity - registrations.size
	end

	def sold_out
		spots_remaining.zero?
	end

end
