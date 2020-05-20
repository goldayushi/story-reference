# frozen_string_literal: true

FactoryBot.define do
  factory :adm_user, class: 'User' do
    name { 'kyokai' }
    password { 'kyokaipw' }
    admin { true }
  end

  factory :normal_user, class: 'User' do
    name { 'ohon' }
    password { 'ohonpw' }
    admin { false }
  end

  factory :normal_user_2, class: 'User' do
    name { 'moten' }
    password { 'motenpw' }
    admin { false }
  end
end
