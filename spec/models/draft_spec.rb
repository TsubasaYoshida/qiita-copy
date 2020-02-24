require 'rails_helper'

RSpec.describe Draft, type: :model do
  before do
    @draft = build(:draft)
  end

  it '有効' do
    expect(@draft.valid?).to be_truthy
  end

  it '無効：タグが6つ以上ある' do
    @draft.tag_names = 'Ruby Rails AWS PHP Java iPhone'
    expect(@draft.valid?).to be_falsey
  end

  it '無効：タグが重複している' do
    @draft.tag_names = 'Ruby Ruby'
    expect(@draft.valid?).to be_falsey
  end
end
