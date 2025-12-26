import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

config.bind('tT', 'config-cycle tabs.position top left')
config.bind('td', 'config-cycle colors.webpage.darkmode.enabled true false')
config.bind('yo', 'hint links spawn mpv {hint-url} ')
config.bind('yO', 'hint -r links spawn mpv {hint-url} ')

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
