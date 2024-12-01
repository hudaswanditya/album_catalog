require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#seconds_to_minutes" do
    it "converts seconds to minutes and seconds format" do
      expect(helper.seconds_to_minutes(0)).to eq("0:00")
      expect(helper.seconds_to_minutes(30)).to eq("0:30")
      expect(helper.seconds_to_minutes(90)).to eq("1:30")
      expect(helper.seconds_to_minutes(150)).to eq("2:30")
      expect(helper.seconds_to_minutes(360)).to eq("6:00")
    end
  end

  describe "#album_cover_image" do
    let(:album_with_cover) { create(:album, cover_image: fixture_file_upload('test_image.jpg')) }
    let(:album_without_cover) { create(:album) }

    context "when album has a cover image" do
      it "returns an image_tag for the album cover" do
        expect(helper.album_cover_image(album_with_cover)).to match(/<img .*src=".*\.jpg".*\/>/)
      end
    end

    context "when album does not have a cover image" do
      it "returns a placeholder image" do
        expect(helper.album_cover_image(album_without_cover)).to match(/<img .*src="https:\/\/placehold.co\/400".*\/>/)
      end
    end

    context "when custom size is provided" do
      it "returns an image tag with the provided size class" do
        expect(helper.album_cover_image(album_with_cover, size: "max-w-64")).to match(/class="max-w-64"/)
      end
    end
  end
end
