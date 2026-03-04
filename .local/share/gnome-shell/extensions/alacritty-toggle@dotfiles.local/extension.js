import Meta from 'gi://Meta';
import Shell from 'gi://Shell';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as Util from 'resource:///org/gnome/shell/misc/util.js';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

export default class AlacrittyToggleExtension extends Extension {
  enable() {
    this._settings = this.getSettings();
    Main.wm.addKeybinding(
      'toggle-key',
      this._settings,
      Meta.KeyBindingFlags.NONE,
      Shell.ActionMode.ALL,
      () => this._toggle()
    );
  }

  disable() {
    Main.wm.removeKeybinding('toggle-key');
    this._settings = null;
  }

  _toggle() {
    const appId = this._settings.get_string('app-id') || 'Alacritty.desktop';
    const command = this._settings.get_string('command') || 'alacritty';

    const app = Shell.AppSystem.get_default().lookup_app(appId);
    let windows = app ? app.get_windows() : [];

    if (windows.length === 0) {
      const all = global.display.get_tab_list(Meta.TabList.NORMAL_ALL, null);
      windows = all.filter(w => {
        const wmClass = (w.get_wm_class() || '').toLowerCase();
        const wmClassInst = (w.get_wm_class_instance() || '').toLowerCase();
        return wmClass.includes('alacritty') || wmClassInst.includes('alacritty');
      });
    }

    if (windows.length === 0) {
      Util.spawnCommandLine(command);
      return;
    }

    const focus = global.display.get_focus_window();
    const focusedIsTarget = focus && windows.includes(focus);

    if (focusedIsTarget) {
      focus.minimize();
      return;
    }

    const target = windows.find(w => !w.minimized) || windows[0];

    if (target.minimized)
      target.unminimize();

    Main.activateWindow(target);
  }
}
