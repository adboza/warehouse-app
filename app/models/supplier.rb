class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true, length: { is: 14 }
  #validates :registration_number, length: { is: 14 }
  #validates :registration_number, uniqueness: true
  
end
