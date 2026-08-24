---
name: python
description: Python conventions, code style, and best practices. Trigger whenever the user is writing, reviewing, or modifying Python code — including adding modules, tests, CLI commands, or any .py files.
---

# Python Skill

Python conventions. Follow these whenever writing or reviewing `.py` files.

We're on Python 3.12 at least, which means type hint types do not need to be imported.

## Dependencies

Use `uv` for dependency management: `uv add <package>`, `uv add --dev <package>`, test-only deps under
`[project.optional-dependencies].test`.
Use `boto3-stubs[...]` for typed AWS clients.

## Formatting & Linting

`ruff` is configured per package: line-length 120, 4-space indent, double quotes, lint rules `E`/`F`/`I`. Run before committing:

```bash
uv run ruff format .
uv run ruff check --fix .
```

## CLI Commands

CLIs use `click` with a `[project.scripts]` entrypoint pointing at `<pkg>.cli:main`. Keep CLI orchestration and stateful
setup inside the command function; factor pure logic into module-level helpers.

```python
@click.command()
@click.option("--region", required=True)
def main(region: str) -> None:
    client = boto3.client("rds", region_name=region)
    # ... orchestration
```

## Domain Modeling

### Group values that travel together into a frozen dataclass

When two or more values are always derived together and then passed around together, they're one concept, not loose
helpers. The tell: a derivation order you have to remember (B needs A to compute) and the same pair threaded through
several functions as positional args. Model them as a `@dataclass(frozen=True)` with a `@classmethod` factory, and hang
operations that act only on that pair off the class as methods.

**Good:**
```python
@dataclass(frozen=True)
class DbTarget:
    """Local compose postgres to load into — discovered at load time, not carried in the manifest."""
    service: str
    user: str

    @classmethod
    def discover(cls) -> "DbTarget":
        # service first: reading POSTGRES_USER means execing into that very service.
        svc = os.environ.get("DEVENV_DB_SERVICE", "postgres")
        user = _read_container_env(svc, "POSTGRES_USER") or "postgres"
        return cls(service=svc, user=user)

    def recreate(self, dbname: str) -> None: ...

target = DbTarget.discover()
target.recreate("foo")
```

**Avoid** free functions that re-derive and re-thread the same pair at every call site:

```python
region = resolve_region()                # this dance repeats in every command
bucket = resolve_bucket(region)          # caller must remember to pass region
upload(region, bucket, "report.csv")
```

Use `__post_init__` for invariants (`if self.replicas < 1: raise ValueError(...)`).

### Enums for a closed set, optionally with behavior attached

When a value is one of a fixed set, model it as an `Enum` rather than bare strings or ints. If members have per-member
behavior or data, hang it off the enum — carry data as the member's value, expose it via `@property`, and dispatch with
`match` — instead of scattering `if kind == ...` chains across call sites. A plain enum with no methods is fine too; add
behavior only when there is some.

```python
class Size(Enum):
    SMALL = {"cpu": "500m", "memory": "2Gi"}
    LARGE = {"cpu": "2", "memory": "8Gi"}

    @property
    def cpu(self) -> str:
        return self.value["cpu"]

class Runtime(Enum):
    DEFAULT = "default"
    DOCKER = "docker"

    @property
    def docker_dev(self) -> bool:
        return self is Runtime.DOCKER
```

## Comments

Use comments sparingly. Don't comment on obvious code.

**Bad:**
```python
# Use centralized loguru configuration
from myapp.logging_config import logger
```

**Good:**
```python
from myapp.logging_config import logger
```

Don't put rationale or backstory in comments/docstrings — *why* a thing
exists, what permissions/infra it depends on, alternatives considered. That
goes in the PR description or commit message; in source it's noise that goes
stale. Comment only a genuine non-obvious gotcha (a workaround for an external
quirk). Keep docstrings to a terse one-line statement of *what*.

**Bad:**
```python
def _resolve_host(tier: str) -> str:
    """Look up the tier's DSQL endpoint from SSM. Engineers have dsql:DbConnect
    but not always ssm:GetParameter on this path — if the read is denied, the
    caller should pass --host explicitly (the endpoint isn't secret)."""
```

**Good:**
```python
def _resolve_host(tier: str) -> str:
    """Look up the tier's DSQL endpoint from SSM."""
```

## Docstrings

Use this style for docstrings:
```python
def get_item(
    client,
    table_name: str,
    key: str,
) -> dict:
    """
    Retrieves an item from a DynamoDB table by primary key.

    :param client: Boto3 Client for DynamoDB.
    :param table_name: Name of the DynamoDB Table.
    :param key: Primary key value for the item to retrieve.
    """
```

