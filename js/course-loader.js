async function loadCourse(slug) {
  try {
    // Convert slug to title format (e.g., 'vibe-coding' to 'Vibe Coding')
    const titleFromSlug = slug.split('-').map(word => 
      word.charAt(0).toUpperCase() + word.slice(1)
    ).join(' ');
    
    const { data, error } = await window.supabase
      .from("courses")
      .select("*")
      .ilike("title", `%${titleFromSlug}%`)
      .single();

    if (error || !data) {
      console.error('Error fetching course:', error);
      document.body.innerHTML = "Course not found";
      return;
    }

    document.getElementById("course-title").textContent = data.title;
    document.getElementById("course-description").textContent = data.description;

    const user = (await window.supabase.auth.getUser()).data.user;
    document.getElementById("course-action").textContent =
      user ? "Start Learning" : "Sign in to Enroll";
  } catch (error) {
    console.error('Error loading course:', error);
    document.body.innerHTML = "Failed to load course";
  }
}