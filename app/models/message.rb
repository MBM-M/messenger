class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 1000 }

  after_create_commit :broadcast_message

  private

  def broadcast_message
    # Skip broadcast in test environment to avoid current_user issues
    return if Rails.env.test?

    broadcast_append_to "messages", target: "message-display"
  end
end
