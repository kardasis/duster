const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontSize: {
        'xl': ['1rem', '1rem'],
        '2xl': ['2rem', '2rem'],
        '3xl': ['3rem', '3rem'],
        '4xl': ['4rem', '4rem'],
        '5xl': ['5rem', '5rem'],
        '6xl': ['7rem', '7rem'],
        '7xl': ['10rem', '10rem'],
        '8xl': ['15rem', '15rem'],
        '9xl': ['20rem', '20rem'],
      } ,
      fontFamily: {
        sans: ['Roboto Condensed', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
