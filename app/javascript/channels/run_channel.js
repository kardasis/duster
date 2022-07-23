import consumer from "channels/consumer"
export function subscribeToGeneral(runStartedCallback) {
  return consumer.subscriptions.create({ channel: "RunChannel"}, {
    connected() {
      console.log('connected')
    },

    disconnected() {
      console.log('disconnected')
    },

    received(data) {
      if (data.msg == 'run_started') {
        runStartedCallback(data)
      }
    }
  })
}

export function subscribeToRun(id, receivedDataCallback) {
  return consumer.subscriptions.create({ channel: "RunChannel", run_id: id}, {
    connected() {
      console.log("connected to run channel")
    },

    disconnected() {
      console.log(`disconnected from run: ${id}`)
    },

    received(data) {
      receivedDataCallback(data)
    }
  })
}
