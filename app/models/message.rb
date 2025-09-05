class Message < ApplicationRecord
  belongs_to :user

  after_create_commit :broadcast_message

  private

  def broadcast_message
    # broadcast to a single stream name "messages" and target the message container
    broadcast_append_to "messages", target: "message-display"
  end
end
