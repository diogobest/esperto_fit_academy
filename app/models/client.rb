class Client < ApplicationRecord
  belongs_to :gym
  belongs_to :plan

  validates :name, :cpf, :email, :gym_id, :plan_id, presence: true
  validates :cpf, uniqueness: true

  enum status: {active: 0, inactive: 1, banished: 9}
end