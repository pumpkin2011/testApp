# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  firstname  :string
#  lastname   :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :contact do
    firstname "Justin"
    lastname "Beaver"
    email "beaver@mail.com"

    factory :invalid_contact do
      firstname nil
      lastname nil
    end

    after(:build) do |contact|
      [:home_phone, :work_phone, :mobile_phone].each do |phone|
          contact.phones << FactoryGirl.build(:phone, phone_type: phone, contact: contact)
      end
    end
  end
end
