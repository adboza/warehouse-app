#este teste é lento!
def login(usuario)
  click_on 'Entrar'
  within('form') do
    fill_in 'Nome', with: usuario.name
    fill_in 'E-mail', with: usuario.email
    fill_in 'Senha', with: usuario.password
    click_on 'Entrar'
  end
end