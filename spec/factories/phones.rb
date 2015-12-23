# == Schema Information
#
# Table name: phones
#
#  id         :integer          not null, primary key
#  contact_id :integer
#  phone      :string
#  phone_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :phone do
    association :contact
    phone '123-456-78901'

    factory :home_phone do
      phone_type 'home'
    end

    factory :work_phone do
      phone_type 'work'
    end

    factory :mobile_phone do
      phone_type 'mobile'
    end
  end
end
