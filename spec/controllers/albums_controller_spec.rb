require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  let(:valid_attributes) { attributes_for(:album) }
  let(:invalid_attributes) { { name: nil } }
  let!(:album) { create(:album) }

  describe "GET #index" do
    it "assigns all albums as @albums" do
      get :index
      expect(assigns(:albums)).to eq([album])
    end
  end

  describe "GET #new" do
    it "assigns a new album as @album" do
      get :new
      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe "GET #edit" do
    context "when album is draft" do
      it "assigns the requested album as @album" do
        get :edit, params: { id: album.to_param }
        expect(assigns(:album)).to eq(album)
      end
    end

    context "when album is published" do
      let!(:published_album) { create(:album, state: :published) }

      it "redirects to albums path" do
        get :edit, params: { id: published_album.to_param }
        expect(response).to redirect_to(albums_path)
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new album" do
        expect {
          post :create, params: { album: valid_attributes }
        }.to change(Album, :count).by(1)
      end

      it "redirects to the albums list" do
        post :create, params: { album: valid_attributes }
        expect(response).to redirect_to(albums_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new album" do
        expect {
          post :create, params: { album: invalid_attributes }
        }.not_to change(Album, :count)
      end

      it "renders the :new template" do
        post :create, params: { album: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested album" do
        patch :update, params: { id: album.to_param, album: { name: "Updated Name" } }
        album.reload
        expect(album.name).to eq("Updated Name")
      end

      it "redirects to the albums list" do
        patch :update, params: { id: album.to_param, album: { name: "Updated Name" } }
        expect(response).to redirect_to(albums_path)
      end
    end

    context "with invalid parameters" do
      it "does not update the album" do
        patch :update, params: { id: album.to_param, album: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when the album is draft" do
      it "destroys the requested album" do
        expect {
          delete :destroy, params: { id: album.to_param }
        }.to change(Album, :count).by(-1)
      end

      it "redirects to the albums list" do
        delete :destroy, params: { id: album.to_param }
        expect(response).to redirect_to(albums_path)
      end
    end

    context "when the album is published" do
      let!(:published_album) { create(:album, state: :published) }

      it "does not destroy the album" do
        expect {
          delete :destroy, params: { id: published_album.to_param }
        }.not_to change(Album, :count)
      end

      it "redirects to the albums list with an error message" do
        delete :destroy, params: { id: published_album.to_param }
        expect(response).to redirect_to(albums_path)
        expect(flash[:notice]).to eq("Cannot delete a published album.")
      end
    end
  end

  describe "PATCH #publish" do
    context "when the album is draft" do
      it "publishes the album" do
        patch :publish, params: { id: album.to_param }
        album.reload
        expect(album.published?).to be_truthy
      end

      it "redirects to the albums list with a success message" do
        patch :publish, params: { id: album.to_param }
        expect(response).to redirect_to(albums_path)
        expect(flash[:notice]).to eq("Album has been successfully published.")
      end
    end

    context "when the album is already published" do
      let!(:published_album) { create(:album, state: :published) }

      it "does not change the album state" do
        patch :publish, params: { id: published_album.to_param }
        published_album.reload
        expect(published_album.published?).to be_truthy
      end

      it "redirects to the albums list with a notice message" do
        patch :publish, params: { id: published_album.to_param }
        expect(response).to redirect_to(albums_path)
        expect(flash[:notice]).to eq("Album is already published.")
      end
    end
  end
end
