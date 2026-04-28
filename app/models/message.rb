class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 1000 }

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "messages", target: "message-display"
  end
end
