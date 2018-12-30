# hatter_news
A hackernews client showing previews of the linked websites.

![screenshot of the app's screen showing posts](https://i.imgur.com/3ITp9pc.png) ![screenshot of the app's screen showing comments](https://i.imgur.com/84Q0CEN.png)


NOTE: This project is currently not on any app store and must be built from source to be used.

## How to use

* Get a free API key from https://www.linkpreview.net/  the free keys only support 60 requests per hour at the time of writing, so I can't just share my API key
* Create `{project_root}/secrets/api_keys.json` like 
    ```
    {
      "linkpreview": "YOUR_API_KEY"
    }
    ```

* Build the project as you would build any other flutter project and load onto your device.

## Open TODOs:

* Add viewing links with something like https://github.com/fluttercommunity/flutter_webview_plugin
* Add post age
* prevent text-overflow in posts with really, really long titles
* Add log in functionality in addition to functionality to
    * Rate posts
    * Rate comments
    * Post comments
    * Post posts
    
* Allow filtering by other things than "top"
* Allow saving posts / comments
* Expanding / collapsing comments
* Re-load on swipe down when scrolled up maximally
