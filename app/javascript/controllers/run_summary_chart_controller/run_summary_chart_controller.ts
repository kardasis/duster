import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js';
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

    const that = this
    this.chart = new Chart(this.chartTarget, {
      type: 'bar',
      data: bar_data,
      options: {
        onHover: function(e, activeElements) {
          if (e.type == 'click') {
            if (activeElements.length > 0) {
              const {index, datasetIndex} = activeElements[0]
              const summary = summaries[datasetIndex][index]
              const card = document.getElementById('summary-card').querySelector('div')

              console.log(card)
              console.log(summary)
              card.dispatchEvent(new CustomEvent(
                'set-run-summary',
                { detail: summary }
              ))
            }
          }
          if (e.type == 'mousemove'){
            if (activeElements.length == 0) {
              that.tooltipTarget.style.opacity = '0'
            } else {
              that.tooltipTarget.style.opacity = '1'
            }
          }
        },
        scales: {
          x: { stacked: true },
          y: { stacked: true }
        },
        events: ['mousemove', 'click'],
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
