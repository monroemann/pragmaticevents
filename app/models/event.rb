class Event < ApplicationRecord

	before_validation :generate_slug

	validates :name, :location, presence: true, uniqueness: true
	validates :slug, uniqueness: true
	validates :description, length: {minimum: 5, maximum: 50}
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validates :capacity, numericality: { only_integer: true, greater_than: 0 }
	validates :image_file_name, allow_blank: true, format: {
		with: 	/\w+\.(gif|jpg|png)\z/i,
		message: "Must reference a GIF, JPG, or PNG image"
	}

	has_many :registrations, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :likers, through: :likes, source: :user
	has_many :categorizations, dependent: :destroy
	has_many :categories, through: :categorizations

	def free?
		price.blank? || price.zero?
	end

	scope :past, lambda {where("starts_at < ?", Time.now).order("starts_at")}
	scope :upcoming, lambda {where("starts_at >= ?", Time.now).order("starts_at")}
	scope :free, lambda { upcoming.where(price: 0).order(:name) }
	scope :recent, ->(max=3) { past.limit(max) }

	# def self.past
	# 	where("starts_at < ?", Time.now).order("starts_at")
	# end

	# def self.upcoming
	# 	where("starts_at >= ?", Time.now).order("starts_at")
	# end

	def spots_remaining
		capacity - registrations.size
	end

	def sold_out
		spots_remaining.zero?
	end

	def to_param
		slug
	end

	def generate_slug
		self.slug ||= name.parameterize if name
	end

end
