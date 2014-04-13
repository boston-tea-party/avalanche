class UploadsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    @upload = Upload.new
    @uploads = Upload.all
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.save
    redirect_to root_url
    Thread.new { rebroadcast @upload }
  end

  private

  def upload_params
    params.require(:upload).permit(:document)
  end

  def rebroadcast(upload)
    Peer.all.each do |peer|
      DocumentUpdater.new(peer.target, peer.port).update
    end
  end
end
