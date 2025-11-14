<div align="center">

<div style="display: flex; flex-flow: row nowrap; align-items: center; justify-content: center; gap: 8px; margin-bottom: -20px;">
  <img src="client/public/logo.svg" alt="IntelliCS Logo" width="48" height="48" style="margin-top:30px;"/>
  <h1 style="font-size: 2.5em; color: #2463eb;">IntelliCS</h1>
</div>

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-black.svg)](https://opensource.org/licenses/Apache-2.0)
![Spring Boot](https://img.shields.io/badge/springboot-black?logo=spring-boot&logoColor=white)
[![Next.js](https://img.shields.io/badge/Next.js-13.0-black?logo=next.js)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-black?logo=typescript)](https://www.typescriptlang.org/)
![Postgres](https://img.shields.io/badge/postgres-black?logo=postgresql&logoColor=white)
</div>

IntelliCS is an Intelligent Tutoring System (ITS) for computer science education. It provides personalized learning experiences by implementing key ITS principles such as providing immediate feedback, adapting to student mastery levels, and recommending appropriate content.

## Core Features

- **Adaptive Learning**: Recommends questions and lessons based on the student's estimated knowledge mastery, leveraging a Knowledge Tracing algorithm.
- **Hints and Scaffolding**: Offers contextual hints, worked examples, and interactive, step-by-step problem breakdowns to guide students.
- **Mastery Estimation**: Uses a Hidden Markov Model to track cognitive mastery at a fine-grained level (Knowledge Components), preventing under/over practice.
- **Comprehensive Data Collection**: Logs detailed student interactions, including question attempts, hint/scaffolding requests, and lesson progression to support educational data science.
- **Content**: Includes 51 knowledge components, 21 lessons, and 237 questions.

## Technology Stack

- **Frontend**: Next.js 13, TypeScript, Tailwind CSS
- **Backend**: Spring Boot, Java
- **Database**: PostgreSQL
- **UI Components**: shadcn/ui
- **State Management**: Zustand
- **Deployment**: Vercel

## Getting Started

### Prerequisites

- Node.js 20.x or later
- Java 17.x or later
- Maven 3.x or later (or use the included Maven wrapper)
- PostgreSQL 15.x or later
- npm 9.x or later

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/voidCounter/intellics.git
   cd intellics
   ```

2. **Set up the database:**
   ```bash
   cd backend
   docker compose up -d
   ```
   This starts a PostgreSQL database on port 5433.

3. **Configure backend secrets:**
   
   Create a `secrets.yml` file in `backend/src/main/resources/`:
   ```bash
   cd backend/src/main/resources
   cp secrets.yml.example secrets.yml
   ```
   
   Edit `secrets.yml` with your actual values:
   - **Database credentials**: Match your PostgreSQL setup (default from docker-compose: username=`postgres`, password=`password`, port=`5433`)
   - **Google OAuth**: Create credentials at [Google Cloud Console](https://console.cloud.google.com/)
     - Create a new OAuth 2.0 Client ID
     - Set authorized redirect URI: `http://localhost:8080/login/oauth2/code/google`
   - **JWT Secret**: Generate a strong random string (e.g., using `openssl rand -base64 64`)
   - **Admin emails**: Your email address for admin access
   - **OpenAI API Key**: Optional, can be left empty

4. **Run the backend:**
   ```bash
   cd backend
   ./mvnw spring-boot:run
   ```
   The backend will start on [http://localhost:8080](http://localhost:8080)

5. **Install and run the client:**
   ```bash
   cd client
   npm install
   npm run dev
   ```

6. **Open the application:**
   
   Navigate to [http://localhost:3000](http://localhost:3000) in your browser.

### In Progress
- [ ] Dynamic hints and scaffolds.
- [ ] Enhanced analytics dashboard
- [ ] Advanced scaffolding algorithms
- [ ] Performance optimizations
- [ ] Additional question types
- [ ] Admin dashboard

## License

This project is licensed under the Apache-2.0 license - see the [LICENSE](LICENSE) file for details.

<details>
<summary>Acknowledgments and Research Papers</summary>

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

</details>
