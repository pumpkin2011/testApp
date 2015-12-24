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

class Contact < ActiveRecord::Base
  has_many :phones
  accepts_nested_attributes_for :phones
  validates_presence_of :firstname

  scope :by_letter, -> (letter) { where('lastname LIKE ?', "#{letter}%").order(:lastname) }

  def name
    "#{firstname} #{lastname}"
  end

end
