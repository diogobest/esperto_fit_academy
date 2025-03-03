feature 'admin can remove gym' do
  scenario 'successfully' do
    create(:gym, name: 'Academia Paulista')
    create(:gym, name: 'Academia Madalena')
    create(:gym, name: 'Academia Consolação')
    create(:gym, name: 'Academia Oscar Freire')
    employee = create(:employee, admin: true)
    login_as(employee)

    visit root_path
    click_on 'Listas'
    click_on 'Lista de Academias'
    click_on 'Academia Oscar Freire'
    click_on 'Remover'
    
    expect(page).to have_content('Academia removido com sucesso')
  end
end