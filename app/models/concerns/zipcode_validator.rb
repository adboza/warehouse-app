class ZipcodeValidator < ActiveModel::Validator
  def validate(record)
    if record.cep.length < 8
      record.errors.add :base, "There is an error"
    elsif record.cep.length >9
      record.errors.add :base, "There is an error"
    else
      message = "CEP is valid"
    end
  end
  #A ideia seria incluir uma verificação mais apurada... mas acredito que há um jeito melhor
end