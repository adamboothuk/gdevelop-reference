# GDevelop Network Reference

Extracted from `NetworkExtension.cpp`. Extension ID: `BuiltinNetwork`.

> Some entries add `AddCodeOnlyParameter("currentScene", "")` first. Do not
> include that internal parameter in JSON `parameters[]`.

## Open This File When

- the task sends HTTP requests or talks to an external API
- the task opens a URL in the browser
- the task downloads a file
- the task enables or disables analytics metrics

## Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `SendRequest` | hostWithProtocol, path, requestBody, method(optional), contentType(optional), responseSceneVariable(optional) |
| ACTION | `SendAsyncRequest` | url, requestBody, method, contentType(optional), responseVariable(optional), errorVariable(optional) |
| ACTION | `LaunchFile` | urlOrFilename |
| ACTION | `DownloadFile` | host, path, saveAs |
| ACTION | `EnableMetrics` | yes/no |

Notes:

- `SendRequest` is hidden older request support split into host and path.
- Prefer `SendAsyncRequest` for new JSON authoring.
- `SendAsyncRequest` supports methods: `GET`, `POST`, `PUT`, `HEAD`, `DELETE`, `PATCH`, `OPTIONS`.
- If the content type is omitted, the source says the default is `"application/x-www-form-urlencoded"`.
- For `SendAsyncRequest`, the optional error variable is set to an HTTP status code string for server errors, or `"REQUEST_NOT_SENT"` if the request never went out.
- `LaunchFile` opens a URL or file in the browser or a new tab depending on platform.
- `EnableMetrics` should be treated carefully because the extension description explicitly mentions player consent and analytics collection.

## JSON Examples

Send an async GET request:

```json
{
  "type": { "value": "SendAsyncRequest" },
  "parameters": [
    "\"https://api.example.com/users/123\"",
    "\"\"",
    "\"GET\"",
    "\"application/json\"",
    "VariableString(ApiResponse)",
    "VariableString(ApiError)"
  ]
}
```

Open a web page:

```json
{
  "type": { "value": "LaunchFile" },
  "parameters": ["\"https://example.com\""]
}
```
