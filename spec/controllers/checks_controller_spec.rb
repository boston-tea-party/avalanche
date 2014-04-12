require 'spec_helper'

describe ChecksController do
  it 'responds with the list of desired SHAs' do
    upload = create(:upload)
    desired_shas = %w(1 2 3)
    available_shas = desired_shas + [upload.sha256]

    post :create, { shas: available_shas }.as_json

    expect(json_response).to eq({shas: desired_shas}.as_json)
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
