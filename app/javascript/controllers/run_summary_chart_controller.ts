import { Controller } from "@hotwired/stimulus"
import { Chart, registerables, ScatterDataPoint } from 'chart.js';

Chart.register(...registerables);

const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

export default class extends Controller {
  static targets = [ 'chart', 'data']

  chart: Chart
  chartTarget: HTMLCanvasElement
  dataTarget: HTMLElement

  connect() {
    console.log(this.dataTarget.dataset.summariesData)
    const data = JSON.parse(this.dataTarget.dataset.summariesData)

    this.chart = new Chart(this.chartTarget, {
      type: 'bar',
      data,
      options: {
        scales: {
          x: { stacked: true },
          y: { stacked: true }
        },
        plugins: {
          tooltip: {
            callbacks: {
            }
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
