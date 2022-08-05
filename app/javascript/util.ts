export function round(input: string | number, precision=2): string {
  return (parseFloat(input.toString())).toFixed(precision)
}

export function formatDuration(t: number): string {
  const s = t % 60
  const m = (t - s)/60 % 60
  const h = ((t - s) - 60 * m)/3600
  if (h>0) {
    return `${h.toString()}:${m.toString()}:${s.toString().padStart(2, '0')}`
  } else {
    return `${m.toString()}:${s.toString().padStart(2, '0')}`
  }
}
