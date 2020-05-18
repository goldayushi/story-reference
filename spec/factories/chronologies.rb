FactoryBot.define do
  factory :chronology, class: Chronology do
    year { 500 }
    japan_event { 'overview' }
    korea_event { 'content' }
    china_event { 'set' }
    other_event { 'keyitem' }
  end
end