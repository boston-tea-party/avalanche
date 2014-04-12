class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.save
    redirect_to root_url, notice: 'Thank you'
  end

  private

  def upload_params
    params.require(:upload).permit(:document)
  end
end
