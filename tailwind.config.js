const overrideContainer = ({ addComponents }) => {
  addComponents({
    '.container': {
      width: '100%',
      marginLeft: 'auto',
      marginRight: 'auto',
      '@screen sm': {
        maxWidth: '640px',
      },
      '@screen md': {
        maxWidth: '768px',
      },
      '@screen lg': {
        maxWidth: '1024px',
      },
    }
  })
};

module.exports = {
  purge: ['./layouts/**/*.html'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    container: {
      center: true
    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
    overrideContainer
  ],
};
