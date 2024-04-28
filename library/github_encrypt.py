#!/usr/bin/env python

import base64
import requests

from ansible.module_utils.basic import AnsibleModule
from nacl.public import PublicKey, SealedBox


def fetch_public_key(owner, repo, token):
    url = f"https://api.github.com/repos/{owner}/{repo}/actions/secrets/public-key"
    headers = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/vnd.github.v3+json",
    }
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return response.json()["key"], response.json()["key_id"]


def encrypt_secret(public_key_b64, secret):
    public_key_bytes = base64.b64decode(public_key_b64)
    public_key = PublicKey(public_key_bytes)
    sealed_box = SealedBox(public_key)
    encrypted = sealed_box.encrypt(secret.encode())
    encrypted_b64 = base64.b64encode(encrypted).decode("utf-8")
    return encrypted_b64


def set_secret(
    owner_name, repo_name, secret_name, encrypted_secret, key_id, github_pat
):
    url = f"https://api.github.com/repos/{owner_name}/{repo_name}/actions/secrets/{secret_name}"
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {github_pat}",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    data = {"encrypted_value": encrypted_secret, "key_id": key_id}

    response = requests.put(url, headers=headers, json=data)

    if response.status_code >= 300 or response.status_code < 200:
        raise Exception(f"Failed to set secret: {response.text} {response.status_code}")


def delete_github_secret(owner, repo, secret_name, token):
    """
    Deletes a secret from a GitHub repository.

    Args:
    owner (str): The owner of the repository.
    repo (str): The repository name.
    secret_name (str): The name of the secret to delete.
    token (str): The GitHub personal access token.
    """
    url = f"https://api.github.com/repos/{owner}/{repo}/actions/secrets/{secret_name}"
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {token}",
        "X-GitHub-Api-Version": "2022-11-28",
    }

    response = requests.delete(url, headers=headers)

    # 404 is OK:
    if response.status_code == 404:
        return

    if response.status_code >= 300 or response.status_code < 200:
        raise Exception(f"Failed to delete secret: {response.text} status code: {response.status_code}")


def main():
    module_args = dict(
        owner=dict(type="str", required=True),
        repo=dict(type="str", required=True),
        token=dict(type="str", required=True, no_log=True),
        secret=dict(type="str", required=True, no_log=True),
        secret_name=dict(type="str", required=True),
        state=dict(type="str", choices=["present", "absent"], default="present"),
    )

    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    result = dict(changed=False, message="")

    if module.check_mode:
        module.exit_json(**result)

    try:
        if module.params["state"] == "absent":
            delete_github_secret(
                module.params["owner"],
                module.params["repo"],
                module.params["secret_name"],
                module.params["token"],
            )
        elif module.params["state"] == "present":
            public_key, key_id = fetch_public_key(
                module.params["owner"],
                module.params["repo"],
                module.params["token"],
            )
            encrypted_secret = encrypt_secret(public_key, module.params["secret"])
            result["encrypted_secret"] = encrypted_secret
            result["key_id"] = key_id
            set_secret(
                module.params["owner"],
                module.params["repo"],
                module.params["secret_name"],
                encrypted_secret,
                key_id,
                module.params["token"],
            )
        else:
            raise Exception(f"Invalid state: {module.params['state']}")

    except Exception as e:
        module.fail_json(msg=e, **result)

    module.exit_json(**result)


if __name__ == "__main__":
    main()
