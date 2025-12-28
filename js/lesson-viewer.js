// Vibe Coding Lesson Viewer
// Frontend script to display lessons in the lesson viewer page

/**
 * Load a lesson by its ID or by module and lesson number
 * @param {string} lessonId - The ID of the lesson to load
 * @param {string} moduleTitle - The title of the module (optional)
 * @param {number} lessonNumber - The lesson number (optional)
 */
async function loadLesson(lessonId = null, moduleTitle = null, lessonNumber = null) {
  try {
    let url = '/api/lesson';
    const params = new URLSearchParams();
    
    if (lessonId) {
      params.append('id', lessonId);
    } else if (moduleTitle && lessonNumber) {
      params.append('moduleTitle', moduleTitle);
      params.append('lessonNumber', lessonNumber);
    } else {
      throw new Error('Either lessonId or both moduleTitle and lessonNumber must be provided');
    }
    
    url += `?${params}`;
    
    const response = await fetch(url);
    const lesson = await response.json();
    
    if (!response.ok) {
      throw new Error(lesson.error || 'Failed to load lesson');
    }
    
    displayLesson(lesson);
  } catch (error) {
    console.error('Error loading lesson:', error);
    displayError(error.message);
  }
}

/**
 * Display the lesson content in the appropriate sections of the page
 * @param {Object} lesson - The lesson object to display
 */
function displayLesson(lesson) {
  // Update the page title
  document.title = `${lesson.lesson_title} - ${lesson.course_title}`;
  
  // Update the lesson header
  const lessonHeader = document.querySelector('.lesson-header');
  if (lessonHeader) {
    lessonHeader.innerHTML = `
      <h1>${lesson.lesson_title}</h1>
      <p class="lesson-meta">
        <span class="module-tag">${lesson.module_title}</span>
        <span class="lesson-number">Lesson ${lesson.lesson_number}</span>
      </p>
    `;
  }
  
  // Display the lesson content based on the JSON structure
  const lessonContent = document.getElementById('lesson-content');
  if (lessonContent) {
    lessonContent.innerHTML = `
      <section class="lesson-section introduction">
        <h2>Introduction</h2>
        <p>${lesson.lesson_content.introduction}</p>
      </section>
      
      <section class="lesson-section big-idea">
        <h2>Big Idea</h2>
        <div class="big-idea-content">
          <p>${lesson.lesson_content.big_idea}</p>
        </div>
      </section>
      
      <section class="lesson-section visuals">
        <h2>Visual Explanation</h2>
        <div class="visuals-content">
          <p>${lesson.lesson_content.visuals}</p>
        </div>
      </section>
      
      <section class="lesson-section steps">
        <h2>Step-by-Step Breakdown</h2>
        <ol class="steps-list">
          ${lesson.lesson_content.steps.map(step => `<li>${step}</li>`).join('')}
        </ol>
      </section>
      
      <section class="lesson-section example">
        <h2>Practical Example</h2>
        <div class="example-content">
          <p>${lesson.lesson_content.example}</p>
        </div>
      </section>
      
      <section class="lesson-section playground">
        <h2>Try It Yourself</h2>
        <div class="playground-content">
          <p>${lesson.lesson_content.playground_activity}</p>
          <div id="playground-area" class="playground-area">
            <!-- Playground content will be dynamically loaded here -->
          </div>
        </div>
      </section>
      
      <section class="lesson-section reflection">
        <h2>Reflection Question</h2>
        <div class="reflection-content">
          <p>${lesson.lesson_content.reflection_question}</p>
        </div>
      </section>
      
      <section class="lesson-section quiz">
        <h2>Quick Quiz</h2>
        <div class="quiz-content">
          ${renderQuiz(lesson.lesson_content.quiz)}
        </div>
      </section>
      
      <section class="lesson-section resources">
        <h2>Resources</h2>
        <div class="resources-content">
          ${renderResources(lesson.lesson_content.resources)}
        </div>
      </section>
      
      <section class="lesson-section summary">
        <h2>Summary</h2>
        <div class="summary-content">
          <p>${lesson.lesson_content.summary}</p>
        </div>
      </section>
      
      <div class="lesson-navigation">
        <button id="prev-lesson" class="btn btn-secondary">Previous Lesson</button>
        <button id="next-lesson" class="btn btn-primary">Next Lesson</button>
      </div>
    `;
  }
  
  // Initialize playground and quiz functionality
  initializePlayground();
  initializeQuiz();
  initializeNavigation(lesson);
}

/**
 * Render quiz questions and answers
 * @param {Object} quiz - The quiz object from the lesson
 */
function renderQuiz(quiz) {
  if (!quiz || !quiz.questions || !quiz.answers) return '<p>No quiz available for this lesson.</p>';
  
  return `
    <div id="quiz-container">
      ${quiz.questions.map((question, index) => `
        <div class="quiz-question">
          <p><strong>Question ${index + 1}:</strong> ${question}</p>
          <div class="quiz-options">
            <label><input type="radio" name="question-${index}" value="a"> Option A</label>
            <label><input type="radio" name="question-${index}" value="b"> Option B</label>
            <label><input type="radio" name="question-${index}" value="c"> Option C</label>
            <label><input type="radio" name="question-${index}" value="d"> Option D</label>
          </div>
        </div>
      `).join('')}
      <button id="submit-quiz" class="btn btn-primary">Submit Quiz</button>
      <div id="quiz-results"></div>
    </div>
  `;
}

