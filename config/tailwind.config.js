const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/{helpers,components}/**/*.rb',
    './app/javascript/**/*.js',
    './app/{views,components}/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography')
  ]
}
