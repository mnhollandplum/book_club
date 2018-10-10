require 'rails_helper'

describe Review, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:explanation)}
    it {should validate_presence_of(:score)}

  end

  describe 'relationships' do
    it { should belong_to(:user)}
  end
end

# ex: it { should belong_to(:artist) } it { should have_many(:playlist_songs) } it { should have_many(:playlists).through(:playlist_songs) }
