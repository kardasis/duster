import { application } from './application'

import RunController from './run_controller.ts'
application.register('run', RunController)

import {
  RunSummaryChartController,
  RunSummaryChartTooltipController,
} from './run_summary_chart_controller'
application.register('run-summary-chart', RunSummaryChartController)
application.register(
  'run-summary-chart-tooltip',
  RunSummaryChartTooltipController
)

import RunSummaryController from './run_summary_controller.ts'
application.register('run-summary', RunSummaryController)
