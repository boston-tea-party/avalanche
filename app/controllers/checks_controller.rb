class ChecksController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    render json: { shas: desired_shas }
  end

  private

  def desired_shas
    UploadDiff.new(params[:shas]).missing
  end
end
