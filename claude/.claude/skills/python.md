---
name: python
description: Python conventions, code style, and best practices. Trigger whenever the user is writing, reviewing, or modifying Python code — including adding modules, tests, CLI commands, or any .py files.
---

# Python Skill

Python conventions. Follow these whenever writing or reviewing `.py` files.

We're on Python 3.12 at least, which means type hint types do not need to be imported.

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
