module ApplicationHelper
	def seconds_to_minutes(seconds)
		minutes = seconds / 60
		remaining_seconds = seconds % 60
		"#{minutes}:#{format('%02d', remaining_seconds)}"
	end

	def album_cover_image(album, size: "max-w-32")
    if album.cover_image.attached?
      image_tag(album.cover_image, class: size)
    else
      image_tag("https://placehold.co/400", class: size)
    end
  end
end
