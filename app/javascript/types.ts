interface DistanceRecord {
  nominalDistance: string
  endTime: number
  startTime: number
  duration: number
  speed: number
}

interface RunSummary {
  startTime: Date
  averageSpeed: number
  totalTime: number
  totalDistance: number
  runId: string
  id: string
  distanceRecords: DistanceRecord[]
  rawDataUri: string
  intervalDataUri: string
}
