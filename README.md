# hatter_news

![screenshot of the app](https://i.imgur.com/3ITp9pc.png)


A hackernews client showing previews of the linked websites.

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