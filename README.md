## Telegram resource
Telegram notification resource for [ConcourseCI](https://github.com/concourse/concourse)

## Config
* `bot_token`: **Required** Bot token, for example `123456789:ABCDEFGHIJKLMNOPQRSTUVWQYZabcdefghi`
* `chat_id`: **Required** Chat id
* `ci_url`: URL of your ci, if not defined will be used from `$ATC_EXTERNAL_URL`
* `admins`: Array of usernames (without @) who can use command for trigger job
* `command`: **Required for get** command which will trigger job, example `/build`

### Example
```
resource_types:
- name: telegram-notification
  type: docker-image
  source:
    repository: cuttlerat/concourse-telegram-resource
    tag: latest

resources:
- name: telegram
  type: telegram-notification
  source:
    bot: ((telegram_bot_token))
    chat_id: ((telegram_chat_id))
    ci_url: "http://example.com"
    admins: ((telegram_admins))
    command: "/build"

jobs:
- name: test_task
  plan:
  - get: telegram
    trigger: true
  - task: Send message
    on_success:
      put: telegram
      params:
        message: Build successful
    config:
      platform: linux
      image_resource:
        type: docker-image
        source: {repository: alpine, tag: "latest"}
      run:
        path: sh
        args:
          - -exc
          - |
              exit 0
```

### Example command for trigger
`/build`

### Example output message
**URL:** http://example.com/teams/main/pipelines/test/jobs/test_task/builds/1  
**Pipeline:** test  
**Job:** test_task  
**Build number:** 1  
**Message:** Build successful  
