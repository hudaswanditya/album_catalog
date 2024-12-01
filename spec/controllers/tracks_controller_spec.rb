require 'rails_helper'

RSpec.describe TracksController, type: :controller do
  let(:album) { create(:album) }
  let(:valid_attributes) { attributes_for(:track, album_id: album.id) }
  let(:invalid_attributes) { { title: nil, artist_name: nil } }
  let!(:track) { create(:track, album: album) }

  describe "GET #new" do
    it "assigns a new track as @track" do
      get :new, params: { album_id: album.id }
      expect(assigns(:track)).to be_a_new(Track)
      expect(assigns(:track).album).to eq(album)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new track" do
        expect {
          post :create, params: { album_id: album.id, track: valid_attributes }
        }.to change(Track, :count).by(1)
      end

      it "redirects to the new track page" do
        post :create, params: { album_id: album.id, track: valid_attributes }
        expect(response).to redirect_to(new_album_track_path(album))
      end
    end

    context "with invalid parameters" do
      it "does not create a new track" do
        expect {
          post :create, params: { album_id: album.id, track: invalid_attributes }
        }.not_to change(Track, :count)
      end

      it "renders the :new template" do
        post :create, params: { album_id: album.id, track: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested track as @track" do
      get :edit, params: { album_id: album.id, id: track.id }
      expect(assigns(:track)).to eq(track)
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested track" do
        patch :update, params: { album_id: album.id, id: track.id, track: { title: "Updated Title" } }
        track.reload
        expect(track.title).to eq("Updated Title")
      end

      it "redirects to the album edit page" do
        patch :update, params: { album_id: album.id, id: track.id, track: { title: "Updated Title" } }
        expect(response).to redirect_to(edit_album_path(album))
      end
    end

    context "with invalid parameters" do
      it "does not update the track" do
        patch :update, params: { album_id: album.id, id: track.id, track: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested track" do
      expect {
        delete :destroy, params: { album_id: album.id, id: track.id }
      }.to change(Track, :count).by(-1)
    end

    it "redirects to the album show page" do
      delete :destroy, params: { album_id: album.id, id: track.id }
      expect(response).to redirect_to(album_path(album))
    end
  end
end
