FactoryBot.define do
  factory :adm_user, class: User do
    name { 'kyokai' }
    password { 'kyokaipw' }
    admin { true }
  end

  factory :normal_user, class: User do
    name { 'ohon' }
    password { 'ohonpw' }
    admin { false }
  end
end