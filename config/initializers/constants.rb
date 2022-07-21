KILOMETERS_PER_MILE = 1.60934
TICKS_PER_MILE = 5280 * (6 / 3.12)

SECONDS_PER_HOUR = 3600
MILLIS_PER_HOUR = 60 * 60 * 1000

DEBOUNCE_TIME = 20 # min milliseconds between ticks

SPEED_SMOOTHING = 0.5

RECORD_DISTANCES = {
  oneMile: 1.0,
  fiveKm: 5.0 * KILOMETERS_PER_MILE,
  fiveMiles: 5.0,
  fourMiles: 4.0,
  halfMile: 0.5,
  lap: 0.25,
  oneKm: KILOMETERS_PER_MILE,
  tenKm: 10.0 * KILOMETERS_PER_MILE,
  threeMiles: 3.0,
  twoMiles: 2.0
}.freeze
