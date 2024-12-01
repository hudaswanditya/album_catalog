# spec/models/concerns/immutable_if_published_spec.rb
require 'rails_helper'

RSpec.describe ImmutableIfPublished, type: :model do
  let(:album) { create(:album, state: :draft) }

  describe 'before_update' do
    context 'when the album is published' do
      before do
        album.update(state: :published)
      end

      it 'prevents updates' do
        expect(album.update(state: :draft)).to be_falsey
        expect(album.errors[:base]).to include("Cannot modify a published album.")
      end
    end

    context 'when the album is in draft state' do
      it 'allows updates' do
        expect(album.update(state: :published)).to be_truthy
      end
    end
  end

  describe 'before_destroy' do
    context 'when the album is published' do
      before do
        album.update(state: :published)
      end

      it 'prevents deletion' do
        expect(album.destroy).to be_falsey
        expect(album.errors[:base]).to include("Cannot delete a published album.")
      end
    end

    context 'when the album is in draft state' do
      it 'allows deletion' do
        album.update(state: :draft)
        expect(album.destroy).to be_truthy
      end
    end
  end
end
