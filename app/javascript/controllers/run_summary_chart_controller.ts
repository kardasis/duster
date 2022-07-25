import { Controller } from "@hotwired/stimulus"
import { Chart, registerables, ScatterDataPoint } from 'chart.js';

Chart.register(...registerables);

export default class extends Controller {
  static targets = [ 'chart', 'data']

  chart: Chart
  chartTarget: HTMLCanvasElement
  dataTarget: HTMLElement

  connect() {
    const summaries = JSON.parse(this.dataTarget.dataset.summaries)
    const gappy_dates = Object.keys(summaries).sort()

    let dates = []
    const now = new Date()
    for (let d = new Date(gappy_dates[0]); d <= now; d.setDate(d.getDate() + 1)) {
      dates.push(d.toISOString().split('T')[0])
    }


    const labels = dates.map(d => {
      return new Date(d).toLocaleDateString('en-us',{ month:"short", day: "numeric" }) 
    })


    const barData = dates.map( date => {
      return parseFloat(summaries[date]?.at(0)?.total_distance) || 0
    })
    this.chart = new Chart(this.chartTarget, {
      type: 'bar',
      data: {
        labels, 
        datasets: [
          {
            data: barData
          }
        ]}
    })
  }
}
