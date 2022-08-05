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

  update(event) {
    const summary = event.detail
    this.dateTarget.innerHTML = new Date(summary.start_time).toLocaleDateString(
      'en-us',
      {
        weekday: 'short',
        month: 'short',
        day: 'numeric',
      }
    )
    this.speedTarget.innerHTML = round(summary.averageSpeed, 2)
    this.timeTarget.innerHTML = formatDuration(summary.total_time)
    this.distanceTarget.innerHTML = round(summary.total_distance, 2)

    while (this.distanceRecordsTarget.firstChild) {
      this.distanceRecordsTarget.removeChild(
        this.distanceRecordsTarget.firstChild
      )
    }
    for (let dist of longNames) {
      const [nominal, label] = dist
      const dr = summary.distance_records.find(
        (dr) => dr.nominal_distance === nominal
      )
      if (dr) {
        const row = this.distanceRecordRow(dr, label)
        this.distanceRecordsTarget.appendChild(row)
      }
    }
  }

  distanceRecordRow(dr, title) {
    const row = document.createElement('tr')

    const titleTd = document.createElement('td')
    titleTd.innerHTML = title
    row.appendChild(titleTd)

    const timeTd = document.createElement('td')
    timeTd.innerHTML = formatDuration(
      ((dr.end_time - dr.start_time) / 1000).toFixed()
    )
    row.appendChild(timeTd)

    return row
  }

  longNominalDistance(nd) {
    return longNames[nd]
  }
}
