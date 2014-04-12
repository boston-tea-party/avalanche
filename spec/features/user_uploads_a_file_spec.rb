require 'spec_helper'

feature 'user uploads a file' do
  scenario 'User wants to upload a file from the browser' do
    visit root_url
    attach_file 'upload_document', fixture('hate-crime.jpg')
    click_button 'Upload'

    expect(page).to have_css('img[data-sha="41d91af84653a38245c2b29a43bbd308445ea941c425e68e3880d577cc4420df"]')

  end

  private

  def fixture(file_name)
    Rails.root.join('spec', 'fixtures', file_name)
  end
end
