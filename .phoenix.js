Phoenix.set({
  openAtLogin: true,
})

const ALACRITTY_APP = 'Alacritty'
const VSCODE_APP = 'Code'

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

Key.on('escape', ['ctrl'], () => {
  const app = App.get(VSCODE_APP)
  if (!app) { return }

  if (app.isActive()) {
    app.hide()
  } else {
    app.show()
    app.activate()
    app.focus()
  }
})