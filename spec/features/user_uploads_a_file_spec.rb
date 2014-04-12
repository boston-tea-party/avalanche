require 'spec_helper'

feature 'user uploads a file' do
  scenario 'User wants to upload a file from the browser' do
    visit root_url
    attach_file 'upload_document', fixture('hate-crime.jpg')
    click_button 'Upload'

    expect(page).to have_content('Thank you')
  end

  private

  def fixture(file_name)
    Rails.root.join('spec', 'fixtures', file_name)
  end
end
