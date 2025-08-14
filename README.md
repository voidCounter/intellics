<div align="center">

<div style="display: flex; flex-flow: row nowrap; align-items: center; justify-content: center; gap: 12px; margin-bottom: 20px;">
  <img src="client/public/logo.svg" alt="IntelliCS Logo" width="48" height="48" />
  <h1 style="margin: 0; font-size: 2.5em; color: #2463eb;">IntelliCS: Intelligent Tutoring System for Computer Science</h1>
</div>

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-black.svg)](https://opensource.org/licenses/Apache-2.0)
[![Next.js](https://img.shields.io/badge/Next.js-13.0-black?logo=next.js)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-black?logo=typescript)](https://www.typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3.0-black?logo=tailwind-css)](https://tailwindcss.com/)

</div>

## 📚 Overview

IntelliCS is an Intelligent Tutoring System (ITS) designed to enhance computer science education through personalized learning experiences, adaptive scaffolding, and real-time feedback. The system implements proven ITS principles to provide an engaging and effective learning environment for students.

## 🎯 Motivation

Computer Science education faces several challenges:
- Students often struggle with complex concepts and problem-solving
- Traditional learning methods may not cater to individual learning styles
- Lack of immediate feedback and guidance
- Difficulty in tracking learning progress and identifying knowledge gaps

IntelliCS addresses these challenges by implementing key ITS principles:
- Providing instruction in problem-solving context
- Communicating goal structure underlying problem-solving
- Promoting abstract understanding of problem-solving knowledge
- Representing student competence as a production set
- Providing immediate feedback on errors
- Adapting to student mastery levels
- Advancing to more abstract material when appropriate
- Withholding problems students aren't ready for

## ✨ Core Features

### Hints System
- Contextual hints providing instruction in problem-solving context
- Support for both declarative information and worked examples
- Figures and text-based hints shown upon request
- Bottom-out hints for final solution guidance

### Scaffolding
- Interactive scaffolding with student questions
- Tutored problem solving approach
- Step-by-step problem breakdown
- Goal structure communication
- Procedural knowledge focus

### Mastery Estimation
- Knowledge Tracing algorithm implementation
- Hidden Markov Model-based cognitive mastery estimation
- Adaptive practice prescription
- Prevention of under/over practice
- Skill-level mastery tracking

### Knowledge Component Model
- Coarse-grained skill definitions
- Fine-grained competence representation
- Abstract understanding promotion
- Adaptive problem selection

### Data Collection
- Comprehensive student interaction logging
- Education data science support
- Research-friendly data format
- Interaction-level tracking

### Immediate Feedback
- Real-time answer correctness feedback

## 🛠️ Technology Stack

- **Frontend**: Next.js 13, TypeScript, Tailwind CSS
- **UI Components**: shadcn/ui
- **State Management**: Zustand
- **Deployment**: Cloudflare Pages
- **Analytics**: Custom implementation for learning analytics

## 🚀 Getting Started

### Prerequisites

- Node.js 20.x or later
- npm 9.x or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/voidCounter/intellics.git
   cd intellics
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run the development server:
   ```bash
   npm run dev
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.


### Completed Features ✅
- [x] UI components and design system implementation
- [x] Quiz system with multiple question types(written and multiple choice)
- [x] Basic scaffolding system
- [x] Progress tracking and analytics
- [x] Knowledge component tracking
- [x] CI/CD pipeline setup
- [x] Responsive design implementation
- [x] Immediate feedback system(for correct/incorrect response)
- [x] Basic hint system
- [x] Knowledge Tracing implementation
- [x] Student interaction logging

### In Progress 🚧
- [ ] Enhanced analytics dashboard
- [ ] Advanced scaffolding algorithms
- [ ] Performance optimizations
- [ ] Additional question types
- [ ] User authentication system
- [ ] Bottom-out hints implementation

### Planned Features 📝
- [ ] AI-powered learning recommendations

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License

This project is licensed under the Apache-2.0 license - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

### Research Papers

#### Foundational ITS and Learning Sciences
- [1] Koedinger, K. R., & Corbett, A. T. (2005). Cognitive tutors: Technology bringing learning sciences to the classroom. In R. K. Sawyer (Ed.), The Cambridge handbook of the learning sciences (pp. 61-78). Cambridge University Press. https://doi.org/10.1017/CBO9780511816833.006
- [2] VanLehn, K. (2011). The relative effectiveness of human tutoring, intelligent tutoring systems, and other tutoring systems. Educational Psychologist, 46(4), 197-221.
- [3] Corbett, A. T., & Anderson, J. R. (1995). Knowledge tracing: Modeling the acquisition of procedural knowledge. User Modeling and User-Adapted Interaction, 4(4), 253-278.

#### Knowledge Tracing and Learning Analytics
- [4] Bulut, O., Shin, J., Yildirim-Erbasli, S. N., Gorgun, G., & Pardos, Z. A. (2023). An introduction to Bayesian knowledge tracing with pyBKT. Psych, 5(3), 770-786. https://doi.org/10.3390/psych5030050
- [5] Cen, H., Koedinger, K., & Junker, B. (2006). Learning factors analysis – A general method for cognitive model evaluation and improvement. In M. Ikeda, K. D. Ashley, & T. W. Chan (Eds.), Intelligent Tutoring Systems (pp. 164-175). Springer. https://doi.org/10.1007/11774303_17

#### Systematic Reviews and Meta-Analyses
- [6] Lin, C. C., Huang, A. Y. Q., & Lu, O. H. T. (2023). Artificial intelligence in intelligent tutoring systems toward sustainable education: A systematic review. Smart Learning Environments, 10(1), 41. https://doi.org/10.1186/s40561-023-00260-y
- [7] Liu, V., Latif, E., & Zhai, X. (2025). Advancing education through tutoring systems: A systematic literature review. arXiv. https://doi.org/10.48550/arXiv.2503.09748
- [8] Mousavinasab, E., et al. (2021). Intelligent tutoring systems: A systematic review of characteristics, applications, and evaluation methods. Interactive Learning Environments, 29(1), 142-163. https://doi.org/10.1080/10494820.2018.1558257
- [9] Soofi, A. A., & Uddin, M. (2019). A systematic review of domains, techniques, delivery modes and validation methods for intelligent tutoring systems. International Journal of Advanced Computer Science and Applications, 10(3). https://doi.org/10.14569/IJACSA.2019.0100312

#### Implementation and Case Studies
- [10] Pardos, Z. A., et al. (2023). OATutor: An open-source adaptive tutoring system and curated content library for learning sciences research. In Proceedings of the 2023 CHI Conference on Human Factors in Computing Systems (pp. 1-17). ACM. https://doi.org/10.1145/3544548.3581574
- [11] Aleven, V., & Koedinger, K. R. (2002). An effective metacognitive strategy: Learning by doing and explaining with a computer-based Cognitive Tutor. Cognitive Science, 26(2), 147-179.
- [12] Koedinger, K. R., & Aleven, V. (2007). Exploring the assistance dilemma in experiments with Cognitive Tutors. Educational Psychology Review, 19(3), 239-264.
