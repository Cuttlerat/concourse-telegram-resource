## Telegram resource
Telegram notification resource for [ConcourseCI](https://github.com/concourse/concourse)

## Config
* `bot_token`: **Required** Bot token, for example `123456789:ABCDEFGHIJKLMNOPQRSTUVWQYZabcdefghi`
* `chat_id`: **Required** Chat id

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

jobs:
- name: Test task
  plan:
  - task: Send message
    on_success:
      put: telegram
      params:
        message: Build success
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
### Example message
**Pipeline:** test  
**Job:** Test task  
**Build number:** 1  
**Message:** Build success  
