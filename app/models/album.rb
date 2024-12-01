class Album < ApplicationRecord
	include ImmutableIfPublished

	has_one_attached :cover_image
	has_many :tracks, dependent: :destroy

	enum state: { draft: 0, published: 1 }

  validates :name, presence: true

	def durations
		tracks.sum(:duration)
	end
end
