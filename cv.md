---
layout: page
title: CV
heading: Leon Fuessner
nav: cv
permalink: /cv/
include: cv.html
description: >-
  Curriculum vitae and publications — Leon Fuessner, researcher and software
  developer at QUT Brisbane.

# CV copy. Edit this note in Obsidian source mode (the YAML below). The
# HTML lives in _includes/cv.html — do not put markup in this file.
# This is also the source for cv.pdf (CI prints the built /cv/ page).
#
# Entry shape (experience / education / publications):
#   when      left-hand date rail
#   what      role or title
#   where     organisation / venue
#   details   bullet list     (experience; omit if none)
#   summary   paragraph       (publications; omit if none)
#   authors   list of names   (publications)
#   self      which author to bold
#   doi       bare DOI, no URL
# Skills use `label` + `items` instead of when/what.

cv:
  tagline: Researcher · Systems Engineer · Software Developer
  location: Brisbane, Australia

  summary: >-
    Software engineer with 7+ years shipping code across mobile, VR/AR and
    automated driving systems — from refactoring Android apps with 100K+ users,
    to prototyping BMW's Vision Pro experiences, to building digital twins for
    self-driving vehicles. Now researching how to make remote vehicle
    supervision safe and effective.

  publications:
    - when: "2025"
      what: >-
        Interactive Visualization of Real-World Automated Driving Data using
        AWSIM and VARJO-XR4
      authors:
        - Leon Sebastian Fuessner
        - Togtokhtur Batbold
        - Ronald Schroeter
        - Sebastien Glaser
      self: Leon Sebastian Fuessner
      venue: >-
        AutomotiveUI '25 Adjunct: Adjunct Proceedings of the 17th International
        Conference on Automotive User Interfaces and Interactive Vehicular
        Applications. ACM, 2025, pp. 323–325.
      doi: 10.1145/3744335.3758969
      summary: >-
        A high-fidelity interactive visualization of real-world automated
        driving data. Sensor data (LiDAR, camera, GPS) recorded on the Mount
        Cotton closed circuit near Brisbane is replayed and synchronised with a
        Unity-based simulation of the same environment, then explored in VR
        through a VARJO-XR4 headset — making edge cases inspectable, safely and
        repeatably.

  experience:
    - when: 2025 — present
      what: Researcher & Software Developer
      where: Queensland University of Technology · Brisbane, Australia
      details:
        - Research on remote operation and digital twinning for automated vehicles
        - Simulation pipelines with Autoware, AWSIM and ROS 2
        - VR/AR road safety research — preventing accidents through immersive simulation
        - Built a digital twin of real-world terrain from recorded sensor data

    - when: 2023 — 2025
      what: Software Developer
      where: MaibornWolff GmbH · Munich, Germany
      details:
        - Client projects for STIHL and BMW
        - 3D VR/AR programming and prototyping for BMW — Swift, SwiftUI, Apple Vision Pro, Unreal Engine, Meta Quest Pro

    - when: 2021 — 2023
      what: Android Developer (Freelance)
      where: Droid-Dojo · Remote
      details:
        - Projects for Deutsche Bahn and Joyn
        - Private project built entirely with Jetpack Compose

    - when: 2020 — 2021
      what: Android Developer
      where: myposter GmbH · Munich, Germany
      details:
        - Multi-module Android app in a two-person team
        - Migrated from RxJava2 to Coroutines
        - Photo book and calendar creation features; intelligent photo album service in Python

    - when: 2019 — 2020
      what: Android Developer
      where: Spontacts GmbH (Jochen Schweizer) · Munich, Germany
      details:
        - Refactored the Spontacts app (100K+ MAU) to Kotlin and GraphQL
        - Shipped a new group feature — Java, Kotlin, GraphQL, Node.js, Firebase, MVVM

    - when: 2017 — 2020
      what: Software Developer — Apprenticeship
      where: Jochen Schweizer Technology Solutions · Munich, Germany
      details:
        - IT Specialist in Application Development (Ausbildung)
        - Android app for a voucher management system — Java, Kotlin, MVC, Dagger

  education:
    - when: "2025"
      what: Bachelor's Thesis in Computer Science
      where: Queensland University of Technology

    - when: 2021 — 2024
      what: Bachelor of Science in Computer Science
      where: Ludwig-Maximilians-Universität Munich

    - when: "2024"
      what: Study Abroad Semester
      where: Universidad de Sevilla

    - when: 2017 — 2020
      what: IT Specialist in Application Development
      where: Vocational School for Computer Science Munich

  # Shown on /cv/ only. Do not link a private repository from here.
  selected_projects:
    - name: Digital twin & remote operation research
      line: simulation pipelines for automated vehicles
    - name: Game Memory Manipulation
      line: reverse-engineering CS2; helper tools in C++ with x64dbg and Cheat Engine
    - name: RoboRally
      line: board game rebuilt as online multiplayer with Java and JavaFX
    - name: GDG Munich talk
      line: Android Paging with GraphQL

  skills:
    - label: Primary
      items: C++ (systems, performance), Python (deep learning, simulation), ROS 2, Autoware, AWSIM
    - label: Simulation & robotics
      items: Unity3D, Unreal Engine, digital twin pipelines, real-time systems
    - label: Learning
      items: Reverse engineering (x64dbg, Cheat Engine), x86-64 assembly, memory manipulation
    - label: Proficient
      items: Kotlin, Java, Android, C#, Swift, SwiftUI
    - label: Familiar
      items: JavaScript, Node.js, GraphQL, Docker, AWS, GCP, Linux

  languages: German (native) · English (fluent) · Spanish (intermediate)
---
