# Core Module
- npm install -g esformatter


# Plug-ins
See here:
https://github.com/millermedeiros/esformatter/wiki/Plugins

## Steps
- npm install -g esformatter-collapse-objects
- npm install -g esformatter-literal-notation
- npm install -g esformatter-parseint
- npm install -g esformatter-quote-props
- npm install -g esformatter-quotes
- npm install -g esformatter-remove-trailing-commas
- npm install -g esformatter-semicolons
- npm install -g esformatter-spaced-lined-comment
- npm install -g esformatter-var-each



# Sublime Text Installation
- Install the `esformatter` package
- Override the default user settings with this
    - Point it towards a custom esformatter configuration file

```
{
    // Format the file when saved
    "format_on_save": true,

    // File names to search for local config file
    "esformatter_config_file": [
        ".esformatter", 
        ".esformatter.json",
        "/Users/lknecht/Repositories/DefaultConfigurations/Mac/Settings/SublimeText3/esformatter",
    ]
}
```
