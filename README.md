# docker-nwjs

This container runs an nwjs instance with xvfb & fluxbox in a docker container.

You can access xvfb using a VNC connection on port 5900.

## Available environment settings

| Variable | Default value | Description |
| -------- | ------------- | ----------- |
| XVFB_SCREENSIZE | 1280x720x16 | Set the x window size which is used by Xvfb |
| NWJS_ARGS | | Arguments for nw. E.g. path to your nwjs package |

## Keeping the nwjs state data persistent

Just map the `/root/.config` directory as a volume


## Example

```bash
docker run -i -t --rm \
-p 5900:5900 \
-e NWJS_ARGS="/root/nwjsapp" \
-v $(pwd)/package:/root/nwjsapp \
-v $(pwd)/config:/root/.config \
hauptmedia/nwjs
```