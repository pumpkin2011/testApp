class Contact < ActiveRecord::Base
  validates_presence_of :firstname
end
