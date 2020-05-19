# frozen_string_literal: true

FactoryBot.define do
  factory :glossary, class: Glossary do
    title { 'title' }
    content { 'content' }
    chapter { 5 }
  end
end
