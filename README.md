# CRAVE-TRINITY 🍒 MVP — Personalized Cravings Management App

**CRAVE-Trinity** is a watchOS/iOS/VisonOS stack built with **SwiftUI**/**SwiftData**, helping you track and manage your cravings through a clean, intuitive interface. Whether it’s late-night snacks or midday munchies, CRAVE ensures you stay in control.

![Cravey Watch Demo](https://raw.githubusercontent.com/The-Obstacle-Is-The-Way/crave-trinity/main/CravePhone/Resources/Images/CraveyWatchDemo.gif)

🔗 [Full-size GIF](https://github.com/The-Obstacle-Is-The-Way/crave-trinity/blob/main/CravePhone/Resources/Images/CraveyWatchDemo.gif)

📄 YC MVP Planning Document → https://docs.google.com/document/d/1kcK9C_-ynso44XMNej9MHrC_cZi7T8DXjF1hICOXOD4/edit?tab=t.0 

📄 Timeline of commits:
* 📌 **Feb 12–13:** [**CRAVE** (iOS MVP)](https://github.com/The-Obstacle-Is-The-Way/CRAVECRAVE) – Zero to basic SwiftUI app, craving logging.  
* 📌 **Feb 14–15:** [**crave-refactor** (Clean Architecture)](https://github.com/The-Obstacle-Is-The-Way/crave-refactor) – SwiftData + analytics debugging, major refactor.  
* 📌 **Feb 16–18:** [**isolated-crave-watch** (Apple Watch MVP)](https://github.com/The-Obstacle-Is-The-Way/isolated-crave-watch) – On-wrist craving logging, watch-to-phone sync.  
* 📌 **Feb 19:** [**crave-trinity** (Unified iOS + Watch + Vision)](https://github.com/The-Obstacle-Is-The-Way/crave-trinity) – Single codebase with AR/VR hooks for future expansion.

💡 Built in 7 days from scratch while learning Swift with AI acceleration and basecode abstraction. 
* Commit history proves my iteration speed—over 200 solving real programming problems. It wasn’t just copy-pasta spaghetti; I debugged, refactored, and solved SwiftData issues. I can learn, execute fast, and build something real. The marathon continues.

---

## **🦊 CRAVEY MVP **  
Most AI health startups today are **thin UI wrappers** over an LLM API. They call OpenAI, return a response, and slap a subscription on it. **That’s not CRAVE.**  

- CRAVE is an AI-powered cravings intelligence system, not just a chatbot. It provides deeper insights into cravings patterns and behaviors—helping users recognize trends and build awareness.
- CRAVE does not provide medical predictions or diagnostics. Due to the stochastic nature of LLMs, all insights remain analytical, not predictive.
- Predictive analytics would require FDA SaMD approval, and as such, features that generate risk-based insights will be sandboxed and clearly onboarded with disclaimers.
- A brief onboarding pictorial will ensure users fully understand the nature and limitations of AI-generated insights before engaging with CRAVE’s analytics.

### **MVP Goal: Build the First True AI-Powered Cravings Engine**  
- Apple Watch + iPhone as the user’s real-time cravings tracker.
- A backend that actually processes cravings patterns, not just logs them.
- A personal cravings insights engine that helps users recognize patterns over time.

---

## 🚀 Backend Architecture (MVP)
### 1️⃣ Data Pipeline – Logging & Structuring User Data
- **Users log cravings via Watch or iPhone (One-Tap Logging).**  
- **Data Captured:**  
  - **Timestamp, location, biometric data (HRV, sleep, glucose if available).**  
  - **Craving intensity, emotional state, environmental triggers.**  
- **Data is stored in a vector database (ChromaDB / Pinecone)** for **real-time retrieval in AI coaching.**  

---

### **2️⃣ RAG (Retrieval-Augmented Generation) – Making AI Actually Feel Personalized**
💡 **Why Not Fine-Tune Individual AI Models Per User?**  
- **Because compute costs make it impossible at scale today.**  
- Fine-tuning **1,000 models per 1,000 users is financially and computationally unfeasible.**  
- Instead, we use **RAG to retrieve user-specific past cravings data in real-time**—so AI feels personal **without model retraining.**  

🔹 **How It Works:**  
1. **User Asks AI:** “Why am I always craving sugar at night?”  
2. **Backend Queries Vector DB (ChromaDB)** → Finds the **most relevant past cravings logs.**  
3. **Injects User Data Into OpenAI API Call** → **LLM sees personal history before generating a response.**  
4. **User Gets a Response That Feels Fine-Tuned – But It’s Just RAG.**  

🔹 **Technical Stack:**  
- **Vector Database:** Pinecone / ChromaDB / Weaviate  
- **Embedding Model:** OpenAI `text-embedding-ada-002`  
- **Fast RAG Retrieval Pipeline:** LangChain / Custom Python  

🔥 **This Makes CRAVE AI Hyper-Personalized Without Per-User Fine-Tuning Costs.**  

---

### **3️⃣ LoRA (Low-Rank Adaptation) – Fine-Tuning Craving Personas**
💡 **What is LoRA?**  
- Traditional LLM fine-tuning **modifies the entire model.**  
- **LoRA (Low-Rank Adaptation) only fine-tunes specific layers** → **cheaper, faster, and can be done on consumer GPUs.**  
- This allows us to **create craving-specific mini-models without training from scratch.**  

🔹 **How We Use LoRA in CRAVE:**  
1. Instead of fine-tuning an AI model per user, we **fine-tune for craving personas.**  
2. Examples:  
   - **"Nighttime Binge Craving" LoRA Model**  
   - **"Alcohol Dopamine-Seeking Craving" LoRA Model**  
   - **"Stress-Induced Craving" LoRA Model**  
3. **User gets dynamically assigned to a craving archetype based on their patterns.**  
4. When they interact with AI, they get **RAG retrieval + LoRA-tuned craving-specific responses.**  

🔹 **Technical Stack:**  
- **LoRA Library:** `peft` (Hugging Face’s Parameter Efficient Fine-Tuning)  
- **Base Model:** Llama-2 / Mistral (Open-source) or GPT-based API  
- **Fine-Tuning Framework:** PyTorch + Hugging Face Transformers  

🔥 **This allows CRAVE AI to generate responses that feel more personalized without massive training costs.**  

---

## **🚀 Roadmap – How We Scale Beyond MVP**
🔹 **Phase 1: Build & Test RAG-Powered AI Cravings Chat**
- **Develop iOS + Watch front-end for seamless craving logging.**  
- **Implement RAG-backed retrieval pipeline to personalize AI coaching.**  
- **Deploy MVP chatbot that retrieves past craving history dynamically.**  

🔹 **Phase 2: Integrate LoRA Fine-Tuned Craving Personas**
- **Train LoRA models on different craving behaviors.**  
- **Assign users dynamically to craving personas based on their logged patterns.**  
- **AI responses now include both past cravings data (RAG) and craving-specific fine-tuning (LoRA).**  

🔹 **Phase 3: Real-Time AI Nudges & Predictive Analytics**
- **Cravings risk score prediction using time-series ML models.**  
- **Live AI interventions (push notifications, watch vibrations, voice nudges).**  
- **Integration with wearable data for real-time craving forecasting.**  

---

## **🚀 Why This is the Future**
❌ **Other AI health startups = Just a UI wrapper over an API.**  
✅ **CRAVE AI = True behavioral intelligence, using RAG + LoRA to create real personalization.**  

❌ **Most AI chatbots = Static, generic responses.**  
✅ **CRAVE AI = Adaptive, memory-driven, context-aware craving coaching.**  

❌ **Most digital health apps = Passive tracking.**  
✅ **CRAVE AI = Predictive, proactive, real-time AI interventions.**  

---

## **🚀 Final Word: Execution Begins Now**
This is **not theoretical.**  
This is **not a pitch deck.**  
This is **the backend I am actively building—step by step, function by function.**  

📌 **If you're reading this, you’re seeing a new kind of AI health platform being built in real-time.**  

Let’s build. 🚀


## **💥 MVP Structural Breakdown**  

The **CRAVE MVP** is an **AI-powered cravings intelligence system** designed to do more than just track cravings—it **predicts, analyzes, and adapts to user behaviors in real time.**  

**Key Objectives of the MVP:**  
1. **Apple Watch + iPhone** serve as the **cravings logging interface.**  
2. **Real-time AI-driven cravings intelligence, not just a basic tracker.**  
3. **A structured backend that processes cravings context, predicts trends, and adapts responses dynamically.**  
4. **No generic AI responses—every interaction is personalized through RAG retrieval and LoRA fine-tuning.**  

---

## **🚀 Backend Architecture Breakdown**  

### **1️⃣ Data Ingestion & Structuring**
🔹 **What This Does:**  
- Every craving log from the Watch/iPhone is stored in a structured format.  
- Captures **timestamp, location, biometric data, craving intensity, and triggers.**  
- **Data is embedded into a vector database** for AI retrieval later.  

🔹 **How We’ll Build It:**  
- **Vector DB:** ChromaDB / Pinecone (fast embedding search).  
- **Data Processing Pipeline:** Celery + Redis (asynchronous ingestion).  
- **Storage Layer:** PostgreSQL (structured cravings metadata).  

---

### **2️⃣ RAG (Retrieval-Augmented Generation) – Making AI Actually Feel Personalized**  
**🔹 What This Does:**  
- Ensures **AI responses are tailored to the user’s actual cravings history.**  
- Instead of sending a blank API call to OpenAI, it **retrieves the most relevant past craving logs and injects them into the prompt.**  

**🔹 Key Features for CRAVE's RAG Implementation:**  
✅ **Time-Optimized Retrieval** – The system prioritizes **recent cravings (last 30 days)** and gradually moves older cravings to a compressed "historical" layer.  
✅ **Chunking & Summarization** – Older cravings data isn’t deleted—it’s crunched into trend summaries and stored separately.  
✅ **Multi-Tier Retrieval** – If no recent cravings are relevant, it falls back to long-term behavioral patterns.  

**🔹 How We’ll Build It:**  
- **Vector Database:** ChromaDB / Pinecone (for embedding search).  
- **Text Summarization:** OpenAI’s `gpt-4-turbo` or T5 model (for trend compression).  
- **Retrieval Pipeline:** LangChain + FastAPI (serving past craving data to AI).  

🔥 **This allows AI responses to feel personal, even though we’re not fine-tuning an LLM per user.**  

---

### **3️⃣ LoRA (Low-Rank Adaptation) – Fine-Tuning for Craving Personas**
🔹 **What This Does:**  
- Instead of **fine-tuning per user (too expensive), we fine-tune for craving types.**  
- Example craving archetypes:  
  - **"Nighttime Binge Craving"**  
  - **"Alcohol Dopamine-Seeking Craving"**  
  - **"Stress-Induced Craving"**  
- Users are dynamically assigned to a craving archetype based on their logs.  
- This **allows small, efficient LoRA fine-tuning without massive compute costs.**  

🔹 **How We’ll Build It:**  
- **Fine-Tuning Framework:** Hugging Face’s `peft` (for LoRA).  
- **Base Model:** Llama-2 / Mistral (or OpenAI fine-tuning endpoint).  
- **Training Stack:** PyTorch + `bitsandbytes` (for efficient LoRA tuning).  

🔥 **LoRA makes craving-specific responses better than just using a generic OpenAI API call.**  

---

### **4️⃣ Predictive AI & Adaptive Coaching**  
🔹 **What This Does:**  
- **AI doesn’t just retrieve past cravings—it predicts when cravings will happen.**  
- **Users get AI nudges before high-risk craving moments occur.**  

🔹 **How We’ll Build It:**  
- **Time-Series Machine Learning Models (LSTMs, XGBoost) for craving pattern prediction.**  
- **Risk Scoring Algorithm** → Tracks **cravings frequency, intensity, and biometric fluctuations.**  
- **Real-time AI Nudges** → Delivered via push notifications, Siri voice nudges, or Watch vibrations.  

🔥 **This makes CRAVE an actual intervention tool, not just passive tracking.**  

---

## **🚀 Backend Execution Plan**
### **✅ Step 1: Implement RAG for Personalized Cravings AI**
- **Set up Vector DB for craving history retrieval.**  
- **Develop a pipeline that injects retrieved cravings into AI prompt generation.**  

### **✅ Step 2: Build LoRA Fine-Tuned Craving Personas**
- **Train mini LoRA models for distinct craving archetypes.**  
- **Dynamically assign users to the correct LoRA model based on past logs.**  

### **✅ Step 3: Develop AI-Powered Cravings Prediction**
- **Train ML models to predict cravings risk scores.**  
- **Deploy AI nudging system for proactive craving interventions.**  

---

## **🚀 Why This MVP is Built to Win**
💡 **Most AI health startups = Just UI wrappers over OpenAI.**  
💡 **CRAVE AI = A structured intelligence system for cravings that actually learns and adapts.**  

🔥 **This backend architecture is built to scale into a fully personalized AI cravings coach.**  

### **From humble MVP to Unicorn**  
📍 CRAVE has the potential to scale from simple B2C to aggregated population level data analytics 

<p align="center">
    <img src="https://raw.githubusercontent.com/The-Obstacle-Is-The-Way/crave-trinity/main/CravePhone/Resources/Images/high-vision-one-png.png" alt="CRAVE Vision" width="100%"/>
</p>

💡 Everyone is chasing B2B SaaS and agentic AI.
⚡️ We’re building for humans first—scaling to enterprises when the data speaks.  

Investors may think there’s no money in cravings management. **They’re wrong.**  
- Impulse control isn’t niche—it’s the **core of addiction, stress, dopamine loops, and digital overstimulation.**  
- **We start where others don’t:** organic traction → AI-driven insights → **B2B, healthcare, and digital therapeutics.**  

---

### 🔑 **How We Win**  
✅ **Organic growth → AI-backed coaching → B2B healthcare SaaS**  
✅ **Turn cravings data into a next-gen addiction & impulse control platform**  
✅ **Make CRAVE as viral as Duolingo streaks—dopamine resilience at scale**  

---

### **Individualized care & Biopsychosocial framework**
📍 CRAVE starts as a wellness/analytics app, but can integrate personalized care in the medical biopsychosocial framework. 

<p align="center">
    <img src="https://raw.githubusercontent.com/The-Obstacle-Is-The-Way/crave-trinity/main/CravePhone/Resources/Images/high-vision-two-privacy.png" alt="CRAVE Impact" width="100%"/>
</p>

---

📂 Project Structure

```bash
jj@Johns-MacBook-Pro-3 crave-trinity % tree -I ".git"
.
//  CRAVE
//  Because No One Should Have to Fight Alone.
//
//  In Memoriam:
//  - Juice WRLD (Jarad Higgins) [21]
//  - Lil Peep (Gustav Åhr) [21]
//  - Mac Miller (Malcolm McCormick) [26]
//  - Amy Winehouse [27]
//  - Jimi Hendrix [27]
//  - Heath Ledger [28]
//  - Chris Farley [33]
//  - Pimp C (Chad Butler) [33]
//  - Whitney Houston [48]
//  - Chandler Bing (Matthew Perry) [54]
//
//  And to all those lost to addiction,  
//  whose names are remembered in silence.  
//
//  Rest in power.  
//  This is for you.  
//
.
├── CravePhone
│   ├── Data
│   │   ├── DTOs
│   │   │   ├── AnalyticsDTO.swift
│   │   │   └── CravingDTO.swift
│   │   ├── DataSources
│   │   │   ├── Local
│   │   │   │   └── AnalyticsStorage.swift
│   │   │   └── Remote
│   │   │       ├── APIClient.swift
│   │   │       └── ModelContainer.swift
│   │   ├── Mappers
│   │   │   ├── AnalyticsMapper.swift
│   │   │   └── CravingMapper.swift
│   │   └── Repositories
│   │       ├── AnalyticsAggregatorImpl.swift
│   │       ├── AnalyticsRepositoryImpl.swift
│   │       ├── CravingManager.swift
│   │       ├── CravingRepositoryImpl.swift
│   │       └── PatternDetectionServiceImpl.swift
│   ├── Domain
│   │   ├── Entities
│   │   │   ├── Analytics
│   │   │   │   ├── AnalyticsEntity.swift
│   │   │   │   ├── AnalyticsEvent.swift
│   │   │   │   ├── AnalyticsMetadata.swift
│   │   │   │   └── BasicAnalyticsResult.swift
│   │   │   └── Craving
│   │   │       ├── CravingEntity.swift
│   │   │       └── CravingEvent.swift
│   │   ├── Interfaces
│   │   │   ├── Analytics
│   │   │   │   ├── AnalyticsAggregatorProtocol.swift
│   │   │   │   ├── AnalyticsRepositoryProtocol.swift
│   │   │   │   ├── AnalyticsStorageProtocol.swift
│   │   │   │   └── PatternDetectionServiceProtocol.swift
│   │   │   └── Repositories
│   │   │       ├── AnalyticsRepository.swift
│   │   │       └── CravingRepository.swift
│   │   ├── Services
│   │   └── UseCases
│   │       ├── Analytics
│   │       │   ├── AnalyticsAggregator.swift
│   │       │   ├── AnalyticsManager.swift
│   │       │   ├── AnalyticsProcessor.swift
│   │       │   ├── AnalyticsService.swift
│   │       │   ├── AnalyticsUseCases.swift
│   │       │   ├── EventTrackingService.swift
│   │       │   └── PatternDetectionService.swift
│   │       ├── Craving
│   │       │   ├── CravingAnalyzer.swift
│   │       │   ├── CravingUseCases.swift
│   │       │   └── DummyAddCravingUseCase.swift
│   │       └── PhoneConnectivityService.swift
│   ├── PhoneApp
│   │   ├── DI
│   │   │   └── DependencyContainer.swift
│   │   ├── Navigation
│   │   │   ├── AppCoordinator.swift
│   │   │   └── CRAVETabView.swift
│   │   └── PhoneApp.swift
│   ├── Presentation
│   │   ├── Common
│   │   │   ├── AlertInfo.swift
│   │   │   ├── DesignSystem
│   │   │   │   ├── Components
│   │   │   │   │   ├── CraveHaptics.swift
│   │   │   │   │   ├── CraveMinimalButton.swift
│   │   │   │   │   └── CraveTextEditor.swift
│   │   │   │   └── CraveTheme.swift
│   │   │   └── Extensions
│   │   │       ├── Date+Extensions.swift
│   │   │       └── View+Extensions.swift
│   │   ├── Configuration
│   │   │   ├── AnalyticsConfiguration+Defaults.swift
│   │   │   └── AnalyticsConfiguration.swift
│   │   ├── ViewModels
│   │   │   ├── Analytics
│   │   │   │   ├── AnalyticsDashboardViewModel.swift
│   │   │   │   └── AnalyticsViewModel.swift
│   │   │   └── Craving
│   │   │       ├── CravingListViewModel.swift
│   │   │       └── LogCravingViewModel.swift
│   │   └── Views
│   │       ├── Analytics
│   │       │   ├── AnalyticsDashboardView.swift
│   │       │   └── Components
│   │       │       ├── AnalyticsCharts.swift
│   │       │       ├── AnalyticsInsight.swift
│   │       │       └── InfiniteMarqueeTextView.swift
│   │       └── Craving
│   │           ├── Components
│   │           │   └── CravingCard.swift
│   │           ├── CoordinatorHostView.swift
│   │           ├── CravingIntensitySlider.swift
│   │           ├── CravingListView.swift
│   │           └── LogCravingView.swift
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   └── Contents.json
│   │   ├── Docs
│   │   │   ├── AnalyticsAPIReference.md
│   │   │   ├── AnalyticsArchitechture.md
│   │   │   └── AnalyticsImplementationGuide.md
│   │   ├── Images
│   │   │   ├── crave-architecture.svg
│   │   │   ├── crave-execution-flow.svg
│   │   │   ├── crave-logging-flow.svg
│   │   │   ├── crave-navigation-states.svg
│   │   │   ├── high-vision-one.svg
│   │   │   └── high-vision-two.svg
│   │   └── Preview Content
│   │       └── Preview Assets.xcassets
│   │           └── Contents.json
│   └── Tests
│       ├── AnalyticsTests
│       │   ├── Data
│       │   │   ├── AnalyticsAggregatorTests.swift
│       │   │   ├── AnalyticsConfigurationTests.swift
│       │   │   ├── AnalyticsCoordinatorTests.swift
│       │   │   ├── AnalyticsManagerTests.swift
│       │   │   ├── AnalyticsProcessorTests.swift
│       │   │   └── AnalyticsStorageTests.swift
│       │   ├── Domain
│       │   │   ├── AnalyticsEventTests.swift
│       │   │   ├── AnalyticsInsightTests.swift
│       │   │   ├── AnalyticsPatternTests.swift
│       │   │   └── AnalyticsPredictionTests.swift
│       │   └── Integration
│       │       ├── AnalyticsModelTests.swift
│       │       └── CravingAnalyticsIntegrationTests.swift
│       ├── CravingTests
│       │   ├── CravingManagerTests.swift
│       │   ├── CravingModelTests.swift
│       │   └── InteractionDataTests.swift
│       ├── Domain
│       │   ├── CravePhoneUITests.swift
│       │   └── CravePhoneUITestsLaunchTests.swift
│       ├── Integration
│       │   ├── CravePhoneUITests.swift
│       │   └── CravePhoneUITestsLaunchTests.swift
│       └── UITests
│           ├── CravePhoneUITests.swift
│           └── CravePhoneUITestsLaunchTests.swift
├── CraveTrinity.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── jj.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   ├── xcshareddata
│   │   └── xcschemes
│   │       ├── CravePhone.xcscheme
│   │       └── CraveWatch Watch App.xcscheme
│   └── xcuserdata
│       └── jj.xcuserdatad
│           └── xcschemes
│               └── xcschememanagement.plist
├── CraveVision
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.solidimagestack
│   │   │   ├── Back.solidimagestacklayer
│   │   │   │   ├── Content.imageset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   ├── Contents.json
│   │   │   ├── Front.solidimagestacklayer
│   │   │   │   ├── Content.imageset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   └── Middle.solidimagestacklayer
│   │   │       ├── Content.imageset
│   │   │       │   └── Contents.json
│   │   │       └── Contents.json
│   │   └── Contents.json
│   ├── ContentView.swift
│   ├── CraveVisionApp.swift
│   ├── CraveVisionTests
│   │   └── CraveVisionTests.swift
│   ├── Info.plist
│   ├── Packages
│   │   └── RealityKitContent
│   │       ├── Package.realitycomposerpro
│   │       │   ├── ProjectData
│   │       │   │   └── main.json
│   │       │   └── WorkspaceData
│   │       │       ├── SceneMetadataList.json
│   │       │       └── Settings.rcprojectdata
│   │       ├── Package.swift
│   │       ├── README.md
│   │       └── Sources
│   │           └── RealityKitContent
│   │               ├── RealityKitContent.rkassets
│   │               │   ├── Materials
│   │               │   │   └── GridMaterial.usda
│   │               │   └── Scene.usda
│   │               └── RealityKitContent.swift
│   └── Preview Content
│       └── Preview Assets.xcassets
│           └── Contents.json
├── CraveWatch
│   ├── Core
│   │   ├── Data
│   │   │   ├── DataSources
│   │   │   │   └── Local
│   │   │   │       └── LocalCravingScore.swift
│   │   │   ├── Mappers
│   │   │   │   └── CravingMapper.swift
│   │   │   └── Repositories
│   │   │       └── CravingRepository.swift
│   │   ├── Domain
│   │   │   ├── Entities
│   │   │   │   └── WatchCravingEntity.swift
│   │   │   ├── Interfaces
│   │   │   │   └── CravingRepositoryProtocol.swift
│   │   │   ├── UseCases
│   │   │   │   ├── EmergencyTriggerUseCase.swift
│   │   │   │   ├── LogCravingUseCase.swift
│   │   │   │   └── LogVitalUseCase.swift
│   │   │   └── WatchCravingError.swift
│   │   ├── Presentation
│   │   │   ├── Common
│   │   │   │   └── WatchCraveTextEditor.swift
│   │   │   ├── ViewModels
│   │   │   │   ├── CravingLogViewModel.swift
│   │   │   │   ├── EmergencyTriggerViewModel.swift
│   │   │   │   └── VitalsViewModel.swift
│   │   │   └── Views
│   │   │       ├── Components
│   │   │       │   ├── VerticalIntensityBar.swift
│   │   │       │   └── VerticalToggleBar.swift
│   │   │       ├── CravingIntensityView.swift
│   │   │       ├── CravingLogView.swift
│   │   │       ├── CravingPagesView.swift
│   │   │       ├── EmergencyTriggerView.swift
│   │   │       └── VitalsView.swift
│   │   ├── Resources
│   │   │   ├── Assets.xcassets
│   │   │   │   ├── AccentColor.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── AppIcon.appiconset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   └── Preview Content
│   │   │       └── Preview Assets.xcassets
│   │   │           └── Contents.json
│   │   ├── Services
│   │   │   ├── OfflineCravingSyncManager.swift
│   │   │   ├── WatchConnectivityService.swift
│   │   │   └── WatchHapticManager.swift
│   │   └── Tests
│   │       ├── Integration
│   │       │   ├── MockWatchConnectivityService.swift
│   │       │   └── OfflineCravingSyncManagerTests.swift
│   │       └── Unit
│   │           ├── CravingLogViewModelTests.swift
│   │           ├── EmergencyTriggerViewModelTests.swift
│   │           └── VitalsViewModelTests.swift
│   └── WatchApp
│       ├── DI
│       │   └── WatchDependencyContainer.swift
│       ├── Navigation
│       │   └── WatchCoordinator.swift
│       └── WatchApp.swift
└── README.md
```
---

## Architecture

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Resources/Docs/Images/crave-architecture.svg" alt="CRAVE Architecture" width="100%"/>

---

## Logging Flow

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Resources/Docs/Images/crave-logging-flow.svg" alt="CRAVE Logging Flow" width="100%"/>

---

## Navigation States

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Resources/Docs/Images/crave-navigation-states.svg" alt="CRAVE Navigation States" width="100%"/>

---

## Code Execution Flow 

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Resources/Docs/Images/crave-execution-flow.svg" alt="CRAVE Execution Flow" width="100%"/>

---

*This MVP has a solid MVVM foundation, and I'm in the process of pivoting to find a technical cofounder for YC. Once that's secured, I'll revisit and refine the code further.*

## 🌟 Architecture & Features

### Data Layer
- **SwiftData Integration**: Harnesses `@Model` for modern persistence and efficient CRUD operations.  
- **Soft Deletions**: Archives cravings instead of fully removing them, preserving data for potential analytics.  
- **Data Manager**: A dedicated `CravingManager` ensures thread-safe data access and state consistency.

### Design System
- **Centralized Tokens**: Unified colors, typography, and spacing for a polished, cohesive design.  
- **Reusable Components**: Custom buttons, text editors, and haptic feedback helpers.  
- **Adaptive Layout**: Responsive UI that looks great on various iOS screens.

### Core Features
- **Quick Logging**: Rapid craving entry with instant persistence.  
- **Smart History**: Cravings are grouped by date, with friendly placeholders if no data exists.  
- **Easy Management**: Swipe-to-archive, bulk edits, and other intuitive actions keep your list tidy.

### Technical Excellence
- **MVVM Architecture**: Leverages `@Observable` for clean, scalable state management.  
- **Comprehensive Testing**: Unit tests, UI tests, and ephemeral in-memory data configurations using XCTest.  
- **Performance Focus**: Swift animations, minimal overhead, and optimized data fetches keep the app smooth.

---

## 🚀 Roadmap
💎 Ultra Dank Roadmap for Voice, AI, and Analytics Integration

---

### **Phase 1: iOS Voice Recording Integration**
**Goal:** Let users record, store, and access voice logs for cravings.

**Steps:**
- **Implement Voice Recording:**  
  Use iOS's AVFoundation to build a simple voice recorder within the LogCravingView.
- **Data Integration:**  
  Extend SwiftData models to store audio files alongside text-based craving logs.
- **UI/UX:**  
  Add a recording button/icon (🍒🎙️) that toggles recording and playback.

**Deliverable:**  
A basic voice recording feature fully integrated into the iOS app.

---

### **Phase 2: Apple Watch Connectivity & Voice Recording**
**Goal:** Enable seamless voice recording on the Apple Watch with connectivity to iOS.

**Steps:**
- **Develop a WatchKit Companion App:**  
  Create a watchOS interface for recording and managing voice logs.
- **Connectivity Pairing:**  
  Leverage WatchConnectivity to sync recordings between the watch and iOS.
- **Smooth Integration:**  
  Ensure the watchOS UI is minimal and intuitive with immediate feedback.

**Deliverable:**  
A fully functional Apple Watch app that pairs with the iOS app, capturing voice recordings on the go.

---

### **Phase 3: Whisper AI API Integration**
**Goal:** Automate transcription and initial analysis of voice recordings.

**Steps:**
- **Integrate Whisper API:**  
  Connect to the Whisper AI API to convert voice recordings to text.
- **Real-Time Transcription:**  
  Process recordings from both iOS and watchOS in near real-time.
- **Display & Storage:**  
  Show transcriptions alongside existing craving logs, with options to edit or annotate.

**Deliverable:**  
Transcribed voice logs seamlessly integrated into the app’s craving history.

---

### **Phase 4: Rudimentary AI Analysis Module**
**Goal:** Offer users optional, experimental insights from their voice logs and cravings.

**Steps:**
- **Develop a Sandbox AI Module:**  
  Create an untrained AI module to analyze text and audio data for patterns (frequency, tone, sentiment).
- **User Opt-In:**  
  Allow users to choose whether to run this experimental analysis.
- **Basic Insights:**  
  Display simple analytics or trends that indicate potential trigger patterns.

**Deliverable:**  
A rudimentary AI analysis feature providing basic, actionable insights based on users’ logs.

---

### **Phase 5: Advanced Internal AI Integration**
**Goal:** Build and integrate a custom AI model for deep analysis of cravings and recordings.

**Steps:**
- **Data Collection & Model Training:**  
  Use gathered user data (with consent) to train a custom AI model in a controlled environment.
- **Internal AI Module:**  
  Integrate the model into the app for real-time, advanced pattern recognition and insights.
- **UI/UX Enhancements:**  
  Optimize insight displays to be actionable and user-friendly.

**Deliverable:**  
A robust internal AI capability that augments user data with advanced insights and predictive analytics.

---

### **Phase 6: Advanced Analytics & Insight Integration**
**Goal:** Provide deep analytics on craving patterns with contextual data.

**Steps:**
- **Craving Analytics Dashboard:**  
  Build a dashboard to analyze date/time trends, frequency, and patterns in cravings.
- **Location Analysis (Opt-In):**  
  Integrate location services to track where cravings occur; include user opt-in for privacy.
- **Watch Vitals Analytics:**  
  Capture and analyze watch metrics (heart rate, activity) during craving events.
- **Data Visualization:**  
  Use charts and graphs to present analytics in a clean, minimal UI.

**Deliverable:**  
A comprehensive analytics module offering users actionable insights into their craving behavior, including temporal trends, location contexts, and physiological data from the watch.

---

### **🔥 Best Steps Forward**
- **Iterate & Test:**  
  Run UI tests and gather user feedback at every phase to keep data and UI in sync.
- **Documentation:**  
  Maintain thorough documentation to support iterative development and onboarding.
- **Technical Cofounder:**  
  Prioritize finding a technical cofounder for YC to accelerate MVP refinement.
- **MVP Focus:**  
  Nail core functionalities (voice recording and connectivity) before scaling AI and analytics features.

---

## ⚙️ Development

Built with:
- **SwiftUI**  
- **SwiftData**  
- **Combine**  
- **XCTest**

**Requirements**:
- iOS 17.0+  
- Xcode 15.0+

Here’s the **banger, YC-ready** README setup section—clean, professional, and high-signal:  

---

# 🚀 **Setup & Installation**  

### **Clone the Repository**  
```bash
git clone https://github.com/The-Obstacle-Is-The-Way/crave-trinity.git
cd crave-trinity
```

### **Install Dependencies**  
If using CocoaPods for package management, run:  
```bash
pod install
```

### **Open the Project in Xcode**  
Use the `.xcodeproj` file (if applicable, e.g., using CocoaPods or SPM):  
```bash
open CraveTrinity.xcodeproj
```
Or manually open Xcode and select **File > Open...**  

### **Run the App**  
1. Select a **simulator** or **device** in Xcode.  
2. Press **Cmd + R** to build and run.  

---

### **Notes**  
- `CravePhone` is the iOS app.  
- `CraveWatch` is the Apple Watch extension.  
- `CraveVision` handles future AR/VR components.  
- Backend repo: [TBD or link if separate]  
- Supports **Swift Package Manager (SPM)** and **MVVM + SOLID** architecture.  

---
Here’s the **copy-paste-ready, YC-polished** **Contributing** section for your README:  

---

## 🤝 **Contributing**  

1. **Fork** this repository.  
2. **Create a new branch** *(e.g., `feature/new-ui`, `fix/crash-on-login`)*:  
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** and commit:  
   ```bash
   git commit -m "feat: Add [brief description of feature]"
   ```
4. **Push your branch**:  
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open a Pull Request** with a clear description of your changes.  

For issues, feature requests, or ideas, please [open an issue](https://github.com/The-Obstacle-Is-The-Way/crave-trinity/issues).  

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).

---

> **CRAVE**: Because understanding your cravings **shouldn’t** be complicated. 🍫  
