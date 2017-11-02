class Subscription < ApplicationRecord
  validates :subscriber_id, :feed_id, :title, presence: true
  validates :feed_id, uniqueness: { scope: :subscriber_id }

  before_validation :create_title, on: :create

  # add before creates: default sub name
  def create_title
    self.title = feed.title
  end

  belongs_to :subscriber,
    class_name: "User",
    foreign_key: :subscriber_id,
    primary_key: :id

  belongs_to :feed,
    class_name: "Feed",
    foreign_key: :feed_id,
    primary_key: :id,
    counter_cache: :subscriptions_count

  has_many :stories,
    through: :feed,
    source: :stories

  has_many :collection_assignments,
    foreign_key: :collection_id,
    class_name: :CollectionAssignments

  has_many :collection_id,
    through: :collection_assignments,
    source: :collection

end
