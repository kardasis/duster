import consumer from "channels/consumer"

console.log("setting up run channel")
const view = document.getElementById('live-run-view')
const title = document.getElementById('title')

let subscription 

if (view) {
  unsetRunId()
}


function subscribeToGeneral() {
  subscription = consumer.subscriptions.create({ channel: "RunChannel"}, {
    connected() {
      console.log('connected')
    },

    disconnected() {
      console.log('disconnected')
    },

    received(data) {
      if (data.msg == 'run_started') {
        setRunId(data.runId)
      }
    }
  })
}

function setRunId(id) {
  subscription.unsubscribe()
  title.innerHTML = "You are running"
  subscribeToRun(id)
  view.style.display = 'flex'
  title.style.display = 'none'
}

function unsetRunId() {
  subscription && subscription.unsubscribe()
  title.innerHTML = "Whenever you're ready"
  subscribeToGeneral()
  view.style.display = 'none'
  title.style.display = 'block'
}

function subscribeToRun(id) {
  subscription = consumer.subscriptions.create({ channel: "RunChannel", run_id: id}, {
    connected() {
      console.log(`connected to run: ${id}`)
    },

    disconnected() {
      console.log(`disconnected from run: ${id}`)
    },

    received(data) {
      const total_time = data.total_time
      const total_distance = data.total_distance

const time = document.getElementById('total_time')
      time.innerHTML = total_time
const distance = document.getElementById('total_distance')
      distance.innerHTML = total_distance

    }
  })
}


