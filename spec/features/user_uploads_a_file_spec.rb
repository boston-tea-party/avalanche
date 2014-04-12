require 'spec_helper'

feature 'user uploads a file', javascript: true do
  scenario 'User wants to upload a file from the browser' do
    visit root_url
    key_id = attach_private_key
    attach_public_key
    attach_file 'upload_document', fixture('hate-crime.jpg')
    click_button 'Upload'

    expect(page).to have_css('img[data-sha="41d91af84653a38245c2b29a43bbd308445ea941c425e68e3880d577cc4420df"]')
    expect(page).to have_css(%{img[data-keyid="#{key_id}"]})
  end

  private

  def attach_private_key
      armored_private_key = fixture('private_key').read
      fill_in 'private-key-text', with: armored_private_key
      click_button 'submit-private-key'
      key_id(armored_private_key)
  end

  def attach_public_key
      armored_public_key = fixture('public_key').read
      fill_in 'public-key-text', with: armored_public_key
      click_button 'submit-public-key'
  end

  def key_id(armored_private_key)
      "DE2CB69C"
  end

  def fixture(file_name)
    Rails.root.join('spec', 'fixtures', file_name)
  end
end
