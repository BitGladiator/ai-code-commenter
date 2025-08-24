# ✨ AI Code Commenter

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-Bash-orange.svg)
![AI Powered](https://img.shields.io/badge/AI-Powered-purple.svg)

*Transform your code into self-documenting masterpieces with AI-powered intelligent commenting*

[Features](#-features) • [Quick Start](#-quick-start) • [Usage](#-usage) • [Examples](#-examples) • [Configuration](#-configuration)

</div>

---

## 🎯 What is AI Code Commenter?

AI Code Commenter is an intelligent command-line tool that leverages cutting-edge AI models to automatically generate comprehensive, contextual comments for your codebase. Say goodbye to undocumented code and hello to crystal-clear, maintainable projects.

### 🌟 Why Choose AI Code Commenter?

- **🧠 Intelligent Analysis**: Uses advanced AI models to understand code context and purpose
- **🚀 Lightning Fast**: Comment entire files in seconds
- **🔄 Real-time Watching**: Automatically comments files as you code
- **🌍 Universal Language Support**: Works with 15+ programming languages
- **🎨 Clean Output**: Generates professional, readable comments
- **⚡ Zero Dependencies**: Simple bash script with minimal requirements

---

## 🚀 Features

<table>
<tr>
<td width="50%">

### 🎯 **Smart Commenting**
- Line-by-line intelligent analysis
- Context-aware explanations
- Preserves original code semantics
- Professional comment formatting

</td>
<td width="50%">

### 🔄 **Real-time Processing**
- Watch mode for live commenting
- Instant file change detection
- Seamless workflow integration
- Automatic output organization

</td>
</tr>
<tr>
<td>

### 🌐 **Multi-Language Support**
- Python, JavaScript, TypeScript
- C++, Java, Go, Rust
- PHP, Ruby, Swift, Kotlin
- SQL, HTML, CSS, YAML
- And many more...

</td>
<td>

### 🤖 **AI Model Flexibility**
- Multiple OpenRouter models
- GPT-4, Claude, Gemini support
- Custom model selection
- Optimized prompting

</td>
</tr>
</table>

---

## 📸 Preview

<div align="center">

**Before & After Transformation**

</div>

```python
# 🔴 BEFORE: Cryptic code
def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        print(a)
        a, b = b, a + b
```

```python
# 🟢 AFTER: Self-documenting code
def fibonacci(n):  # define a function named fibonacci that takes one parameter n
    a, b = 0, 1  # initialize two variables: a holds the "current" Fibonacci number (0), b holds the "next" (1)
    for _ in range(n):  # loop exactly n times; '_' is used because the loop index itself is not needed
        print(a)  # print the current Fibonacci number
        a, b = b, a + b  # update both variables simultaneously:
                        # new a becomes the old b (next number),
                        # new b becomes the sum of the old a and old b (the subsequent number)
```

---

## 🚀 Quick Start

### Prerequisites

Ensure you have the following installed:

```bash
# Essential tools
bash >= 4.0
jq >= 1.6
curl >= 7.0
```

### Installation

```bash
# 1️⃣ Clone the repository
git clone https://github.com/yourusername/ai-code-commenter.git
cd ai-code-commenter/scripts

# 2️⃣ Set up your OpenRouter API key
echo "OPENROUTER_API_KEY=your_api_key_here" > ../.env

# 3️⃣ Make the script executable
chmod +x commenter.sh

# 4️⃣ You're ready to go! 🎉
```

### Get Your API Key

1. Visit [OpenRouter](https://openrouter.ai/)
2. Sign up for a free account
3. Generate your API key
4. Add it to your `.env` file

---

## 💻 Usage

### Basic Usage

```bash
# Comment a single file
./commenter.sh ../input/your_code.py

# Use a specific AI model
./commenter.sh ../input/your_code.py openai/gpt-4o-mini
```

### Watch Mode (Real-time)

```bash
# Watch a directory for changes
./commenter.sh --watch ../input/

# AI will automatically comment any modified files
```

### Supported Models

| Model | Provider | Best For |
|-------|----------|----------|
| `openai/gpt-4o-mini` | OpenAI | Balanced performance |
| `anthropic/claude-3-haiku` | Anthropic | Fast processing |
| `google/gemini-flash-1.5` | Google | Creative explanations |
| `meta-llama/llama-3.1-8b` | Meta | Open source |

---

## 🎨 Examples

### Python Example

<details>
<summary><b>🐍 Prime Number Checker</b></summary>

**Input:**
```python
def is_prime(num):
    if num <= 1:
        return False
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            return False
    return True
```

**Output:**
```python
def is_prime(num):  # define a function to test whether num is a prime number
    if num <= 1:  # by definition, numbers <= 1 are not prime
        return False  # return False immediately for num <= 1
    for i in range(2, int(num ** 0.5) + 1):  # test potential divisors from 2 up to floor(sqrt(num))
        # using sqrt(num) is sufficient because if num had a divisor > sqrt(num),
        # it would be paired with a divisor < sqrt(num) which we would have already tested
        if num % i == 0:  # if i divides num evenly (remainder zero)
            return False  # num is composite, so return False
    return True  # no divisors found, num is prime (return True)
```

</details>

### JavaScript Example

<details>
<summary><b>🚀 Async Data Fetcher</b></summary>

**Input:**
```javascript
async function fetchUserData(userId) {
    const response = await fetch(`/api/users/${userId}`);
    return response.json();
}
```

**Output:**
```javascript
async function fetchUserData(userId) {  // define an asynchronous function to retrieve user data by ID
    const response = await fetch(`/api/users/${userId}`);  // make HTTP GET request to user endpoint, wait for response
    return response.json();  // parse response body as JSON and return the parsed object
}
```

</details>

---

## 📁 Project Structure

```
ai-code-commenter/
├── 📂 input/                    # Your original code files
├── 📂 output/                   # AI-commented output files
├── 📂 scripts/
│   └── 🔧 commenter.sh         # Main commenting engine
├── 📂 images/
│   └── 🖼️ screenshot.png        # Preview images
├── 📄 .env                      # API configuration
├── 📄 .gitignore               # Git ignore rules
└── 📖 README.md                # This file
```

---

## ⚙️ Configuration

### Environment Variables

Create a `.env` file in the project root:

```bash
# OpenRouter API Configuration
OPENROUTER_API_KEY=your_api_key_here

# Optional: Default model preference
DEFAULT_MODEL=openai/gpt-4o-mini

# Optional: Output formatting
COMMENT_STYLE=detailed  # options: minimal, detailed, verbose
```

### Advanced Options

You can customize the commenting behavior by modifying the script variables:

```bash
# Model temperature (creativity level)
TEMPERATURE=0.2  # 0.0 = deterministic, 1.0 = creative

# Maximum tokens per request
MAX_TOKENS=3000

# Comment verbosity
VERBOSITY=detailed  # minimal, standard, detailed, verbose
```

---

## 🔧 Troubleshooting

### Common Issues

<details>
<summary><b>❌ "OPENROUTER_API_KEY not set" Error</b></summary>

**Solution:**
1. Verify your `.env` file exists in the project root
2. Check that the API key is properly formatted
3. Ensure no extra spaces around the `=` sign

```bash
# Correct format
OPENROUTER_API_KEY=sk-or-v1-your-key-here

# Incorrect format
OPENROUTER_API_KEY = sk-or-v1-your-key-here
```

</details>

<details>
<summary><b>🔄 Watch Mode Not Working</b></summary>

**Solution:**
Install `inotify-tools` on Linux:
```bash
# Ubuntu/Debian
sudo apt-get install inotify-tools

# CentOS/RHEL
sudo yum install inotify-tools
```

</details>

<details>
<summary><b>📝 Empty Output Files</b></summary>

**Solution:**
1. Check your internet connection
2. Verify API key has sufficient credits
3. Try a different AI model
4. Check file permissions in the output directory

</details>

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **🍴 Fork the repository**
2. **🌿 Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **💾 Commit your changes**: `git commit -m 'Add amazing feature'`
4. **📤 Push to branch**: `git push origin feature/amazing-feature`
5. **🔄 Open a Pull Request**

### Development Setup

```bash
# Clone your fork
git clone https://github.com/yourusername/ai-code-commenter.git

# Create development environment
cd ai-code-commenter
cp .env.example .env

# Test the script
cd scripts
./commenter.sh ../input/sample_code.py
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **OpenRouter** for providing access to multiple AI models
- **The Open Source Community** for inspiration and support
- **All Contributors** who help make this project better

---

<div align="center">

**⭐ Star this repo if it helped you write better code! ⭐**

Made with ❤️ by developers, for developers

[Report Bug](https://github.com/bitgladiator/ai-code-commenter/issues) • [Request Feature](https://github.com/bitgladiator/ai-code-commenter/issues) • [Join Discussion](https://github.com/bitgladiator/ai-code-commenter/discussions)

</div>
