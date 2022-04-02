class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true
  validates :introduction, presence: true

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
end
