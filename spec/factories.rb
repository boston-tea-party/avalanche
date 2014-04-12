include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :upload do
    document { fixture_file_upload(fixture_file('hate-crime.jpg')) }
    signature { fixture_file('signature').read }
    public_key { fixture_file('public_key').read }
  end
end

def fixture_file(filename)
  Rails.root.join('spec', 'fixtures', filename)
end
