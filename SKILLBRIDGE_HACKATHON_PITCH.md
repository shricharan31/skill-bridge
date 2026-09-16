# SkillBridge Hackathon Pitch and Implementation Guide

## 1. One-sentence pitch

**SkillBridge is a personalized education-to-career navigation platform that turns a learner’s current study level, field of interest, available time, and destination into one accepted roadmap of skills, verified learning routes, and job opportunities.**

## 2. The problem

Learners face an information problem rather than a lack of information. Courses, skills, degrees, jobs, and career advice are distributed across disconnected websites. A learner may know the field they like but still not know what to learn first, how much time to allocate, which programme direction to choose, or how a course connects to an opportunity.

SkillBridge addresses this gap by collecting the learner’s coordinates once and converting them into a sequence of actionable steps. The product is designed for school learners, university students, working professionals, and career switchers.

## 3. The solution

The product uses **SAIL**, an AI career navigator whose name and interaction model are based on navigation. SAIL asks mandatory onboarding questions immediately after a learner’s first sign-in. These questions cover the level of study from Class 8th through PhD, age, field of interest, study direction, weekly time commitment, and completion timeline.

For undergraduate, postgraduate, and PhD learners, the flow exposes a dropdown containing India and abroad study directions. The learner then sees a roadmap before entering the full dashboard. The learner must review and accept the roadmap. After acceptance, the Learning Hub displays only the verified learning routes connected to that roadmap.

The platform also includes a manager portal. Managers can switch between Overview, Learners, Catalogue, and Quality Checks. The manager view provides visibility into learner activity, catalogue readiness, source quality, link freshness, and recommendation coverage.

## 4. Demonstration flow for the pitch

| Step | Demonstration action | What the judges should notice |
|---|---|---|
| 1 | Open the landing page | The bridge-inspired interface communicates progression rather than a generic dashboard. |
| 2 | Select **Sign in** | Authentication is account-based and the learner dashboard is role-aware. |
| 3 | Sign in as a first-time learner | SAIL opens immediately and cannot be bypassed until the required coordinates are supplied. |
| 4 | Select a level such as Undergraduate | The study-program dropdown includes India and abroad pathways. |
| 5 | Select interest, weekly hours, and timeline | Recommendations are explainable and grounded in the learner’s available capacity. |
| 6 | Select **Show my roadmap** | SAIL presents the roadmap before the user enters the course plan. |
| 7 | Select **Accept roadmap & continue** | The learner dashboard becomes focused on the accepted roadmap rather than an unfiltered catalogue. |
| 8 | Open SAIL | The learner can type, use microphone input where browser support exists, and hear SAIL responses through speech synthesis. |
| 9 | Open Manager Portal | The manager can switch among Overview, Learners, Catalogue, and Quality Checks. |
| 10 | Open Catalogue or QC | The manager sees publication status, verification state, link quality, and source freshness signals. |

For the seeded manager preview, use `manager@skillbridge.in` with the supplied manager password. Do not expose this password in a public recording or production deployment.

## 5. Manager portal capabilities

The manager portal now has four working tabs.

| Tab | Purpose | Demonstrated data |
|---|---|---|
| **Overview** | Monitor the health of the SkillBridge ecosystem. | Registered learners, active learners, mapped skills, pathways, momentum, and demand signals. |
| **Learners** | Review learner movement and profile completion. | Learner name, email, field of interest, status, and last-seen date. |
| **Catalogue** | Review the content that powers recommendations. | Skills, routes, courses, coverage area, publication state, and quality state. |
| **Quality Checks** | Provide a release-readiness view. | Course-link resolution, job freshness, recommendation coverage, and QC warnings. |

The catalogue and quality-control panels are intentionally demo-ready. They show the operational workflow a real manager would use before publishing new content.

## 6. SAIL voice assistance

SAIL supports two browser-native voice features.

First, the microphone button uses the browser Speech Recognition API when the browser exposes `SpeechRecognition` or `webkitSpeechRecognition`. The recognized text is placed into the chat composer so the learner can review it before sending.

