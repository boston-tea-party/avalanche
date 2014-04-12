class ChecksController < ApplicationController
  def create
    render json: { shas: desired_shas }
  end

  private

  def desired_shas
    UploadDiff.new(params[:shas]).missing
  end
end
