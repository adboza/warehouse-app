class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :city, :full_address, :email, :state, presence: true
end
