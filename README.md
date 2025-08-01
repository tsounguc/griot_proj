# 🧠 GRIOT

**“From thought to consciousware.”**

GRIOT is an experimental AI assistant inspired by the African griot tradition.  
It combines reflection, memory, identity modeling, and ambient voice interaction to become more than a chatbot—GRIOT is a witness.

This repo is the evolving codebase behind the [blog series](https://tsounguicodes.com/?s=Griot&post_type=post) documenting how I’m rebuilding my software mindset through GRIOT, using the Software Development Lifecycle (SDLC) as a guide.

---

## 💡 What is GRIOT?

- 🗣️ Listens via wake word or tap
- 🧠 Reflects on what you say using GPT + custom memory context
- 🪞Stores your sessions, mood, dreams, reflections, and more
- 🎯 Built with simplicity, modularity, and soul-aware design

---

## 🏗️ Architecture

Each folder represents a mental function:

- `user_input/`: handles speech input or tap triggers
- `understand/`: transcribe and analyze for meaning
- `model_context/`: tracks who you are and how you’re evolving
- `remember/`: saves memories, sessions, logs
- `reflect/`: wraps GPT + logic to create meaningful responses
- `core_loop/`: controls the flow of each session
- `voice_interface/`: speaks responses back to you
- `device_bridge/`: integrates with sensors or Apple Watch (future)

---

## 🧪 Status

This is a work-in-progress.  
See [Post 3 – Designing GRIOT to be Loosely Coupled and Cohesive](https://tsounguicodes.com/designing-griot-to-be-loosely-coupled-and-cohesive/) for design decisions.

Check out:
- [🧵 Blog Series on GRIOT](https://tsounguicodes.com/?s=Griot&post_type=post)
- [🎨 Architecture Diagram](https://tsounguicodes.com/design-architecture-mapping-griots-brain-modules-flows-and-responsibility/)
- [📁 Flow of a Session](https://tsounguicodes.com/design-architecture-mapping-griots-brain-modules-flows-and-responsibility/#session-sequence)

---

## 🛠️ Tech Stack

- Flutter (Clean Architecture, Bloc/Provider)
- GPT via OpenAI API
- Firestore + local persistence
- Audio plugins, background tasks
- Planned: Apple Health, SensorKit, etc.

---

## 🤝 Contributions

Right now, this is a solo learning project.  
If you’re building your own agentic assistant or want to share feedback, feel free to open an issue or start a discussion.

---

## 📜 License

TBD – this is still experimental.

---

> _“When you understand the shape of your system, you begin to understand the shape of your soul.”_
