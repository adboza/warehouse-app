require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    within('nav') do
      expect(page).to have_content 'Joao - joao@email.'
    end
  end

  it 'e faz logout' do
    #Arrange
    User.create!(email: 'joao@email.com', password: 'password')
    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'
    #Assert
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'joao@email.com'
  end
end