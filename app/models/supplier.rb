class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true, length: { is: 14 }
  
  def full_description
    "#{brand_name} - #{corporate_name} - CNPJ: #{registration_number}"
  end
  
end
