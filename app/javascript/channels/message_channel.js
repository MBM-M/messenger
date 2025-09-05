import consumer from "./consumer"

const messageChannel = consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("-------------------------Connected to channel-------------------------");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("-------------------------Disonnected to channel-------------------------");
  },

  received(data) {
    console.log("-------------------------Received Data-------------------------");
    const messageDisplay = document.querySelector("#message-display")
    messageDisplay.insertAdjacentHTML("beforeend", this.template(data))
  },

  template(data) {
    return `<article class="message">
              <div class="message-header">
                <p>${data.email}</p>
              </div>
              <div class="message-body">
                <p>${data.body}</p>
              </div>
            </article>`
  }
});