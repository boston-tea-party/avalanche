include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :upload do
    document { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'hate-crime.jpg')) }
  end
end
