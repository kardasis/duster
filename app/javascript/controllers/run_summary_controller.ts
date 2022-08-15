import { Controller } from '@hotwired/stimulus'
import { Chart } from 'chart.js'
import { formatDuration, round } from '../util'

const element: HTMLElement | null = document.querySelector(
  "[name='csrf-token']"
)
let csrfToken: string

if (element instanceof HTMLMetaElement) {
  csrfToken = element.content
}

export default class extends Controller {
  static targets = [
    'id',
    'distance',
    'totalTime',
    'speed',
    'startTime',
    'calories',
    'intervalDataChart',
  ]

  idTarget: HTMLInputElement
  distanceTarget: HTMLElement
  totalTimeTarget: HTMLElement
  speedTarget: HTMLElement
  startTimeTarget: HTMLElement
  caloriesTarget: HTMLElement
  intervalDataChartTarget: HTMLCanvasElement

  intervalDataChart: Chart

  connect() {
    this.buildIntervalDataChart()
  }
  async setRunSummary(e: CustomEvent) {
    const runSummary = e.detail

    this.idTarget.value = runSummary.id
    this.distanceTarget.innerHTML = round(runSummary.totalDistance)
    this.totalTimeTarget.innerHTML = formatDuration(runSummary.totalTime)
    this.speedTarget.innerHTML = round(runSummary.averageSpeed, 3)
    this.caloriesTarget.innerHTML = runSummary.calories
      ? round(runSummary.calories, 0)
      : '??'

    this.startTimeTarget.innerHTML = new Date(
      runSummary.startTime
    ).toLocaleDateString('en-us', {
      weekday: 'short',
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
    })

    const response = await fetch(`/api/runs/${runSummary.runId}/interval_data`)
    const intervalData = await response.json()
    const speedData = intervalData.map(
      (interval: { time: number; smoothed_speed: number }) => {
        return { x: interval.time, y: interval.smoothed_speed }
      }
    )
    this.intervalDataChart.data.datasets[0].data = speedData
    this.intervalDataChart.update()
  }

  buildIntervalDataChart() {
    this.intervalDataChart = new Chart(this.intervalDataChartTarget, {
      type: 'scatter',
      data: {
        datasets: [
          {
            fill: {
              value: 0,
            },
            data: [],
            borderColor: 'rgba(66, 66, 66, 1)',
            borderWidth: 1,
            showLine: true,
          },
        ],
      },
      options: {
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
        },
        elements: {
          point: { radius: 0 },
        },
      },
    })
  }

  async delete_summary() {
    if (confirm('Really delete this run?') == true) {
      await fetch(`/run_summaries/${this.idTarget.value}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': csrfToken,
          'Content-type': 'application/json',
        },
      })
      this.element.remove()
    }
  }
}
