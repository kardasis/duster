import { Controller } from "@hotwired/stimulus"
import { Chart, registerables, ScatterDataPoint } from 'chart.js';
import {externalTooltipHandler} from './tooltip'

Chart.register(...registerables);

const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

export default class extends Controller {
  static targets = [ 'chart', 'data', 'tooltip']

  chart: Chart
  chartTarget: HTMLCanvasElement
  dataTarget: HTMLElement
  tooltipTarget: HTMLElement


  connect() {
    const bar_data = JSON.parse(this.dataTarget.dataset.bars)
    const summaries = JSON.parse(this.dataTarget.dataset.indexedSummaries)

    this.chart = new Chart(this.chartTarget, {
      type: 'bar',
      data: bar_data,
      options: {
        scales: {
          x: { stacked: true },
          y: { stacked: true }
        },
        plugins: {
          tooltip: {
            enabled: false,
            external: externalTooltipHandler(this.tooltipTarget, summaries),
          }
        }
      }
    })
  }
}

function getMonday(d) {
  d = new Date(d);
  const day = d.getDay()
  const diff = d.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday
  return  new Date(d.setDate(diff))}

function getDayOfWeek(d) {
  return days[d.getDay()]
}
