class Track < ApplicationRecord
	include ImmutableIfPublished

  belongs_to :album

  validates :title, presence: true
  validates :artist_name, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

	enum state: { draft: 0, published: 1 }

  def published?
    album.published?
  end

  def draft?
    album.draft?
  end
end
