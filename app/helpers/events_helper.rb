module EventsHelper

	def format_price(event)
		if event.free?
			return content_tag(:strong, "Free!")
		else
			return number_to_currency(event.price)
		end 
	end	

	def image_for(event)
		if event.image_file_name.blank?
			image_tag "https://source.unsplash.com/random", :size => "260x180"
		else
			image_tag event.image_file_name, :size => "260x180"
		end
	end

end
