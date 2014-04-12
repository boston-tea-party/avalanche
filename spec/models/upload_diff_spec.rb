require 'spec_helper'

describe UploadDiff do
  it 'computes the SHAs we want' do
    upload = create(:upload)
    expected = ['1']
    diff = UploadDiff.new(expected + [upload.sha256])

    actual = diff.missing

    expect(actual).to eq(expected)
  end
end
