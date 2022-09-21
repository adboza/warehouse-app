class ZipcodeValidator < ActiveModel::Validator
  def validate(record)
    if record.cep.length == 9
      %r{[0-9]{5}-[0-9]{3}}.match(record.cep) ? message = "Valid zipcode" : (record.errors.add :base, "Invalid zipcode")
    elsif record.cep.length == 8
      %r{[0-9]{8}}.match(record.cep) ? message = "Valid zipcode" : (record.errors.add :base, "Invalid zipcode")
    elsif record.cep.length < 8
      record.errors.add :base, "Invalid zipcode, small"
    elsif record.cep.length >9
      record.errors.add :base, "Invalid zipcode, large"    
      
    else
      message = "Is it supposed to happen?"
    end
  end
  
end