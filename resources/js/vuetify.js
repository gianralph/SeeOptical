import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'

// Optional: Customize theme (replace with your desired theme options)
const customTheme = {
  colors: {
    primary: '#3f51b5',
    secondary: '#4caf50',
  },
}

export default createVuetify({
  components,
  directives,
  // Uncomment if using a custom theme
  // theme: {
  //   defaultTheme: 'customTheme',
  //   themes: {
  //     customTheme,
  //   },
  // },
})
