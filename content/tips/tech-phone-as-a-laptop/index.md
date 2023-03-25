---
title: Using a phone or tablet as a laptop
author: 
  - KemoNine
publishDate: 2023-03-25
lastMod: 2023-03-25
toc: true
draft: false
categories:
  - tips
  - tech
tags:
  - phone
  - tablet
  - laptop
---

## Changelog
{{< changelog >}}
{{< change 2023-03-25 "Initial creation" >}}
{{< /changelog >}}

{{< end_section >}}

## Attribution
{{< back_to_top >}}

This tip is a rewritten copy of KemoNine's [blog post](https://blog.kemonine.info/blog/2022-06-18-death-of-the-laptop/). It has been adapted to our site's format by KemoNine.

{{< end_section >}}

## What is this magic?
{{< back_to_top >}}

This page outlines how to setup a phone or tablet as a laptop. With modern technology and the proliferation of smart phones being used as a person's primary computer, very little cannot be done using just a smart phone.

{{< end_section >}}

## Considerations
{{< back_to_top >}}

Before getting too deep into the topic, a few considerations

- This setup does **NOT** work universally on Android devices
- The hardware that enables using a phone as a laptop can also be used as a keyboard, mouse and display with other types of hardware
- This setup does **NOT** replace bigger computer setups that have multiple monitors, tons of ram, big graphics cards or similar
- This setup **CAN** replce small laptops, some larger tablets, chrome books, netbooks, umpcs and similar

{{< back_to_top >}}

### iPhone, iPad and iOS
{{< back_to_top >}}

The makers of the hardware described on this page all show iPhone, iPad and iOS support. Given I lack the necessary hardware for testing, I can only say this *should* work on Apple devices but I cannot confirm this myself.

If you have experience with this topic on Apple devices, we'd love to hear your feedback.

{{< back_to_top >}}

### Android
{{< back_to_top >}}

One special note regarding Android support: unless your phone *supports* Android desktop mode specifically, this setup will likely be more problematic than beneficial.

I should also note that many "good" brands like OnePlus can have working desktop mode in one Android release but not another.

For example: I had desktop mode working with a OnePlus 8T and a Microsoft Surface Duo, both running Android 12. When they received Android 13, desktop mode stopped working.

Samsung devices that have the `DEX` feature *should* work with the setup described here. Samsung has made desktop mode Android a primary feature on some models and I recommend going this path if you want a phone or tablet that can be turned into a laptop.

I switched to a Samsung Galazy Z Fold 4 after the OnePlus 8T and Surface Duo stopped supporting desktop mode properly and I do not regret this decision.

{{< end_section >}}

## Required Hardware
{{< back_to_top >}}

The key piece of hardware involved in turning a phone into a laptop is the `Lapdock`.

Lapdocks are hinged, clamshell devices with

- A touch screen
- Keyboard
- Touch pad
- Battery
- Speakers
- USB keyboard and mouse output
- HDMI input
- Charging port

They look *exactly* like a laptop and allow you use use the standard laptop clamshell form factor with a variety of devices.

I have bought lapdocks from both [NexDock](https://nexdock.com/explore-nexdock/) and [uPerfect](https://www.uperfectmonitor.com/collections/lapdock). They both sell competent hardware with slightly different configurtations. uPerfect in particular sells a few different models.

If you down down this path, I'd recommend shopping around for a layout that meets your desires and needs.

{{< end_section >}}

## How does it work?
{{< back_to_top >}}

### Phones and Tablets
{{< back_to_top >}}

For phones and tablets, usually a lapdock will use a single cable to connect to the device. From there the device will see the lapdock as a dock and re-configure itself accordingly.

On devices with direct support via Samsung DEX, the phone or tablet will immediately see the lapdock, show a loading screen on the monitor, load the desktop mode and that's it. A very plug and play process that seems to work reliably no less.

Other devices with support for desktop mode, docks and similar should work the same way: plug in a cable to the lapdock and phone and it auto-magically turns your phone into a laptop styled device.

{{< back_to_top >}}

### Other Devices
{{< back_to_top >}}

Most lapdocks include a HDMI input port as well as the standard phone port. When using non-mobile devices like a Raspberry Pi, server or even desktop computer the lapdock uses 2 cables. One cable for HDMI graphics and one cable for USB keyboard and mouse support.

The lapdock becomes the keyboard, monitor and mouse attached to the device in this situation. It is incredibly useful if you do work on headless comptuers, embedded platforms like the Raspberry Pi and more.

I use my lapdock to manage a headless Raspberry Pi and have a close friend who uses a lapdock to manage servers in co-location facilities where they don't have access to a keyboard or montior.

{{< end_section >}}

## How well does it work?
{{< back_to_top >}}

As well as a chromebook or netbook or iPad with keyboard attachment. Modern phones can print to more recent printers, manage personal documents, browse the web, run video conference software and more. Having a larger screen and multi-window (device dependent feature) support can be a big deal when not planted at a well organized work space.

Most computing tasks these days are also mobile-first or web-first interfaces which do well with mobile devices and lapdocks.

The main needs I have that were not easily or well addressed by a lapdock are

- **My Photography:** The image editing and catalog management needs a lot more hardware than most phones and tablets provide
- **My Embedded Device Development:** I do a bit of embedded device programming and the interfaces require a traditional operating system and are wholly unsupported on mobile devices
- **My Large Data Processing:** On occassion I have need for a lot of CPU and RAM for processing data sets which mobile devices cannot provide

Everything else I need a comptuer for day to day is supported by my phone and lapdock. I have not owned a laptop in at least 18 months and I have no desire or need to go back to having access to a laptop. My phone covers 85-90% of my computing needs and what isn't supported is a reasonably niche need that requires specialized hardware.

{{< end_section >}}

## Image Gallery
{{< back_to_top >}}

{{< figure src="NexDock---Duo---Puck-Buddy.jpg" alt="A Surface Duo foldable phone connected to the NexDock and a PuckBuddy ready for use as a laptop" caption="My initial desk setup" >}}

{{< figure src="On-The-Go.jpg" alt="A soft case, Nexdock, usb wires, PuckBuddy and Surface Duo neatly arranged on carpet" caption="The Full Kit" >}}

{{< figure src="Fixing-Servers.jpg" alt="The NexDock plugged into a Raspberry Pi showing it can be used to administer servers. The picture shows the NexDock on the floor next to a number of servers and other 'enterprise' hardware that forms the foundation of my home network." caption="Fix a server? Yep!" >}}

{{< back_to_top >}}