## Pattern Matching

Use match statements instead of if/elif chains when handling multiple discrete cases.

**Good:**
```python
def http_handler(connection, request):
    match request.path:
        case "/health" | "/healthcheck":
            return connection.respond(HTTPStatus.OK, "OK\n")
        case "/api/widgets":
            return handle_widgets(connection)
        case _:
            logger.info(f"Unknown path: {request.path}")
```

**Avoid:**
```python
def http_handler(connection, request):
    if request.path in ["/health", "/healthcheck"]:
        return connection.respond(HTTPStatus.OK, "OK\n")
    elif request.path == "/api/widgets":
        return handle_widgets(connection)
    else:
        logger.info(f"Unknown path: {request.path}")
```

## Module-level vs. Function-level Code

- **Helper functions**: Define at module level when they are pure/stateless utility functions that could be reused or tested independently
- **Imports**: Always place at module level, never inside functions
- **Main function**: Keep CLI logic, orchestration, and stateful operations in the main function

**Good:**
```python
from collections import defaultdict
import boto3

def get_section_key(instance_class: str) -> str:
    """Pure utility function - belongs at module level."""
    parts = instance_class.replace("db.", "").split(".")
    return f"{parts[0]}.{parts[1]}"

@click.command()
def main(region: str) -> None:
    """CLI orchestration stays in main."""
    client = boto3.client("rds", region_name=region)
    # ... orchestration logic
```

**Avoid:**
```python
@click.command()
def main(region: str) -> None:
    from collections import defaultdict  # Import inside function

    def get_section_key(instance_class: str) -> str:  # Nested function when not needed
        return instance_class.split(".")[0]

    # ... logic
```

## Imports

Never import inside functions. Always place imports at the top of the module.

## Tests

Use pytest with fixtures and parametrize. Strongly prefer plain functions over class-based tests — `pytest.mark.parametrize` covers grouping and parameterization without the boilerplate. Only use classes when the testing framework requires them (e.g., Django's `TestCase`), or when extending existing class-based test files — don't refactor working class-based tests just to match this preference.

### Fixtures over helper functions

Use pytest fixtures instead of decorated helper functions:

**Good:**
```python
@pytest.fixture
def dynamo_client():
    with mock_aws():
        client = boto3.client("dynamodb", region_name="us-east-1")
        client.create_table(
            TableName="test-table",
            AttributeDefinitions=[{"AttributeName": "pk", "AttributeType": "S"}],
            KeySchema=[{"AttributeName": "pk", "KeyType": "HASH"}],
            BillingMode="PAY_PER_REQUEST",
        )
        yield client


def test_get_state(dynamo_client):
    state = get_state(dynamo_client, "test-table", "validate", desired_node_count=1)
    assert state.update_needed
```

**Avoid:**
```python
@mock_aws
def configure_dynamo_db():
    client = boto3.client("dynamodb", region_name="us-east-1")
    client.create_table(...)
    return client


@mock_aws
def test_get_state():
    client = configure_dynamo_db()  # Redundant decorator stacking
    state = get_state(client, "test-table", "validate", desired_node_count=1)
    assert state.update_needed
```

### Always parametrize with descriptive IDs

```python
@pytest.mark.parametrize(
    ("input_email", "expected"),
    [
        pytest.param("user@example.com", True, id="valid email"),
        pytest.param("user@localhost", False, id="missing TLD"),
        pytest.param("", False, id="empty string"),
        pytest.param(None, False, id="None"),
    ],
)
def test_is_valid_email(input_email, expected):
    assert is_valid_email(input_email) == expected
```

Each test should verify one behavior. Split tests that check multiple things:

**Good:**
```python
def test_scale_deployment_updates_replica_count(mock_kube_client):
    scale_deployment(mock_kube_client, replicas=5)
    assert mock_kube_client.patch_namespaced_deployment_scale.called


def test_scale_deployment_targets_correct_deployment(mock_kube_client):
    scale_deployment(mock_kube_client, replicas=5)
    call_kwargs = mock_kube_client.patch_namespaced_deployment_scale.call_args.kwargs
    assert call_kwargs["name"] == "gpu-placeholder"
```

Include tests for failure cases:

```python
def test_get_state_raises_on_dynamo_error(dynamo_client):
    dynamo_client.delete_table(TableName="test-table")
    with pytest.raises(ValueError, match="Failed to recover state"):
        get_state(dynamo_client, "test-table", "validate", desired_node_count=1)
```
