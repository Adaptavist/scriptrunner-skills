# Prints OpenAPI operations with every $ref resolved, ready to code against.
#   jq -c --arg ops 'POST /rest/api/3/version;GET /rest/api/3/project/{projectIdOrKey}/versions' -f operation.jq <spec>
#   jq -r --arg search 'version' -f operation.jq <spec>
# Request bodies resolve four levels deep without read-only properties; responses
# show their top level only. Descriptions are cut to 100 characters, which keeps
# "Deprecated. Use ..." notes.

def deref($root; $depth; $max; $request):
  if $depth > $max then "…"
  elif type == "object" then
    if has("$ref") then
      (.["$ref"] | ltrimstr("#/") | split("/")) as $path
      | $root | getpath($path) | deref($root; $depth + 1; $max; $request)
    else
      (if $request and (.properties | type) == "object"
        then .properties |= with_entries(select((.value | type) != "object" or .value.readOnly != true))
        else . end)
      | with_entries(select(.key | IN("summary", "example", "examples", "externalDocs", "security", "operationId", "readOnly", "xml",
          "x-atlassian-connect-scope", "x-atlassian-oauth2-scopes", "x-atlassian-data-security-policy", "x-experimental") | not))
      | (if (.description | type) == "string" then .description |= .[0:100] else . end)
      | map_values(deref($root; $depth; $max; $request))
    end
  elif type == "array" then map(deref($root; $depth; $max; $request))
  else . end;

def follow($root): if type == "object" and has("$ref") then (.["$ref"] | ltrimstr("#/") | split("/")) as $path | $root | getpath($path) | follow($root) else . end;

def body: .content // {} | (.["application/json"] // (to_entries | first | .value // {})) | .schema // null;

. as $root
| if ($ARGS.named.search // null) != null then
    .paths | to_entries[] | .key as $path | .value | to_entries[]
    | select(.key | IN("get", "post", "put", "patch", "delete"))
    | "\(.key | ascii_upcase) \($path)  \(.value.summary // "")"
    | select(test($ARGS.named.search; "i"))
  else
    $ARGS.named.ops | split(";")[] | ltrimstr(" ") | split(" ") as [$method, $path]
    | ($root.paths[$path] // {}) as $item
    | ($item[$method | ascii_downcase] // {}) as $operation
    | {
        op: "\($method) \($path)",
        found: ($operation != {}),
        deprecated: ($operation.deprecated // false),
        description: (($operation.description // "") | .[0:300]),
        parameters: (($item.parameters // []) + ($operation.parameters // []) | map(follow($root))
          | reduce .[] as $parameter ({}; .["\($parameter.in) \($parameter.name)"] = $parameter) | [.[]]
          | deref($root; 0; 3; false)),
        requestBody: ($operation.requestBody // {} | follow($root) | body | deref($root; 0; 4; true)),
        responses: ($operation.responses // {} | with_entries(select(.key | test("^2")))
          | map_values(follow($root) | body // "no body" | deref($root; 0; 1; false)))
      }
  end
