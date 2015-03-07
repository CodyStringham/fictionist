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
#  id              :integer          not null, primary key
#  content_type    :string
#  message         :string
#  location        :string
#  published_at    :datetime
#  view_permission :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