/**
 * Render lesson resources
 * @param {Object} resources - The resources object from the lesson
 */
function renderResources(resources) {
  if (!resources) return '<p>No resources available for this lesson.</p>';
  
  let html = '';
  
  if (resources.video) {
    html += `
      <div class="video-resource">
        <h3>Recommended Video</h3>
        <p><strong>${resources.video.title}</strong> by ${resources.video.creator}</p>
        ${resources.video.embed 
          ? `<iframe width="560" height="315" src="" frameborder="0" allowfullscreen></iframe>`
          : `<p>${resources.video.reason}</p>`
        }
      </div>
    `;
  }
  
  if (resources.extra_reading && resources.extra_reading.length > 0) {
    html += `
      <div class="extra-reading">
        <h3>Extra Reading</h3>
        <ul>
          ${resources.extra_reading.map(link => `<li><a href="${link.split(' - ')[0]}" target="_blank">${link.split(' - ')[1] || link}</a></li>`).join('')}
        </ul>
      </div>
    `;
  }
  
  return html || '<p>No resources available for this lesson.</p>';
}

/**
 * Initialize playground functionality
 */
function initializePlayground() {
  // Placeholder for playground initialization
  // This would be where interactive elements are set up
  const playgroundArea = document.getElementById('playground-area');
  if (playgroundArea) {
    // For now, just add a message
    playgroundArea.innerHTML = '<p>This is where the interactive playground activity would appear.</p>';
  }
}

/**
 * Initialize quiz functionality
 */
function initializeQuiz() {
  const submitBtn = document.getElementById('submit-quiz');
  if (submitBtn) {
    submitBtn.addEventListener('click', function() {
      // Simple quiz submission logic
      const quizContainer = document.getElementById('quiz-container');
      const resultsDiv = document.getElementById('quiz-results');
      
      // Count correct answers (in a real implementation, we'd compare to the actual answers)
      let correct = 0;
      const questionCount = document.querySelectorAll('.quiz-question').length;
      
      resultsDiv.innerHTML = `<p>You answered ${correct} out of ${questionCount} questions correctly.</p>`;
    });
  }
}

/**
 * Initialize lesson navigation
 * @param {Object} currentLesson - The current lesson object
 */
function initializeNavigation(currentLesson) {
  // Set up next/previous lesson buttons
  const nextBtn = document.getElementById('next-lesson');
  const prevBtn = document.getElementById('prev-lesson');
  
  if (nextBtn) {
    nextBtn.addEventListener('click', function() {
      // In a real implementation, this would load the next lesson
      // For now, we'll just show an alert
      alert('Next lesson functionality would go here. In the complete system, this would load lesson ' + (currentLesson.lesson_number + 1));
    });
  }
  
  if (prevBtn) {
    prevBtn.addEventListener('click', function() {
      // In a real implementation, this would load the previous lesson
      // For now, we'll just show an alert
      if (currentLesson.lesson_number > 1) {
        alert('Previous lesson functionality would go here. In the complete system, this would load lesson ' + (currentLesson.lesson_number - 1));
      } else {
        alert('This is the first lesson in the module.');
      }
    });
  }
}

/**
 * Display an error message
 * @param {string} message - The error message to display
 */
function displayError(message) {
  const lessonContent = document.getElementById('lesson-content');
  if (lessonContent) {
    lessonContent.innerHTML = `
      <div class="error-message">
        <h2>Error Loading Lesson</h2>
        <p>${message}</p>
        <button onclick="location.reload()" class="btn btn-primary">Try Again</button>
      </div>
    `;
  }
}

/**
 * Initialize the lesson viewer when the page loads
 */
document.addEventListener('DOMContentLoaded', function() {
  // Check URL parameters to determine which lesson to load
  const urlParams = new URLSearchParams(window.location.search);
  const lessonId = urlParams.get('id');
  const moduleTitle = urlParams.get('module');
  const lessonNumber = urlParams.get('lesson');
  
  // If we have specific parameters, load that lesson
  if (lessonId) {
    loadLesson(lessonId);
  } else if (moduleTitle && lessonNumber) {
    loadLesson(null, moduleTitle, parseInt(lessonNumber));
  } else {
    // If no parameters, try to load the first lesson of the Vibe Coding course
    loadLesson(null, 'Understanding Vibe Coding', 1);
  }
});

// Scroll to top when page loads
window.addEventListener('load', function() {
  window.scrollTo(0, 0);
});

// Scroll to top when navigation occurs
window.addEventListener('beforeunload', function() {
  window.scrollTo(0, 0);
});

// Export functions for use in other modules (if using modules)
if (typeof module !== 'undefined' && module.exports) {
  module.exports = {
    loadLesson,
    displayLesson,
    renderQuiz,
    renderResources
  };
}