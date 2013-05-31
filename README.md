## Citrus Core

Spartan CI environment. Watch it build itself:

    ruby -Ilib bootstrap.rb

Have it running with github:

    gem ins proxylocal sinatra
    proxylocal 4567 # add it to Webhook URLs next
    ruby -Ilib citrus_web.rb