Second, assistant responses can be spoken with the browser Speech Synthesis API. The voice button can replay the most recent response or stop an active utterance.

This approach avoids an additional audio service for the hackathon demo. The experience degrades gracefully: on browsers without speech recognition, the learner can continue using typed chat, while speech synthesis remains available where supported.

## 7. How it was built

The application was rebuilt as a full-stack React and TypeScript web application.

| Layer | Technology or service | Role |
|---|---|---|
| Frontend | React 19, TypeScript, Vite | Component-based user and manager experiences. |
| Styling | Tailwind-compatible design system plus project CSS tokens | Responsive layouts, bridge visual language, cards, modals, and dashboards. |
| UI primitives | Radix/shadcn-style components and Lucide icons | Accessible buttons, inputs, cards, tooltips, icons, and layout primitives. |
| Backend | Node.js, Express, tRPC | Typed client-server procedures and server-side business logic. |
| Database | MySQL/TiDB through Drizzle ORM and `mysql2` | Accounts, profiles, catalogue records, learning resources, jobs, and progress items. |
| Authentication | Local account flow plus existing Manus authentication infrastructure | Sign-up, password login, role-aware manager access, and logout. |
| AI | Manus built-in LLM gateway through `invokeLLM` | SAIL responses with learner-profile context. |
| Voice | Browser Speech Recognition and Speech Synthesis APIs | Voice input and spoken SAIL responses without a separate voice vendor. |
| External data | Remotive remote-job API with curated source links | Live job signals plus resilient fallback trend cards. |
| Storage | Manus storage path for the supplied logo | Reliable logo delivery without bundling a large binary in the source tree. |
| Testing | Vitest and TypeScript compiler | Authentication, trends, profile-contract, logout, and type-safety checks. |
| Deployment workflow | Manus WebDev preview and version checkpoints | Live preview, shared project updates, diagnostics, and rollback-ready checkpoints. |

## 8. Data and recommendation logic

The central learner record stores education level, age, selected programme direction, field of interest, goal, timeline, weekly hours, and reminder preference. The profile contract validates the required fields on the server, so the browser is not the only enforcement layer.

Skill recommendations are primarily matched from **education level and field of interest**, as requested. The goal and timeline are retained for roadmap language, reminders, and SAIL context. Job recommendations are matched to the selected field and related skill tags.

The learner dashboard separates the general recommendation layer from the accepted course path. Once the learner accepts the roadmap, the Learning Hub filters displayed resources to roadmap-related terms. This keeps the next action focused and avoids overwhelming the learner with unrelated courses.

## 9. Why the architecture is appropriate for the hackathon

The application uses tRPC so the frontend and backend share typed procedure contracts. This reduces integration errors during rapid development. Drizzle provides a typed schema that can be migrated into MySQL. The fallback catalogue allows the product to remain demonstrable even when an external job source is unavailable.

The browser-native voice layer was selected because it is fast to demonstrate, has no API-key configuration, and makes the core SAIL interaction more accessible. A production version could replace or augment it with server-side transcription and a managed text-to-speech provider for consistent support across browsers and languages.

## 10. Likely judge questions and strong answers

### What problem are you solving?

We solve the transition problem between education and opportunity. Learners can find thousands of courses and jobs, but they need a clear first step. SkillBridge converts their current level and interest into one explainable path instead of another unfiltered search page.

### What makes this different from a course marketplace?

A course marketplace primarily helps users browse inventory. SkillBridge begins with the learner’s coordinates, produces a roadmap, asks for acceptance, and then limits the next actions to that roadmap. It connects skills, courses, jobs, reminders, and progress in one journey.

### Why is SAIL needed?

SAIL gives the onboarding process a conversational interface. It asks the questions that are often missing from generic recommendation systems: study level, programme direction, interest, available weekly time, and timeline. It also remains available as a navigator after onboarding.

### How do you prevent irrelevant recommendations?

We use a constrained recommendation path. The system matches the learner’s field and education level, displays a roadmap before the course list, requires acceptance, and then filters the Learning Hub to roadmap-related learning routes. The manager Quality Checks tab provides a review point for catalogue quality.

### How do you support learners at different education levels?

