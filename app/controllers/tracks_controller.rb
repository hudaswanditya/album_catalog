class TracksController < ApplicationController
  before_action :set_album
  before_action :set_track, only: [:edit, :update, :destroy]

  def new
    @track = @album.tracks.new
  end

  def create
    @track = @album.tracks.new(track_params)
    if @track.save
      respond_to do |format|
        format.html { redirect_to new_album_track_path(@album), notice: "Track was successfully created." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_track", partial: "tracks/form", locals: { track: @track }) }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to edit_album_path(@track.album), notice: "Track was successfully updated." }
      else
        format.html { redirect_to edit_album_path(@track.album), notice: @track.album.errors.full_messages.to_sentence }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @track.destroy
        format.html { redirect_to edit_album_path(@track.album), notice: "Track was successfully destroyed." }
      else
        format.html { redirect_to edit_album_path(@track.album), notice: @track.album.errors.full_messages.to_sentence }
      end
    end
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_track
    @track = @album.tracks.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:title, :artist_name, :duration)
  end
end
