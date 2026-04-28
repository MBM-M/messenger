class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      # Respond with Turbo Stream for the submitter
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      # Handle validation errors
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("message-form", partial: "shared/error_message") }
        format.html { redirect_to root_path, alert: "Message could not be sent" }
      end
    end
  end

  private

  def message_params
    params.expect(message: [ :body ])
  end
end
