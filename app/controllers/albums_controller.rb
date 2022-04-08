class AlbumsController < ApplicationController
    before_action :set_user

    def index
        @album = @user.album
        render 'albums/index'
    end
    def show
        @album = Album.find(params[:id])
    end
    
    def new
        @album = Album.new
    end
    def create
        @album = Album.new(album_params)
        @album = @user.album.create(album_params)
        if @album.save
            redirect_to @album
        else
            render :new
        end
    end
    def edit
        @album = Album.find(params[:id])
    end
    def update
        @album = Album.find(params[:id])
        # @album = @user.album.create(album_params)
        if @album.update(album_params)
            redirect_to @album
        else
            render :edit, status: :unprocessable_entity
        end
    end
    def destroy
        @album = Album.find(params[:id])
        @album.destroy

        redirect_to albums_path, status: :see_other
    end
    def delete_album_photos
        attachment = ActiveStorage::Attachment.find(params[:id])
        attachment.purge
        redirect_back(fallback_location: albums_path)
     end
    
    
    private
    def album_params
        params.require(:album).permit(:title, :decription, album_photos: [])
    end
    def set_album
        @album = Album.find(params[:id])
     end
    def set_user
        @user = User.find(current_user.id)
    end
end