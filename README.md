# Superintendencia de Sociedades: Conversational AI & Regulatory NLP Platform

[![Platform](https://img.shields.io/badge/Platform-Google%20App%20Engine%20%7C%20GCP-4285F4?logo=googlecloud&logoColor=white)](https://cloud.google.com/)
[![Cognitive AI](https://img.shields.io/badge/NLP%20Engine-Microsoft%20LUIS.ai-0078D4?logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Framework](https://img.shields.io/badge/Framework-PHP%20Phalcon-7B3F98?logo=php&logoColor=white)](https://phalcon.io/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL%20%26%20Cloud%20Datastore-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Domain](https://img.shields.io/badge/Jurisdiction-Superintendencia%20de%20Sociedades-008000)](https://www.supersociedades.gov.co/)
[![Docker](https://img.shields.io/badge/Containers-Docker%20Compose-2496ED?logo=docker&logoColor=white)](#quick-start-with-docker-compose)

Production-grade LegalTech conversational intelligence system and natural language understanding (NLP) platform engineered for the **Superintendencia de Sociedades**, the official national regulatory and oversight body for commercial corporations in Colombia.

The platform provides an automated citizen assistance and legal orientation channel that interprets natural language queries, classifies corporate regulatory intents, retrieves authoritative legal doctrines, guides inquiries regarding corporate restructuring under **Insolvency Law 1116 of 2006**, explains company incorporation (such as **SAS under Law 1258 of 2008**), details the regime of **Auxiliares de la Justicia** (promoters and liquidators), and orchestrates an active learning feedback loop to continuously retrain cognitive models.

---

## System Architecture

The solution operates as a high-throughput, cloud-native micro-service designed for deployment on **Google App Engine** and containerized environments. It couples an external cognitive language model with an internal high-speed relational and NoSQL legal knowledge base.

```mermaid
flowchart TD
    subgraph Citizens ["1. Citizen & Legal Inquirer Layer"]
        A["Citizen Web Portal / Mobile Chat Widget"]
        B["JSON REST API Client (HTTPS POST)"]
    end

    subgraph Controller ["2. Application & Dispatching Layer (PHP Phalcon)"]
        C["Public Entrypoint (public/index.php)"]
        D["Dependency Injector (app/config/services.php)"]
        E["ChatbotController (app/controllers/ChatbotController.php)"]
        F["Accent Stripping & Normalizer (removeAccents)"]
    end

    subgraph Cognitive ["3. Cognitive NLU Engine (Microsoft LUIS)"]
        G["Microsoft LUIS Cognitive Services API"]
        H["Intent Classifier (Top Scoring Intent)"]
        I["Named Entity Recognizer (Corporate Entities & Actions)"]
    end

    subgraph Knowledge ["4. Authoritative Regulatory Knowledge Base (PostgreSQL)"]
        J["Insolvency & Restructuring Corpus (Ley 1116 de 2006)"]
        K["Commercial Corporate Forms (SAS, S.A., Ltda.)"]
        L["Auxiliares de la Justicia (Promotores, Liquidadores)"]
        M["Legal Concepts & Superintendencia Doctrines"]
        N["Time-Aware Contextual Greetings (Morning/Afternoon/Night)"]
        O["Static Q&A Fast Path (ExtraQuestions)"]
    end

    subgraph ActiveLearning ["5. Audit & Active Retraining Feedback"]
        P["Session History Audit Log (history table)"]
        Q["Unanswered Question Queue (not_found_questions)"]
        R["Legal Staff Review & Model Retraining Pipeline"]
    end

    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    G --> H
    G --> I

    H -- "Intent: Process / Insolvencia" --> J
    H -- "Intent: Sociedades" --> K
    H -- "Intent: AuxiliaryJustice" --> L
    H -- "Intent: Concepts" --> M
    H -- "Intent: Greeting" --> N
    H -- "Intent: None / Fallback" --> O

    E --> P
    O -- "Query Not Found" --> Q
    Q --> R
```

---

## Citizen Regulatory Query & Legal Reasoning Flow

```mermaid
sequenceDiagram
    autonumber
    actor Citizen as Citizen / Legal Representative
    participant Gateway as Phalcon API Gateway
    participant LUIS as Microsoft LUIS.ai Cognitive Engine
    participant DB as PostgreSQL Regulatory Knowledge Base
    participant Feedback as Active Learning Queue

    Citizen->>Gateway: POST /chatbot/getAnswer {"query": "¿Cómo acojo mi empresa a ley 1116?"}
    Gateway->>Gateway: Normalize text (accent removal, sanitization)
    Gateway->>LUIS: Request intent evaluation (Ocp-Apim-Subscription-Key)
    LUIS-->>Gateway: Return Top Intent: "Insolvencia" | Entities: ["Reorganizacion", "Ley 1116"]
    
    alt Intent Recognized with High Confidence
        Gateway->>DB: Query authoritative corpus (Insolvencia / Procesos)
        DB-->>Gateway: Return statutory guidance & requirements
        Gateway->>DB: Record interaction in history table (id_chat, query, answer, timestamp)
        Gateway-->>Citizen: 200 OK with verified legal guidance
    else Intent Low Confidence or None
        Gateway->>DB: Search secondary static rules (ExtraQuestions)
        alt Static Answer Located
            DB-->>Gateway: Return static answer
            Gateway-->>Citizen: 200 OK with informational response
        else Unresolved Query
            Gateway->>Feedback: Append to not_found_questions table for review
            Gateway-->>Citizen: 200 OK with institutional disclaimer & formal filing instructions
        end
    end
```

---

## Regulatory Domain Coverage

The knowledge base covers the core supervisory, judicial, and doctrinal responsibilities of the Superintendencia de Sociedades:

| Regulatory Area | Governing Legal Framework | Entities & Intents Handled | Description & Scope |
| :--- | :--- | :--- | :--- |
| **Insolvency & Restructuring** | Ley 1116 de 2006, D. 560/2020 | `Insolvencia`, `Procesos`, `Reorganizacion` | Preserving viable enterprises through creditor agreements, pre-packaged reorganization validation, and orderly judicial liquidations. |
| **Corporate Forms & SAS** | Ley 1258 de 2008, Código de Comercio | `Sociedades`, `SAS`, `Constitucion`, `Capital` | Formation, capital subscription (authorized/subscribed/paid), board of directors, shareholder assemblies, and statutory reform protocols. |
| **Auxiliares de la Justicia** | Régimen Único de Auxiliares | `AuxiliaryJustice`, `Liquidadores`, `Promotores` | Public registration requirements, professional experience criteria, conflict of interest regimes, incompatibilities, and fee determination. |
| **Legal Concepts & Doctrine** | Ley 222 de 1995, Art. 200 C.Co. | `Concepts`, `Administradores`, `Dividendos` | Administrator civil liabilities, conflict of interest management, dividend distributions, inspection, and formal supervisory inquiries. |
| **Institutional Orientation** | Trámites & Sedes SuperSociedades | `Information`, `Consult`, `Greeting` | Physical and regional offices (Medellín, Cali, Barranquilla, Bucaramanga), filing hours, and document tracking (*Consulta de Radicados*). |

---

## Active Learning & Unsupervised Query Capture

A core design principle of this platform is its resilience against out-of-distribution queries:
1. When Microsoft LUIS returns a top-scoring intent of `None` or confidence falls below the acceptance threshold, the query enters a fallback evaluation against `ExtraQuestions`.
2. If no matching response exists, the query is automatically logged into the **`not_found_questions`** repository with precise timestamps.
3. Legal analysts and NLP engineers at the Superintendencia review this unhandled query queue periodically, adding training utterances to Microsoft LUIS and creating specialized static answers, creating a closed-loop retraining cycle.

---

## Repository Structure

```
gcp-luisAI-supersociedades-conversational-bot/
├── app/
│   ├── config/
│   │   ├── config.php                      # Dynamic environment configuration
│   │   ├── loader.php                      # PSR-4 / Phalcon autoloader
│   │   ├── services.php                    # DI service container (DB, session, pusher)
│   │   └── credentials.json.example        # Sanitized GCP service account template
│   ├── controllers/
│   │   ├── ChatbotController.php           # Core intent routing & NLP evaluator (599 lines)
│   │   └── ControllerBase.php              # Base controller, JSON formatter, and LUIS client
│   ├── library/
│   │   ├── HttpRequestCurl.php             # Optimized HTTP request dispatcher
│   │   └── constants/                      # Service constants and enums
│   └── models/
│       ├── AuxiliaryJustice.php            # Court auxiliaries legal repository
│       ├── Concepts.php                    # Superintendencia official doctrinal concepts
│       ├── Consult.php                     # Citizen case and filing lookups
│       ├── ExtraQuestions.php              # Static FAQ dictionary for rapid matching
│       ├── General.php                     # Institutional competencies & general queries
│       ├── Greeting.php                    # Time-conditioned dynamic greetings
│       ├── History.php                     # Full conversational audit trail per session
│       ├── Information.php                 # Headquarters, hours, and physical facilities
│       ├── Insolvencia.php                 # Restructuring & insolvency rules (Ley 1116)
│       ├── NotFoundQuestions.php           # Active learning unhandled questions queue
│       ├── Procesos.php                    # Judicial restructuring proceedings
│       ├── Request.php                     # Session request records
│       ├── Sociedades.php                  # Mercantile company structures (SAS, S.A.)
│       └── UserChat.php                    # End-user profile tracking
├── docker/
│   └── init.sql                            # Complete PostgreSQL schema & legal seeds
├── scripts/
│   └── test_chatbot.py                     # Python automated test and verification suite
├── public/
│   ├── index.php                           # Application HTTP entrypoint
│   └── .htaccess                           # URL rewriting configuration
├── datastore_index.yaml                    # Google Cloud Datastore index definitions
├── Dockerfile                              # Production Apache + PHP 7.4/8.x runtime
├── docker-compose.yml                      # Local full-stack development orchestration
├── composer.json                           # PHP dependencies & Web3 autoloading
└── .gitignore                              # Production ignore rules
```

---

## Technical Specifications

| Parameter | Specification |
| :--- | :--- |
| **Backend Language** | PHP 7.4 / 8.x (High-Performance Phalcon Framework Architecture) |
| **NLP Engine** | Microsoft LUIS.ai (Language Understanding Intelligent Service) |
| **Relational Database** | PostgreSQL 15 / MariaDB 10.6 |
| **Cloud Hosting** | Google Cloud Platform (Google App Engine + Cloud Datastore) |
| **Asynchronous Realtime** | Pusher Channels Integration |
| **Containerization** | Docker Engine & Docker Compose |
| **Text Preprocessing** | Diacritics stripping, case normalization, and intent slot filling |

---

## Quick Start with Docker Compose

### Prerequisites
- Docker Engine 20.10+
- Docker Compose v2.0+
- Python 3.8+ (for automated verification test suite)

### 1. Launch the Stack
```bash
# Clone the repository
git clone git@github.com-personal:KevinAndrey96/gcp-luisAI-supersociedades-conversational-bot.git
cd gcp-luisAI-supersociedades-conversational-bot

# Start PostgreSQL and the PHP application
docker compose up -d
```

### 2. Verify Database Health
```bash
docker compose ps
# The 'postgres' container will report healthy once init.sql executes
```

### 3. Run Automated Queries
```bash
python3 scripts/test_chatbot.py
```

### 4. Manual API Query via cURL
```bash
curl -X POST http://localhost:8098/chatbot/getAnswer \
  -H "Content-Type: application/json" \
  -d '{
    "query": "buenos dias como constituyo una sas",
    "id_chat": "session-unique-abc-123"
  }'
```

---

## Security & Sanitization Notice

This repository has been cleansed using `git-filter-repo`:
- Google Cloud Platform service account private keys (`credentials.json`) have been removed from commit history. A template is provided at `app/config/credentials.json.example`.
- Microsoft Cognitive Services LUIS subscription keys, Pusher secrets, and database passwords have been replaced with configurable environment variables.
- Vendor dependency bundles and compiled phar binaries were pruned to optimize repository footprint.

---

## License & Institutional Credits

Developed by **Kevin Andrey Herrera Silva** for the **Superintendencia de Sociedades de Colombia**. All rights to official regulatory content, statutory procedures, and corporate doctrines belong to the Colombian state and the Superintendencia de Sociedades.
