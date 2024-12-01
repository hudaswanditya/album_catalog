require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "associations" do
    it { is_expected.to have_one_attached(:cover_image) }
    it { is_expected.to have_many(:tracks).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:state).with_values(draft: 0, published: 1) }
  end

  describe "instance methods" do
    describe "#durations" do
      it "returns the total duration of all tracks" do
        album = create(:album)
        create(:track, album: album, duration: 120)
        create(:track, album: album, duration: 180)

        expect(album.durations).to eq(300)
      end
    end
  end

  describe "immutable if published" do
    let!(:published_album) { create(:album, state: :published) }

    context "when album is published" do
      it "does not allow updates" do
        published_album.name = "New Name"
        expect(published_album.save).to be_falsey
        expect(published_album.errors[:base]).to include("Cannot modify a published album.")
      end

      it "does not allow deletion" do
        expect { published_album.destroy }.not_to change(Album, :count)
        expect(published_album.errors[:base]).to include("Cannot delete a published album.")
      end
    end

    context "when album is in draft state" do
      let!(:draft_album) { create(:album, state: :draft) }

      it "allows updates" do
        draft_album.name = "New Name"
        expect(draft_album.save).to be_truthy
      end

      it "allows deletion" do
        expect { draft_album.destroy }.to change(Album, :count).by(-1)
      end
    end
  end
end
