---
layout: page
title: CV
heading: Leon Fuessner
nav: cv
permalink: /cv/
description: >-
  Curriculum vitae and publications — Leon Fuessner, researcher and software
  developer at QUT Brisbane.
---

<!-- The CV is two renderings of one source: this page and the cv.pdf built
     from it by CI (.github/workflows/deploy.yml). There is no separately
     maintained PDF — edit this file and the PDF follows. See CONTEXT.md.

     Markup uses the phase-2 hooks in assets/css/style.css §10 only:
     .cv-contact, .cv-section, .cv-entry / .cv-when / .cv-what / .cv-where /
     .cv-detail. The wrapping `cv` class comes from _layouts/page.html. -->

<ul class="cv-contact">
  <li>Researcher · Systems Engineer · Software Developer</li>
  <li>Brisbane, Australia</li>
  <li><a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a></li>
  <li><a href="https://github.com/{{ site.github_username }}">github.com/{{ site.github_username }}</a></li>
  <li class="no-print"><a href="{{ '/cv.pdf' | relative_url }}">Download PDF</a></li>
</ul>

<section class="cv-section">
  <h2>Summary</h2>
  <p>
    Software engineer with 7+ years shipping code across mobile, VR/AR and
    automated driving systems — from refactoring Android apps with 100K+ users,
    to prototyping BMW's Vision Pro experiences, to building digital twins for
    self-driving vehicles. Now researching how to make remote vehicle
    supervision safe and effective.
  </p>
</section>

<section class="cv-section" id="publications">
  <h2>Publications</h2>

  <div class="cv-entry">
    <div class="cv-when">2025</div>
    <p class="cv-what">Interactive Visualization of Real-World Automated Driving Data using AWSIM and VARJO-XR4</p>
    <p class="cv-where">
      <strong>Leon Sebastian Fuessner</strong>, Togtokhtur Batbold,
      Ronald Schroeter, Sebastien Glaser —
      AutomotiveUI '25 Adjunct: Adjunct Proceedings of the 17th International
      Conference on Automotive User Interfaces and Interactive Vehicular
      Applications. ACM, 2025, pp. 323–325.
      <a href="https://doi.org/10.1145/3744335.3758969">doi:10.1145/3744335.3758969</a>
    </p>
    <div class="cv-detail">
      <p>
        A high-fidelity interactive visualization of real-world automated
        driving data. Sensor data (LiDAR, camera, GPS) recorded on the Mount
        Cotton closed circuit near Brisbane is replayed and synchronised with a
        Unity-based simulation of the same environment, then explored in VR
        through a VARJO-XR4 headset — making edge cases inspectable, safely and
        repeatably.
      </p>
    </div>
  </div>
</section>

