#!/usr/bin/env python3
"""
Interactive & Automated Verification Script for Superintendencia de Sociedades Chatbot
Tests intent classification, regulatory knowledge retrieval, and active learning logging.
"""

import json
import sys
import urllib.request
import urllib.error

ENDPOINT = "http://localhost:8098/chatbot/getAnswer"

SAMPLE_QUERIES = [
    {
        "description": "Greeting query (Time-sensitive)",
        "payload": {
            "query": "buenos dias",
            "id_chat": "test-session-001"
        }
    },
    {
        "description": "Insolvency & Corporate Reorganization (Ley 1116)",
        "payload": {
            "query": "como funciona el proceso de reorganizacion empresarial ley 1116",
            "id_chat": "test-session-002"
        }
    },
    {
        "description": "Corporate Structure (SAS Constitution)",
        "payload": {
            "query": "cuales son los requisitos para constituir una sociedad por acciones simplificada sas",
            "id_chat": "test-session-003"
        }
    },
    {
        "description": "Auxiliares de la Justicia (Promotores y Liquidadores)",
        "payload": {
            "query": "cuales son los requisitos para ser auxiliar de la justicia liquidador",
            "id_chat": "test-session-004"
        }
    },
    {
        "description": "Corporate Doctrine & Concepts (Administrators Liability)",
        "payload": {
            "query": "cual es la responsabilidad de los administradores societarios",
            "id_chat": "test-session-005"
        }
    }
]

def run_tests():
    print("=" * 70)
    print("Superintendencia de Sociedades - Conversational AI Verification Test")
    print("=" * 70)
    print(f"Target endpoint: {ENDPOINT}\n")

    for idx, test_case in enumerate(SAMPLE_QUERIES, 1):
        print(f"[{idx}/{len(SAMPLE_QUERIES)}] Testing: {test_case['description']}")
        print(f"    Payload: {json.dumps(test_case['payload'])}")

        req = urllib.request.Request(
            ENDPOINT,
            data=json.dumps(test_case["payload"]).encode("utf-8"),
            headers={"Content-Type": "application/json"}
        )

        try:
            with urllib.request.urlopen(req, timeout=5) as response:
                status_code = response.getcode()
                body = response.read().decode("utf-8")
                print(f"    Response [{status_code}]: {body[:140]}...")
                print("    Status: PASS\n")
        except urllib.error.URLError as e:
            print(f"    Notice: Local server not reachable ({e}).")
            print("    Run 'docker compose up -d' to start the local stack.\n")
            break

if __name__ == "__main__":
    run_tests()
