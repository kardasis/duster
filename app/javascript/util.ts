export function round(input: string | number, precision = 2): string {
  return parseFloat(input.toString()).toFixed(precision)
}

export function formatDuration(f: number): string {
  const t = Math.round(f)
  const s = t % 60
  const m = ((t - s) / 60) % 60
  const h = (t - s - 60 * m) / 3600
  if (h > 0) {
    return `${h.toString()}:${m.toString()}:${s.toString().padStart(2, '0')}`
  } else {
    return `${m.toString()}:${s.toString().padStart(2, '0')}`
  }
}

export function toSummary(summary): RunSummary {
  const distanceRecords = summary.data.relationships.distanceRecords.data.map(
    (dr) => {
      const { id, type: objectType } = dr
      return summary.included.find((o) => o.id == id && o.type == objectType)
        .attributes
    }
  )
  return { ...summary.data.attributes, distanceRecords }
}