<section class="cv-section" id="experience">
  <h2>Experience</h2>

  <div class="cv-entry">
    <div class="cv-when">2025 — present</div>
    <p class="cv-what">Researcher &amp; Software Developer</p>
    <p class="cv-where">Queensland University of Technology · Brisbane, Australia</p>
    <div class="cv-detail">
      <ul>
        <li>Research on remote operation and digital twinning for automated vehicles</li>
        <li>Simulation pipelines with Autoware, AWSIM and ROS 2</li>
        <li>VR/AR road safety research — preventing accidents through immersive simulation</li>
        <li>Built a digital twin of real-world terrain from recorded sensor data</li>
      </ul>
    </div>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2023 — 2025</div>
    <p class="cv-what">Software Developer</p>
    <p class="cv-where">MaibornWolff GmbH · Munich, Germany</p>
    <div class="cv-detail">
      <ul>
        <li>Client projects for STIHL and BMW</li>
        <li>3D VR/AR programming and prototyping for BMW — Swift, SwiftUI, Apple Vision Pro, Unreal Engine, Meta Quest Pro</li>
      </ul>
    </div>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2021 — 2023</div>
    <p class="cv-what">Android Developer (Freelance)</p>
    <p class="cv-where">Droid-Dojo · Remote</p>
    <div class="cv-detail">
      <ul>
        <li>Projects for Deutsche Bahn and Joyn</li>
        <li>Private project built entirely with Jetpack Compose</li>
      </ul>
    </div>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2020 — 2021</div>
    <p class="cv-what">Android Developer</p>
    <p class="cv-where">myposter GmbH · Munich, Germany</p>
    <div class="cv-detail">
      <ul>
        <li>Multi-module Android app in a two-person team</li>
        <li>Migrated from RxJava2 to Coroutines</li>
        <li>Photo book and calendar creation features; intelligent photo album service in Python</li>
      </ul>
    </div>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2019 — 2020</div>
    <p class="cv-what">Android Developer</p>
    <p class="cv-where">Spontacts GmbH (Jochen Schweizer) · Munich, Germany</p>
    <div class="cv-detail">
      <ul>
        <li>Refactored the Spontacts app (100K+ MAU) to Kotlin and GraphQL</li>
        <li>Shipped a new group feature — Java, Kotlin, GraphQL, Node.js, Firebase, MVVM</li>
      </ul>
    </div>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2017 — 2020</div>
    <p class="cv-what">Software Developer — Apprenticeship</p>
    <p class="cv-where">Jochen Schweizer Technology Solutions · Munich, Germany</p>
    <div class="cv-detail">
      <ul>
        <li>IT Specialist in Application Development (Ausbildung)</li>
        <li>Android app for a voucher management system — Java, Kotlin, MVC, Dagger</li>
      </ul>
    </div>
  </div>
</section>

<section class="cv-section" id="education">
  <h2>Education</h2>

  <div class="cv-entry">
    <div class="cv-when">2025</div>
    <p class="cv-what">Bachelor's Thesis in Computer Science</p>
    <p class="cv-where">Queensland University of Technology</p>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2021 — 2024</div>
    <p class="cv-what">Bachelor of Science in Computer Science</p>
    <p class="cv-where">Ludwig-Maximilians-Universität Munich</p>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2024</div>
    <p class="cv-what">Study Abroad Semester</p>
    <p class="cv-where">Universidad de Sevilla</p>
  </div>

  <div class="cv-entry">
    <div class="cv-when">2017 — 2020</div>
    <p class="cv-what">IT Specialist in Application Development</p>
    <p class="cv-where">Vocational School for Computer Science Munich</p>
  </div>
</section>

<section class="cv-section" id="projects">
  <h2>Selected Projects</h2>
  <!-- Do not link a private repository from here. The unshipped cv_2025 page
       linked the first entry below to a private repo, which is a 404 for every
       visitor. The entry stays; the link does not. -->
  <ul>
    <li><strong>Digital twin &amp; remote operation research</strong> — simulation pipelines for automated vehicles</li>
    <li><strong>Game Memory Manipulation</strong> — reverse-engineering CS2; helper tools in C++ with x64dbg and Cheat Engine</li>
    <li><strong>RoboRally</strong> — board game rebuilt as online multiplayer with Java and JavaFX</li>
    <li><strong>GDG Munich talk</strong> — Android Paging with GraphQL</li>
  </ul>
  <p class="no-print"><a href="{{ '/projects/' | relative_url }}">More projects</a></p>
</section>

<section class="cv-section" id="skills">
  <h2>Technical Skills</h2>
  <dl>
    <dt>Primary</dt>
    <dd>C++ (systems, performance), Python (deep learning, simulation), ROS 2, Autoware, AWSIM</dd>
    <dt>Simulation &amp; robotics</dt>
    <dd>Unity3D, Unreal Engine, digital twin pipelines, real-time systems</dd>
    <dt>Learning</dt>
    <dd>Reverse engineering (x64dbg, Cheat Engine), x86-64 assembly, memory manipulation</dd>
    <dt>Proficient</dt>
    <dd>Kotlin, Java, Android, C#, Swift, SwiftUI</dd>
    <dt>Familiar</dt>
    <dd>JavaScript, Node.js, GraphQL, Docker, AWS, GCP, Linux</dd>
  </dl>
</section>

<section class="cv-section" id="languages">
  <h2>Languages</h2>
  <p>German (native) · English (fluent) · Spanish (intermediate)</p>
</section>
