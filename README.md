# Setup

To be able to properly run this project, you'll have to manually create the following config file since it's not tracked by source control:

`$(SRCROOT)/FlickrRx/Common/Secrets.xcconfig`

and then add your Flickr API key, like so:

`FLICKR_SECRET_KEY = YOUR_FLICKR_KEY`


# Issues

- Infinite scroll only works "downwards"
- Image download performance can be improved
- Many more unit tests are required. Also, if I hadn't run out of time, I would've used Quick & Nimble for BDD testing and OHHTTPStubs to test the network layer.
- I would've liked to add build configurations to switch between mock & network flavours
- Ran out of time to implement "Photo Detail"
