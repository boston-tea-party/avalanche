require 'spec_helper'

describe Upload do
  it { should have_attached_file(:document) }

  it 'has a sha' do
    upload = create(:upload)
    expected_sha = '41d91af84653a38245c2b29a43bbd308445ea941c425e68e3880d577cc4420df'
    expect(upload.sha256).to eq expected_sha
  end
end
