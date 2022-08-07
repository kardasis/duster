import { Controller } from '@hotwired/stimulus'
import { formatDuration, round } from '../util'

const element: HTMLElement | null = document.querySelector(
  "[name='csrf-token']"
)
let csrfToken: string

if (element instanceof HTMLMetaElement) {
  csrfToken = element.content
}

export default class extends Controller {
  idTarget: HTMLInputElement
  distanceTarget: HTMLInputElement
  totalTimeTarget: HTMLInputElement
  speedTarget: HTMLInputElement
  startTimeTarget: HTMLInputElement

  static targets = ['id', 'distance', 'totalTime', 'speed', 'startTime']

  setRunSummary(e: CustomEvent) {
    const runSummary = e.detail
    this.idTarget.value = runSummary.run_id
    this.distanceTarget.innerHTML = round(runSummary.totalDistance)
    this.totalTimeTarget.innerHTML = formatDuration(runSummary.totalTime)
    this.speedTarget.innerHTML = round(runSummary.averageSpeed, 3)
    this.startTimeTarget.innerHTML = new Date(
      runSummary.startTime
    ).toLocaleDateString('en-us', {
      weekday: 'short',
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
    })
  }

  async duplicate_summary() {
    if (confirm('Make a new one like this?') == true) {
      await fetch(`/run_summaries/${this.idTarget.value}/duplicate`, {
        method: 'POST',
        headers: {
          'X-CSRF-Token': csrfToken,
          'Content-type': 'application/json',
        },
      })

      location.reload()
    }
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
