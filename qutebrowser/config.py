import themes

c.colors.webpage.darkmode.enabled = True
c.content.cookies.accept = "no-3rdparty"
c.content.cookies.store = False
c.tabs.position = "left"
c.tabs.title.format = "{audio}{index}"
c.tabs.width = "3%"
c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://search.brave.com/search?q={}",
    "br": "https://search.brave.com/search?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "st": "https://www.startpage.com/sp/search?q={}",
    "g": "https://www.google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "r": "https://www.reddit.com/r/{}"
}
# c.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.content.headers.do_not_track = True
c.confirm_quit = [ "multiple-tabs" ]
c.tabs.last_close = "blank"
c.tabs.mousewheel_switching = False

themes.setup(c, "frappe", True)
config.load_autoconfig(False)
