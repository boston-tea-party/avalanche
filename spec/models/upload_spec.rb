require 'spec_helper'

describe Upload do
  it { should have_attached_file(:document) }

  it 'has a sha' do
    upload = create(:upload)
    expected_sha = '41d91af84653a38245c2b29a43bbd308445ea941c425e68e3880d577cc4420df'
    expect(upload.sha256).to eq expected_sha
  end

  it 'has a key id' do
    upload = create(:upload)
    expect(upload.keyid).to eq keyid
  end

  it 'persists key to keyring' do
    remove_public_key_from_keyring
    upload = create(:upload)
    expect(public_key_in_keyring).to be_present
  end

  private

  let(:keyid){'4267CE548708EFB3'}

  def remove_public_key_from_keyring
      if public_key_in_keyring.present?
        GPGME::Ctx.new do |ctx|
           ctx.delete_key(public_key_in_keyring.first)
        end
      end
  end

  def public_key_in_keyring
      GPGME::Key.find(:public, %{0x#{keyid}})
  end
end
