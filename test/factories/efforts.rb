# == Schema Information
#
# Table name: efforts
#
#  id                 :integer          not null, primary key
#  type               :integer
#  value              :integer
#  status             :integer
#  proof_file_name    :string
#  proof_content_type :string
#  proof_file_size    :integer
#  proof_updated_at   :datetime
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :effort do
    type 1
status 1
user nil
value 1
  end

end
