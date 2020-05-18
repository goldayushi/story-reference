FactoryBot.define do
  factory :character, class: Character do
    name { 'name' }
    role { 'role' }
    position { 'position' }
    countory { 'countory' }
    birthplace { 'birthplace' }
    career { 'career' }
    person { 'person' }
    appearance_chapter { 1 }
  end
end