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
    const dates = Object.keys(summaries).sort()
    const labels = dates.map(d => {
      return new Date(d).toLocaleDateString('en-us',{ month:"short", day: "numeric" }) 
    })

    console.log(summaries)

    const barData = dates.map( date => {
      return parseFloat(summaries[date][0]?.total_distance)
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