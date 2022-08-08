import { Controller } from '@hotwired/stimulus'
import { formatDuration, round } from '../../util'

const longNames = [
  ['lap', 'lap'],
  ['halfMile', '.5 mi'],
  ['oneKm', '1 km'],
  ['oneMile', '1 mi'],
  ['twoMiles', '2 mi'],
  ['threeMiles', '3 mi'],
  ['fiveKm', '5 km'],
  ['fourMiles', '4 mi'],
  ['fiveMiles', '5 mi'],
  ['tenKm', '10 km'],
]

export default class extends Controller {
  static targets = [
    'date',
    'speed',
    'parent',
    'time',
    'distance',
    'distanceRecords',
  ]

  parentTarget: HTMLElement
  dateTarget: HTMLCanvasElement
  speedTarget: HTMLElement
  timeTarget: HTMLElement
  distanceTarget: HTMLElement
  distanceRecordsTarget: HTMLElement

  update(event: CustomEvent) {
    const summary: RunSummary = event.detail
    this.dateTarget.innerHTML = new Date(summary.startTime).toLocaleDateString(
      'en-us',
      {
        weekday: 'short',
        month: 'short',
        day: 'numeric',
      }
    )
    this.speedTarget.innerHTML = round(summary.averageSpeed, 2)
    this.timeTarget.innerHTML = formatDuration(summary.totalTime)
    this.distanceTarget.innerHTML = round(summary.totalDistance, 2)

    while (this.distanceRecordsTarget.firstChild) {
      this.distanceRecordsTarget.removeChild(
        this.distanceRecordsTarget.firstChild
      )
    }
    for (let dist of longNames) {
      const [nominal, label] = dist
      const dr = summary.distanceRecords.find(
        (dr) => dr.nominalDistance === nominal
      )
      if (dr) {
        const row = this.distanceRecordRow(dr, label)
        this.distanceRecordsTarget.appendChild(row)
      }
    }
  }

  distanceRecordRow(dr: DistanceRecord, title: string) {
    const row = document.createElement('tr')

    const titleTd = document.createElement('td')
    titleTd.innerHTML = title
    row.appendChild(titleTd)

    const timeTd = document.createElement('td')
    timeTd.innerHTML = formatDuration(
      Math.round((dr.endTime - dr.startTime) / 1000)
    )
    row.appendChild(timeTd)

    // const speedTd = document.createElement('td')
    // speedTd.innerHTML = round(dr.speed, 3)
    // row.appendChild(speedTd)

    return row
  }

  longNominalDistance(nd: string) {
    return longNames[nd]
  }
}
