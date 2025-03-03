require 'rails_helper'

describe 'API consult CPF' do
  it 'successfully' do
    # arrange
    admin = create(:employee, admin: true)    
    client = create(:client, cpf: '12312312300', status: :banished)

    # act
    sign_in admin
    get "/api/v1/clients/consult_cpf/#{client.cpf}"

    # assert
    expect(response.status).to eq 302
    expect(response.body).to include(client.cpf)
    expect(response.body).to include(client.status)
    expect(response.body).not_to include(client.name)
  end

  it 'and CPF must exit' do
    admin = create(:employee, admin: true)

    # act
    sign_in admin
    get '/api/v1/clients/consult_cpf/000'

    # assert
    expect(response.status).to eq 404
    expect(response.body).to include('CPF não encontrado')
  end
end
