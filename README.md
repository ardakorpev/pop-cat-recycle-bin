# 🐱 Pop Cat Recycle Bin Icons

Transform your boring Windows Recycle Bin into an adorable Pop Cat that reacts to your trash! Watch as your desktop cat opens its mouth when hungry for files and closes it when satisfied with a full bin.

![Pop Cat Demo](https://github.com/asifahamed11/pop-cat-recycle-bin/blob/main/screenshots/demo.gif)

## 🎯 Features

- **Smart Cat Logic**: Empty bin = hungry cat with open mouth, Full bin = satisfied cat with closed mouth
- **One-Click Setup**: Fully automated installation with auto-admin privileges
- **Universal Compatibility**: Works from any folder on any Windows PC
- **Auto-Detection**: Automatically finds and applies the correct icon files
- **Instant Refresh**: Desktop updates immediately after installation
- **Easy Reversal**: Simple instructions to undo changes

## 🚀 Quick Start

1. **Download** the repository files
2. **Place** the batch file and `.ico` files in the same folder
3. **Double-click** `PopCat_Setup.bat`
4. **Enjoy** your new Pop Cat Recycle Bin!

## 📁 What's Included

```
📦 pop-cat-recycle-bin/
├── 🐱 PopCat_Setup.bat          # Universal installer script
├── 😮 Pop cat open.ico          # Hungry cat (empty bin)
├── 😊 Pop cat closed.ico        # Satisfied cat (full bin)
└── 📖 README.md                 # You are here!
```

## 🔧 How It Works

The script automatically:

1. **Detects Administrator Needs**: Elevates privileges automatically
2. **Finds Icon Files**: Smart detection of open/closed mouth icons
3. **Modifies Windows Registry**: Updates Recycle Bin icon settings
   - `HKEY_CURRENT_USER\...\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon`
4. **Applies Logic**: Empty bin → open mouth, Full bin → closed mouth
5. **Refreshes Desktop**: Forces Windows to show new icons immediately

## 📋 System Requirements

- **OS**: Windows 7/8/10/11
- **Permissions**: Administrator access (automatically requested)
- **Files**: `.ico` files in the same folder as the batch script

## 🎨 Customization

Want to use your own icons? Just replace the `.ico` files! The script will automatically detect:

- Files with "open", "close", or "closed" in the filename
- Any two `.ico` files in the same folder
- Common naming patterns like `cat_open.ico`, `mouth_closed.ico`, etc.

## 🔄 Reverting Changes

To restore original Recycle Bin icons:

1. Open **Registry Editor** (`regedit`)
2. Navigate to: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon`
3. Delete the entire `DefaultIcon` key
4. Restart **Windows Explorer**

Or simply delete the registry key path shown in the script output.

## 🐛 Troubleshooting

**Icons not updating?**
- Press `F5` to refresh the desktop
- Restart Windows Explorer: `Ctrl+Shift+Esc` → End `explorer.exe` → File → Run → `explorer.exe`
- Restart your computer

**Script won't run?**
- Right-click the `.bat` file → "Run as administrator"
- Ensure `.ico` files are in the same folder
- Check Windows Defender/antivirus isn't blocking the script

**Wrong icons showing?**
- Rename your icon files to include "open" and "closed" in the filename
- Verify both `.ico` files are valid Windows icons

## 📸 Screenshots

### Before
<img src="https://github.com/asifahamed11/pop-cat-recycle-bin/blob/main/screenshots/before.png" alt="Standard Recycle Bin" width="70"/>

### After
| Empty Bin (Hungry Cat) | Full Bin (Satisfied Cat) |
|-------------------------|---------------------------|
| ![Empty](https://github.com/asifahamed11/pop-cat-recycle-bin/blob/main/screenshots/Pop%20cat%20open-1.png) | ![Full](https://github.com/asifahamed11/pop-cat-recycle-bin/blob/main/screenshots/Pop%20cat%20closed-1.png) |

## 🤝 Contributing

Got ideas for improvements? Found a bug? Contributions are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the internet's beloved Pop Cat meme
- Thanks to the Windows registry documentation that made this possible
- Shoutout to everyone who loves customising their desktop!

## ⭐ Show Your Support

Give a ⭐ if this project made you smile! Share it with friends who love desktop customisation.

--

**Made with 💖 and lots of ☕ for the desktop customization community**

*Pop Cat says: "Feed me your deleted files!" 🗑️😸*
