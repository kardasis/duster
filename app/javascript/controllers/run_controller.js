import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js';

import {subscribeToRun, subscribeToGeneral} from '../channels/run_channel'

Chart.register(...registerables);


export default class extends Controller {
  static targets = [ "chart", "title", "dashboard"]
  connect() {
    this.intervalData = []
    this.runId = this.dashboardTarget.dataset.run_id

    this.initChart()
    this.setRunId()
  }


  setRunId(id=null) {
    this.runId ||= id
    this.subscription?.unsubscribe()

    if (this.runId) {
      this.titleTarget.innerHTML = "You are running"
      this.subscription = subscribeToRun(this.runId, this.updateData.bind(this))
      this.dashboardTarget.style.display = 'flex'
      this.titleTarget.style.display = 'none'
    } else {
      this.titleTarget.innerHTML = "Whenever you're ready"
      this.subscription = subscribeToGeneral((data) => this.setRunId(data.runId))
      this.dashboardTarget.style.display = 'none'
      this.titleTarget.style.display = 'block'
    }
  }

  updateData(data) {
    for(var key in data.stats) {
      const elem = document.getElementById(key)
      if (elem) {
        elem.innerHTML = data.stats[key]
      }
    }

    const intervalDataXY = data.intervalTicks.map(d => {
      return {x: d[0], y: d[1]}
    })
    this.intervalData = this.intervalData.concat(intervalDataXY)
    if (this.intervalData.length > 600) {
      this.intervalData = this.intervalData.slice(-600, -1)
    }

    this.chart.data.datasets[0].data = this.intervalData
    this.chart.update()
  }

  initChart() {
    this.chart = new Chart(this.chartTarget, {
      type: 'scatter',
      data: { datasets: [{ data: [] }] },
      options: chartOptions
    });
  }
}

const chartOptions = {
  maintainAspectRatio: false,
  scales: {
    xAxis: {
      ticks: {
        stepSize: 1,
        autoSkip: false,
        callback: function(value) {
          if (value % 30 !== 0) {
            return undefined
          } else {
            const time = Math.round(value)
            const s = time % 60
            const m = (time - s) / 60
            return `${m.toString()}:${s.toString().padStart(2, '0')}`
          }
        }
      }
    }
  }
}


