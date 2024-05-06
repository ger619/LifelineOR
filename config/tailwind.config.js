const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
        merienda: ["Merienda", "sans-serif"],
      },
      backgroundImage: {
        circle: "url('/app/assets/images/highlighter.png')",
      },
      colors: {
        scooter: {
          50: "#f0fcfc",
          100: "#e3fbfc",
          200: "#baf2f7",
          300: "#91e9f2",
          400: "#46d7eb",
          500: "#01c4e0",
          600: "#00a5c9",
          700: "#007ea8",
          800: "#005f87",
          900: "#004166",
          950: "#002642",
        },
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
