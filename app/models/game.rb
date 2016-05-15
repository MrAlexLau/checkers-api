class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :users, :length => {:minimum => 2, :message=>"Invalid players" }

  alias_method :players, :users

  # TODO: update this to include user names as well
  def title
    "#{self.id}"
  end


end
