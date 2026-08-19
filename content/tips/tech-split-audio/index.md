---
title: Split voice and non-voice audio
authors: 
  - KemoNine
date: 2023-03-23
toc: true
draft: false
tags:
  - tech
#changelog:
#  - date: 2023-03-23
#    text: "Initial creation"
---

## Attribution
This tip is a syndicated copy of KemoNine's [blog post](https://blog.kemonine.info/blog/2022-08-01-more-accessible-gaming-audio/). It has been split into this page and a related [anecdote]({{< ref "/anecdotes/kemonine-audio-processing-woes.md" >}}).

---

## What?

This page outlines how to split your computer audio output so a game or aplication's audio is sent to your speaker and the voice audio is sent to a headset.

This can be helpful for those with speech processing needs. It allows you to isolate voice to a headset or similar which lets the voice audio come through more strongly than any other audio.

---

## Windows 10

1. Open main settings application
2. Go to system settings
3. Select Sound tab
4. Click "Sound Control Panel" link on the right
5. Right click the audio output device you want as the main audio and select "Set as default device". If the option is not present and the device has a green cicle checkbox, it's already the default device.
6. Right click the headset output device you want as the communication audio and select 'Set as default communication device". If the option is not present and the device has a green circle checkbox, it's already the default device.
7. Click on the microphone tab
8. Right click your microphone and set it as the default if it doesn't have a green circle checkmark.


## Related Anecdotes

- [Audio Processing Woes]({{< ref "/anecdotes/kemonine-audio-processing-woes.md" >}})

---
