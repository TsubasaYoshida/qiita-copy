FactoryBot.define do
  factory :draft do
    title {'記事タイトル'}
    tag_names {'Ruby Rails AWS PHP Java'}
    body {'記事本文'}
    type {'post'}
    association :user, factory: :user
  end
end
