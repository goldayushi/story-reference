# frozen_string_literal: true

FactoryBot.define do
  factory :episode, class: Episode do
    chapter { 1 }
    title { 'title' }
    overview { 'overview' }
    content { 'content' }
    set { 'set' }
    keyitem { 'keyitem' }
    division { 'division' }
    year { 500 }
  end
end
