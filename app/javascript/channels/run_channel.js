import consumer from "channels/consumer"

console.log("setting up run channel")
const view = document.getElementById('live-run-view')
if (view) {
  const run_id = view.dataset.run_id

  consumer.subscriptions.create({ channel: "RunChannel", run_id: run_id}, {
    connected() {
      console.log('connected')
    },

    disconnected() {
      console.log('disconnected')
    },

    received(data) {
      console.log(JSON.stringify(data))
    }
  })
}

