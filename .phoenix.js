Phoenix.set({
  openAtLogin: true,
})

const ALACRITTY_APP = 'Alacritty'

Key.on('`', ['ctrl'], () => {
  const app = App.get(ALACRITTY_APP)
  if (!app) { return }

  if (app.isActive()) {
    app.hide()
  } else {
    app.show()
    app.activate()
    app.focus()
  }
})
