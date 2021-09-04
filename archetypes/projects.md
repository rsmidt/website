+++
title = "{{ replace .Name "-" " " | title }}"
keywords = []
repoUrl = ""
liveLink = ""

[[resources]]
    name = "thumbnail"
    src = "thumbnail.jpg"
    [resources.params]
        alt = "Screenshot of {{ replace .Name "-" " " | title }}."
+++

Description of the project.
