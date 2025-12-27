// Export all services for easier imports
import * as authService from "./authService";
import * as courseService from "./courseService";
import * as lessonService from "./lessonService";
import * as progressService from "./progressService";
import * as userService from "./userService";
<<<<<<< HEAD
=======
import aiCourseService from "./aiCourseService";
>>>>>>> 73219f9bdc90257c2cd625b139c3939bc21645a3

export * from "./api";
export * from "./types";
export {
    authService,
    courseService,
    lessonService,
    progressService,
    userService,
};