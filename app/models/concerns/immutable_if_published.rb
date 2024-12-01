module ImmutableIfPublished
  extend ActiveSupport::Concern

  included do
    before_update :prevent_changes_if_published
    before_destroy :prevent_deletion_if_published
  end

  private

  def prevent_changes_if_published
    # Disallow updates if already published
    if respond_to?(:state) && state_was == "published" && state != "published"
      errors.add(:base, "Cannot modify a published album.")
      throw(:abort)
    end

    # Allow changes if transitioning to published state
    return if respond_to?(:state) && state_changed? && state == "published"

    # Prevent other modifications if already published
    if respond_to?(:published?) && published?
      errors.add(:base, "Cannot modify a published album.")
      throw(:abort)
    end
  end

  def prevent_deletion_if_published
    if respond_to?(:published?) && published?
      errors.add(:base, "Cannot delete a published album.")
      throw(:abort)
    end
  end
end
