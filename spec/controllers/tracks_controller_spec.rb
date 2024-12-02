require 'rails_helper'

RSpec.describe TracksController, type: :controller do
  let(:album) { create(:album) }
  let(:track) { create(:track, album: album) }

  describe "GET #new" do
    it "assigns a new track as @track" do
      get :new, params: { album_id: album.id }
      expect(assigns(:track)).to be_a_new(Track)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { attributes_for(:track) }

      it "creates a new Track" do
        expect {
          post :create, params: { album_id: album.id, track: valid_attributes }
        }.to change(Track, :count).by(1)
      end

      it "redirects to the new track path" do
        post :create, params: { album_id: album.id, track: valid_attributes }
        expect(response).to redirect_to(new_album_track_path(album))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: nil, artist_name: nil } }

      it "does not create a new Track" do
        expect {
          post :create, params: { album_id: album.id, track: invalid_attributes }
        }.not_to change(Track, :count)
      end

      it "renders the new template with unprocessable entity status" do
        post :create, params: { album_id: album.id, track: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
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
    let(:new_attributes) { { title: "Updated Title" } }

    context "with valid parameters" do
      it "updates the requested track" do
        patch :update, params: { album_id: album.id, id: track.id, track: new_attributes }
        track.reload
        expect(track.title).to eq("Updated Title")
      end

      it "redirects to the edit album path" do
        patch :update, params: { album_id: album.id, id: track.id, track: new_attributes }
        expect(response).to redirect_to(edit_album_path(album))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: nil } }

      it "does not update the track" do
        patch :update, params: { album_id: album.id, id: track.id, track: invalid_attributes }
        track.reload
        expect(track.title).not_to be_nil
      end

      it "redirects to the edit album path with an error message" do
        patch :update, params: { album_id: album.id, id: track.id, track: invalid_attributes }
        expect(response).to redirect_to(edit_album_path(album))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested track" do
      track_to_delete = create(:track, album: album)
      expect {
        delete :destroy, params: { album_id: album.id, id: track_to_delete.id }
      }.to change(Track, :count).by(-1)
    end

    it "redirects to the edit album path" do
      delete :destroy, params: { album_id: album.id, id: track.id }
      expect(response).to redirect_to(edit_album_path(album))
    end
  end
end
