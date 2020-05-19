# frozen_string_literal: true

FactoryBot.define do
  factory :chronology, class: Chronology do
    year { 500 }
    japan_event { 'japan_event' }
    korea_event { 'korea_event' }
    china_event { 'china_event' }
    other_event { 'other_event' }
  end
end