The onboarding dropdown covers Class 8th, Class 9th, Class 10th, Class 11th, Class 12th, Diploma, Undergraduate, Postgraduate, PhD, Working Professional, and Career Switcher. For higher-study levels, the product additionally asks the learner to choose an India or abroad direction.

### What happens when live job data is unavailable?

The application uses a resilient two-layer model. It attempts to fetch live remote roles, but it also retains curated trend and job cards with direct source links. The product remains usable while transparently separating live signals from curated signals.

### Is the AI hallucination-safe?

SAIL is instructed not to invent course providers or promise employment. The product also presents verified course destinations and source links outside the conversational layer. For production, we would add retrieval-backed answers, provider verification, citation display, and manager approval before a resource becomes visible.

### How is user data protected?

The server validates profile fields, stores password hashes rather than plaintext passwords, separates manager and learner roles, and keeps business logic in server procedures. A production hardening phase would add stronger password hashing such as Argon2 or bcrypt, rate limiting, audit logs, secure session rotation, and consent controls for voice recordings.

### How does the manager portal help scale the product?

The manager portal creates an operational feedback loop. Managers can inspect learners, catalogue coverage, publication state, source verification, link freshness, and recommendation quality. This turns the product from a static recommendation demo into a maintainable learning-navigation system.

### Why did you choose browser-native voice?

It gives us an immediate, low-friction demo with no additional vendor setup. The interface continues to work with text if a browser does not support speech recognition. A production deployment would add a consistent server-side transcription and speech provider.

### What would you build next?

We would add real programme and university datasets with filters for country, budget, entrance requirements, and delivery mode. We would add multilingual SAIL support, learner application tracking, verified employer integrations, and manager CRUD workflows for catalogue approval.

### What is your success metric?

The primary metric is **first-plank activation**: the percentage of signed-in learners who complete onboarding, accept a roadmap, and open or begin the first recommended learning route. Secondary metrics include roadmap completion, reminder engagement, profile completion, course-link quality, and transition from learning route to job opportunity.

## 11. Two-minute pitch script

“SkillBridge helps learners answer a simple but difficult question: what should I do next? Today, education, courses, careers, and jobs are scattered across separate platforms. A learner may know their interest but still lack a sequence.

Our solution is a personalized bridge from education to opportunity. After first sign-in, SAIL, our AI navigator, asks for the learner’s study level, age, field of interest, available weekly time, timeline, and study direction. If the learner is an undergraduate or above, they can choose an India or abroad pathway. SAIL then presents a roadmap before the learner sees the course plan. The learner accepts that roadmap, and the platform shows only the learning routes connected to it.

The same product supports managers. Overview shows ecosystem health. Learners shows movement. Catalogue shows the content powering recommendations. Quality Checks shows whether links, jobs, and recommendation coverage are ready for release.

SAIL also supports voice interaction through browser-native speech recognition and speech synthesis. The product is built with React, TypeScript, tRPC, Node, MySQL, Drizzle, and an LLM gateway. We designed it to be explainable, operationally reviewable, and useful even when a live job source is temporarily unavailable.

SkillBridge does not add another catalogue. It turns uncertainty into one clear next plank.”

## 12. Known demo notes

Voice recognition depends on browser permission and browser support. The microphone control should be demonstrated in a Chromium-based browser with microphone permission enabled. Typed chat remains the reliable fallback.

The live job feed is external and can change. The curated trend cards and direct course links are retained so the pitch remains stable even if the external service is slow.

The manager password is suitable only for the seeded preview. It should be rotated before any public deployment or recording.

## References

[1]: https://react.dev/ "React documentation"
[2]: https://www.typescriptlang.org/docs/ "TypeScript documentation"
[3]: https://trpc.io/docs "tRPC documentation"
[4]: https://orm.drizzle.team/docs/overview "Drizzle ORM documentation"
[5]: https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API "MDN Web Speech API documentation"
[6]: https://remotive.com/api-documentation "Remotive API documentation"
[7]: https://www.weforum.org/publications/the-future-of-jobs-report-2025/ "World Economic Forum Future of Jobs report"
