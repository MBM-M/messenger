class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(message_params)
    @message.save
    ActionCable.server.broadcast("message", @message.as_json(include: :user))

    # redirect_to messages_path(@message)
  end

  private

  def message_params
    params.expect(message: [ :body ])
  end
end
