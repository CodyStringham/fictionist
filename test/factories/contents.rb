FactoryGirl.define do
  factory :content do
    content_type "MyString"
message "MyString"
location "MyString"
user nil
published_at "2015-03-07 15:11:21"
view_permission 1
  end

end

# == Schema Information
#
# Table name: contents
#
#  id                 :integer          not null, primary key
#  asset_type         :string           not null
#  message            :string           not null
#  location           :string
#  published_at       :datetime
#  view_permission    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  asset_file_name    :string
#  asset_content_type :string
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#  uploader_id        :integer
#  value              :integer
#
