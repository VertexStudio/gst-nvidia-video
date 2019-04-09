
## Test the container
```
gst-launch-1.0 videotestsrc ! autovideosink
gst-launch-1.0 videotestsrc ! nvh264enc ! fakesink
```
## Debug your pipelines

```
export GST_DEBUG_DUMP_DOT_DIR=/some/path/to/save/dot/files
```
```
Run a GStreamer pipeline
```
```
./gst_pipelines_diagrams.sh
```
Then check your pipeline diagrams at `$GST_DEBUG_DUMP_DOT_DIR/diagrams`.
