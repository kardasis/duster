import consumer from "./consumer"

type GeneralMessage = {msg: string, runId: string}
type RunMessage = {msg: string}

export function subscribeToGeneral(runStartedCallback: (arg0: GeneralMessage) => void) {
  return consumer.subscriptions.create({ channel: "RunChannel"}, {
    received(data: GeneralMessage) {
      if (data.msg == 'run_started') {
        runStartedCallback(data)
      }
    }
  })
}

export function subscribeToRun(id: string, receivedDataCallback: (arg0: RunMessage) => void) {
  return consumer.subscriptions.create({ channel: "RunChannel", run_id: id}, {
    received(data: RunMessage) {
      receivedDataCallback(data)
    }
  })
}
