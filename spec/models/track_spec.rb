require 'rails_helper'

RSpec.describe Track, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:album) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:artist_name) }
    it { is_expected.to validate_numericality_of(:duration).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe "instance methods" do
    let(:draft_album) { create(:album, state: :draft) }
    let(:published_album) { create(:album, state: :published) }
    let(:track) { create(:track, album: draft_album) }

    describe "#published?" do
      it "returns true if the associated album is published" do
        track.album = published_album
        expect(track.published?).to be_truthy
      end

      it "returns false if the associated album is not published" do
        expect(track.published?).to be_falsey
      end
    end

    describe "#draft?" do
      it "returns true if the associated album is a draft" do
        expect(track.draft?).to be_truthy
      end

      it "returns false if the associated album is not a draft" do
        track.album = published_album
        expect(track.draft?).to be_falsey
      end
    end
  end

  describe "immutable if published" do
    let!(:published_album) { create(:album, state: :published) }
    let!(:track) { create(:track, album: published_album) }

    context "when track belongs to a published album" do
      it "does not allow updates" do
        track.title = "New Title"
        expect(track.save).to be_falsey
        expect(track.errors[:base]).to include("Cannot modify a published album.")
      end

      it "does not allow deletion" do
        expect { track.destroy }.not_to change(Track, :count)
        expect(track.errors[:base]).to include("Cannot delete a published album.")
      end
    end

    context "when track belongs to a draft album" do
      let!(:draft_album) { create(:album, state: :draft) }
      let!(:track) { create(:track, album: draft_album) }

      it "allows updates" do
        track.title = "New Title"
        expect(track.save).to be_truthy
      end

      it "allows deletion" do
        expect { track.destroy }.to change(Track, :count).by(-1)
      end
    end
  end
end
