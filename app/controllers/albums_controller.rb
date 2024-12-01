class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ edit update destroy publish ]

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def edit
    redirect_to albums_path if @album.published?
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      respond_to do |format|
        format.html { redirect_to albums_url, notice: "Album was successfully created." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_album", partial: "albums/form", locals: { album: @album }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to albums_url, notice: "Album was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @album.destroy
        format.html { redirect_to albums_path, notice: "Album was successfully destroyed." }
      else
        format.html { redirect_to albums_path, notice: @album.errors.full_messages.to_sentence }
      end
    end
  end

  def publish
    respond_to do |format|
      if @album.draft?
        @album.published!
        format.html { redirect_to albums_path, notice: "Album has been successfully published." }
      else
          format.html { redirect_to albums_path, notice: "Album is already published." }
      end
    end
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :state, :cover_image)
    end
end
